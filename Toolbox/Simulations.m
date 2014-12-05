(* ::Package:: *)

(* ::Title:: *)
(*Simulations*)


(* ::Section:: *)
(*Definitions*)


Begin["Private`"]


Needs["DifferentialEquations`InterpolatingFunctionAnatomy`"]


Options[simulate]={"InitialConditions"->{},"Parameters"->{},"Events"->{},"tFinal"->Infinity,"tStart"->0,"SpeciesProfiles"->"Concentrations"};
simulate::missingIC="Missing initial conditions encountered for `1`.";
simulate::missingParam="Missing parameter values encountered for `1`.";
simulate::specProfile="The option \"SpeciesProfiles\" can be specified either as \"Concentrations\" or \"Particles\" but not as `1`";
simulate::NDSolveProblem="Something unexpected happend. Manual inspection of the ODE might be necessary.";
simulate::ignrevents="Mathematica `1` does not provide support for events. Events will be ignored.";
simulate::plld="The start time (`1`) and final time (`2`) must have distinct machine-precision numerical values.";

simulate[model_MASSmodel,opts:OptionsPattern[{simulate,NDSolve}]]:=
	Module[{repl,ode,events,initialConditions,allConstants,parameters,equations,solution,fluxSolution,tStart,tFinal,vars,units,ic,catchMissingDerivs},
		
		(* Get model information *)
		parameters=updateRules[model["Parameters"],adjustUnits[OptionValue["Parameters"],model]];
		ode=getODE[model,"Parameters"->parameters];
		If[$VersionNumber>8,
			events=updateRules[getEvents[model],OptionValue["Events"]][[All,2]],
			If[getEvents[model]=!={},
				Message[simulate::ignrevents,$VersionNumber]
			]; events={}
		];
		tStart=OptionValue["tStart"];
		tFinal=OptionValue["tFinal"];

		(*Check that tStart does not equal tFinal*)
		If[tStart==tFinal,
			Message[simulate::plld,tStart,tFinal]; Abort[];
		];

		(*Check if all initial conditions are provided*)
		ic=FilterRules[updateRules[model["InitialConditions"],adjustUnits[OptionValue["InitialConditions"],model]],model["Variables"][[All,0]]];
		{ic,parameters}=If[model["UnitChecking"],{ic,parameters},stripUnits[{ic,parameters}]];
		units=#[[1]]->If[MatchQ[#[[2]],_Unit],ReplacePart[#[[2]],1->1],1]&/@ic;
		If[
			vars=Union[Cases[model["Variables"],Append[$MASS$speciesPattern,_parameter][t],\[Infinity]]][[All,0]];
			Complement[vars,#[[All,1]]]=!={},
			Message[simulate::missingIC,Complement[vars,#[[All,1]]]];Abort[];,
			initialConditions=If[NumberQ[#[[2]]],#[[1]][0]==#[[2]],#[[1]][t/;t<=0]==#[[2]]]&/@#
		]&[stripUnits@ic];

		(* Substitute parameters *)
		{ode,initialConditions,events}={ode,initialConditions,events}//.parameters;

		(*Set initial history functions for variables that are involved with delays*)
		repl=(#[0]==val_)->#[t/;t<=0]==val&/@Union[Cases[{ode,initialConditions,events},_[t+_],\[Infinity]][[All,0]]];
		(*repl={};*)
		{ode,initialConditions,events}=stripUnits[{ode,initialConditions,events}/.repl];

		(*Run NDSolve and check for missing parameter values if NDSolve::ndnum is raised*)
		(*catchMissingDerivs=Quiet[Check[ReleaseHold[#],NSolve[DeleteCases[#[[1,1]],_[0]==_],#[[1,2]]]/.r_Rule:>(r[[1]]->With[{val=r[[2]]},FunctionInterpolation[val&[t],Evaluate[#[[1,3]]/. \[Infinity]->1*^10]]]),{NDSolve::derivs}],{NDSolve::derivs}]&;*)
		(*catchMissingDerivs=Quiet[Check[ReleaseHold[#],NSolve[DeleteCases[#[[1,1]],_[0]==_],#[[1,2]]]/.r_Rule:>(r[[1]]->With[{val=r[[2]]},FunctionInterpolation[val&[t],Evaluate[#[[1,3]]/. \[Infinity]->1*^10]]]),{NDSolve::derivs}],{NDSolve::derivs}]&;*)
		Check[
			solution=#[[1]]->(#[[2]] (#[[1]][[0]]/.Dispatch[units]))&/@
				Check[
					(*catchMissingDerivs@Hold[NDSolve[stripUnits@equations,model["Variables"],{t,tStart,tFinal},FilterRules[{opts}, Options[NDSolve]]]],*)
					Quiet[Check[
						NDSolve[{ode,initialConditions,events},model["Variables"],{t,tStart,tFinal},FilterRules[{opts}, Options[NDSolve]]],
						NDSolve[{D[ode,t],initialConditions,events},model["Variables"],{t,tStart,tFinal},FilterRules[{opts}, Options[NDSolve]]],
						{NDSolve::derivs}
					],{NDSolve::derivs}],
					Message[simulate::NDSolveProblem];Abort[];,
					{NDSolve::ndode,NDSolve::idelay,NDSolve::icfail,NDSolve::nderr,NDSolve::underdet,NDSolve::nlnum,NDSolve::overdet,NDSolve::ndinnt}
				][[1]],
		Message[simulate::missingParam,Union[Cases[equations,(_Keq|_rateconst|_parameter|metabolite[_,"Xt"]),\[Infinity]]]];Abort[],
		{NDSolve::ndnum}
	];
	fluxSolution=Thread[Rule[model["Fluxes"],getRates[model,"Parameters"->parameters]/.parameters/.solution]];
	solution=#[[1]]/.m_[t]:>m->#[[2]]&/@solution;
	solution=Switch[OptionValue["SpeciesProfiles"],
		"Concentrations",solution(*/.r_Rule/;MatchQ[r[[1]],$MASS$speciesPattern]:>r[[1]]->r[[2]]*),
		(*"Particles",solution/.r_Rule/;MatchQ[r[[1]],$MASS$speciesPattern]:>r[[1]]->r[[2]]*(parameter["Volume",getCompartment[r[[1]]]]/.parameters/.solution),*)
		"Particles",conc2particles[solution,model],
		_,Message[simulate::specProfile,OptionValue["SpeciesProfiles"]];Abort[];
	];
	{solution,fluxSolution}
];

simulate[model_MASSmodel,{t_Symbol,tMin_?NumberQ,tMax_?NumberQ},opts:OptionsPattern[]]:=Module[{},
	simulate[model,Sequence@@updateRules[List[opts],{"tStart"->tMin,"tFinal"->tMax}]]
];


Options[findSteadyState]=updateRules[{"Strategy"->FindRoot,"CheckSteadyState"->True,"CheckStability"->False,"Parameters"->{},"InitialConditions"->{},Tolerance->1*^-6},Options[FindRoot],Options[simulate]];
findSteadyState::noSsReached="The system didn't reach steady state. `1`";
findSteadyState::unstable="The steady state found is unstable. The largest eigenvalue (by real part) is `1`.";
findSteadyState::unknownStrategy="`1` is not a valid strategy, try FindRoot or simulate instead.";
findSteadyState::specProfile="The option \"SpeciesProfiles\" can be specified either as \"Concentrations\" or \"Particles\" but not as `1`";
findSteadyState[model_MASSmodel,opts:OptionsPattern[]]:=Module[{eq,var,rosetta,param,ic,sol,eigenvalues,units,fluxSol,error,errors,ode},
	param=updateRules[model["Parameters"],adjustUnits[OptionValue["Parameters"],model]];
	ic=updateRules[model["InitialConditions"],adjustUnits[OptionValue["InitialConditions"],model]];
	{ic,param}=If[model["UnitChecking"],{ic,param},stripUnits[{ic,param}]];
	units=Replace[ic,(_?NumberQ|-\[Infinity]|\[Infinity])->1,3];
	sol=Switch[OptionValue["Strategy"],
		FindRoot,
		var=stripUnits[Thread[{model["Variables"][[All,0]],model["Variables"][[All,0]]/.ic}]];
		eq=stripUnits[model["ODE"][[All,2]]/.Derivative[1][_][t]->0/.param/.m_[t]:>m];
		sol=Quiet[anonymize[FindRoot[eq,var,Evaluate[Sequence@@FilterRules[List[opts],Options[FindRoot]]]]],{FindRoot::lstol}];
		sol=#[[1]]->(#[[2]] (#[[1]]/.Dispatch[units]))&/@sol;
		fluxSol=Thread[Rule[model["Fluxes"],model["Rates"]/.elem_[t]:>elem/.param/.sol]];
		sol=Switch[OptionValue["SpeciesProfiles"],
			"Concentrations",sol,
			"Particles",conc2particles[sol,model],
			_,Message[findSteadyState::specProfile,OptionValue["SpeciesProfiles"]];Abort[];
		];
		{sol,fluxSol}
		,
		simulate,
		Quiet[simulate[model,Sequence@@FilterRules[List[opts],Options[simulate]]]/.i_InterpolatingFunction[t]:>i[InterpolatingFunctionDomain[i][[1,2]]],{NDSolve::mxst}]
		,
		_,Message[findSteadyState::unknownStrategy,OptionValue["Strategy"]];Abort[];
	];
	If[OptionValue["CheckSteadyState"],
		ode=model["ODE"];
		If[(error=Total[(errors=Abs[Chop[ode[[All,2]]/.elem_[t]:>elem/.stripUnits[param]/.stripUnits[sol[[1]]]]])])>OptionValue["Tolerance"],
			Message[findSteadyState::noSsReached,Thread[Equal[ode[[All,1]],errors]]&[model]];Abort[];
		];
		(*If[(error=Total[Abs[Chop[model.(model["Fluxes"]/.stripUnits[sol[[2]]])]]])>OptionValue["Tolerance"],
			Message[findSteadyState::noSsReached,Thread[Equal[D[(#[t]&/@#["Species"]),t],Chop[#.(#["Fluxes"]/.sol[[2]])]]]&[model]];Abort[];
		];*)
	];
	If[OptionValue["CheckStability"],
		eigenvalues=Chop@Eigenvalues[J[model]/.stripUnits[param]/.stripUnits[sol[[1]]]];
		If[Max[Re[eigenvalues]]>0,Message[findSteadyState::unstable,Max[Re[eigenvalues]]];Abort[]];
	];
	sol
];


Options[solveSteadyState]={"Numeric"->True};
solveSteadyState[model_MASSmodel,opts:OptionsPattern[]]:=Module[{ssEq,conservationRelations,ssSol,nonNegativity},
	ssEq=model["ODE"]/.Derivative[1][_metabolite][t]:>0/.elem_[t]:>elem;
	conservationRelations=MapIndexed[C[First@#2]==#&,NullSpace[model\[Transpose]].model["Species"]];
	nonNegativity=0<=#&/@model["Species"];
	ssSol=anonymize[NSolve[Join[ssEq/.stripUnits@model["Parameters"],conservationRelations,nonNegativity],model["Species"],Reals]];
	If[OptionValue["Numeric"]==True,
		ssSol=ssSol/.model["Parameters"];
	];
	{ssSol,Rule@@@conservationRelations}
];


(* ::Subsection::Closed:: *)
(*End*)


End[]
