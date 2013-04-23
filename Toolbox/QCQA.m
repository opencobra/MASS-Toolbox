(* ::Package:: *)

(* ::Title:: *)
(*QCQA*)


(* ::Section:: *)
(*Definitions*)


Begin["`Private`"]


getMissingParameters[model_MASSmodel,rates_List]:=Union[Cases[rates/.model["Parameters"],$MASS$parametersPattern,\[Infinity]]];


getMissingInitialConditions[model_MASSmodel,rates_List]:=Union[Cases[rates/.model["InitialConditions"],Join[$MASS$parametersPattern,$MASS$speciesPattern][t],\[Infinity]]];


getSuperfluous[model_MASSmodel]:=Module[{ode},
	ode=model["ODE"];
	Select[model["Parameters"],!MemberQ[ode,#[[1]],\[Infinity]]&]
];


Options[qcqa]={"MissingParameters"->True,"MissingInitialConditions"->True,"SuperfluousParameters"->True,"Rates"->True,"ODE"->True,"MissingParameterStyle"->(Style[#,Background->Red,Bold]&),"MissingInitialConditionStyle"->(Style[#,Background->Orange,Bold]&)};
qcqa[model_MASSmodel,opts:OptionsPattern[]]:=Module[{missingParameters,pane,grid,rates,missingIC,$MAXROWS,report,prune,superfluousParam,rateWithMissingParamAndIC,odeWithMissingParamAndIC},
	$MAXROWS=50;
	prune=If[Length[#]>$MAXROWS,Join[#[[1;;$MAXROWS]],{{SpanFromLeft,ToString[Length[#]-$MAXROWS]<>" rows omitted!",SpanFromBoth}}],#]&;
	pane=Pane[#,{{800},{600}},Scrollbars->{True,True}]&;
	grid=Grid[prune@#,Dividers->{True,All},Background->{None,{{GrayLevel[.99],LightBlue}}},Spacings->{1,1}]&;
	report={};
	rates=Join[model["Rates"],model["CustomODE"]];

	If[OptionValue["MissingParameters"]===True,
		missingParameters=getMissingParameters[model,rates];
		If[missingParameters=!={},
			AppendTo[report,"Missing parameters"->pane@grid@Join[{{"Parameter","Rate equation(s)"}},Table[{p,Column[Select[rates,MemberQ[#,p]&]]/.p:>OptionValue["MissingParameterStyle"][p]},{p,missingParameters}]]];
		];
	];

	If[OptionValue["MissingInitialConditions"]===True,
		missingIC=getMissingInitialConditions[model,rates];
		If[missingIC=!={},
			AppendTo[report,"Missing initial conditions"->pane@grid@Join[{{"Variable","Rate equation(s)"}},Table[{ic,Column[prune@Select[rates,MemberQ[#,ic,\[Infinity]]&]]/.ic:>OptionValue["MissingInitialConditionStyle"][ic]},{ic,missingIC}]]];
		];
	];

	If[OptionValue["SuperfluousParameters"]===True,
		superfluousParam=getSuperfluous[model];
		If[superfluousParam=!={},
			AppendTo[report,"Superfluous parameters"->pane@grid@(List@@@superfluousParam)];
		];
	];

	If[OptionValue["Rates"]===True,
		rateWithMissingParamAndIC=Select[rates/.Join[(#->OptionValue["MissingInitialConditionStyle"][#]&/@missingIC),(#->OptionValue["MissingParameterStyle"][#]&/@missingParameters)],MemberQ[#,_Style,\[Infinity]]&];
		If[rateWithMissingParamAndIC=!={},
			AppendTo[report,"Rates with missing parameters and initial conditions"->pane@grid@Partition[rateWithMissingParamAndIC,1]];
		];
	];

	If[OptionValue["ODE"]===True,
		odeWithMissingParamAndIC=Select[model["ODE"]/.Join[(#->OptionValue["MissingInitialConditionStyle"][#]&/@missingIC),(#->OptionValue["MissingParameterStyle"][#]&/@missingParameters)],MemberQ[#,_Style,\[Infinity]]&];
		If[rateWithMissingParamAndIC=!={},
			AppendTo[report,"ODEs with missing parameters and initial conditions"->pane@grid@Partition[odeWithMissingParamAndIC,1]];
		];
	];
	If[report==={},
		Panel["No issues detected :-)"],
		MenuView[report,ImageSize->Automatic]
	]
];


(* ::Subsection:: *)
(*End*)


End[]
