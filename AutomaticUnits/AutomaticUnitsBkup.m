(* Mathematica Package *)
(* :Title: Units *)
(*Author: Jon McLoone*)
(* :Summary: This package provides automatic handling and conversion between different units systems*)
(* :Package Version: 1.0 *)
(* :Copyright: Copyright 2010, Wolfram Research, Inc. *)
(* :Context: AutomaticUnits` *)
(* :History: Originally developed for CalculationCenter, and Mathematica CalcCenter, this version is modified and extended for use in standard Mathematica*) 
(* :Keywords: *)
(* :Source Mathematica 5.0 Miscellaneous Units package and Mathematica 7.0 AutomaticUnits` package.
Their original source was: 
	CRC Handbook of Chemistry and Physics, 69th Edition, 1988-1989.
	CRC Handbook of Chemistry and Physics, 75th Edition, 1995.
	Kaye & Laby, Allen, World Almanac, etc.
    Taylor, Barry N., Guide for the Use of the International System of
        Units, National Institute of Standards and Technology Special
        Publication 811, 1995 Edition.
        
    Additional values from Wikipedia
*)

BeginPackage["AutomaticUnits`"];

(*Error messages*)
Unit::exists="Existing definition for Unit `1` has been changed";
Unit::notunit="The declared value `1` is not a unit";
Unit::"incomp"="Unit `1` cannot be added to a number";
Unit::"incomp1"="Units `1` are not compatible";
Unit::incomp2="Cannot convert to incompatible unit";
Unit::noavailableunit="The preferred unit set does not contain a unit compatible with `1`.";
UnitSet::noset="UnitSet `1` is not a known set of units.";
UnitSet::nounits="UnitSet `1` is not a valid unit set.";
UnitList::nounits="No target units are not compatible with `1`."

(*Usage messages and export public symbols*)
Convert::usage=" Convert [\!\(\*StyleBox[RowBox[{\" \", \"expr\", \" \"}], \" TI \"]\), \!\(\*
StyleBox[RowBox[{\" \", \"newunits\", \" \"}], \" TI \"]\)] converts \!\(\*
StyleBox[RowBox[{\" \", \"expr\", \" \"}], \" TI \"]\) to a form involving a \
combination of units \!\(\*StyleBox[RowBox[{\" \", \"newunits\", \" \"}], \" TI \"]\).";
SI::usage=" SI [\!\(\*StyleBox[RowBox[{\" \", \"expr\", \" \"}], \" TI \"]\)] converts \!\(\*
StyleBox[RowBox[{\" \", \"expr\", \" \"}], \" TI \"]\) to SI units (International System).";
ConvertTemperature::usage=" ConvertTemperature [\!\(\*StyleBox[RowBox[{\" \", \"temp\", \" \"}], \" TI \"]\), \!\(\*
StyleBox[RowBox[{\" \", \"oldscale\", \" \"}], \" TI \"]\), \!\(\*StyleBox[RowBox[{\" \", \"newscale\", \" \"}], \" TI \"]\)] converts \
temperature \!\(\*StyleBox[RowBox[{\" \", \"temp\", \" \"}], \" TI \"]\) from temperature scale \
\!\(\*StyleBox[RowBox[{\" \", \"oldscale\", \" \"}], \" TI \"]\) to scale \!\(\*
StyleBox[RowBox[{\" \", \"newscale\", \" \"}], \" TI \"]\).";

MKS::usage=" MKS [\!\(\*StyleBox[RowBox[{\" \", \"expr\", \" \"}], \" TI \"]\)] converts \!\(\*
StyleBox[RowBox[{\" \", \"expr\", \" \"}], \" TI \"]\) to MKS units (meter/kilogram/second)."

CGS::usage=" CGS [\!\(\*StyleBox[RowBox[{\" \", \"expr\", \" \"}], \" TI \"]\)] converts \!\(\*
StyleBox[RowBox[{\" \", \"expr\", \" \"}], \" TI \"]\) to CGS units (centimeter/gram/second).";

(*Public symbols*)
Unit::usage="Unit[value, name] represents a physical quantity in name units.";
FundamentalUnits::usage="FundamentalUnits[expr] converts expr into fundamental units.";
DeclareUnit::usage="DeclareUnit[name,value] defines a new unit name in terms of a value expressed in existing units";
UnitSet::usage="UnitSet[name] gives a list of units that are members of the named set. UnitSet[] returns a list of available set names.";
DropUnits::usage="DropUnits[expr] converts all units in expr to numbers";
CreateSymbol::usage="CreateSymbol is an option for DeclareUnit to specify whether a symbol is created for unit entry or whether the unit must be specified as Unit[value, name].";
UsageMessage::usage="UsageMessage is an option for DelcareUnit which specifies a usage message for the unit symbol";
$DefaultUnitSet::usage="$DefaultUnitSet is the name of the unit set from which automatic unit choices are made";
SimplifyUnits::usage="SimplifyUnits[expr] attempts to replace composite units with single named units."
UnitList::usage="ToUnitsList[oldunit,{newunit1,newunit2,...}] decomposes oldunit into newunits such that the sum of newunits is equivelant to the oldunit."

(*Assign multiplier values- mainly for compatibility with the old units pacakge*)
Percent = 1/100;Gross = 144;Dozen = 12; BakersDozen = 13; Mole = 6.0221367*10.^23;Yotta = 10^24; 
Zetta = 10^21; Exa = 10^18; Peta = 10^15; Tera = 10^12; Giga = 10^9; Mega = 10^6; Kilo = 10^3; 
Hecto = 100; Deca = 10; Deci = 1/10; Centi = 1/10^2; Milli = 1/10^3; Micro = 1/10^6; Nano = 1/10^9; 
Pico = 1/10^12; Femto = 1/10^15; Atto = 1/10^18; Zepto = 1/10^21; Yocto = 1/10^24; Percent=1/100;
Gross=144; Dozen=12; BakersDozen=13; Mole=6.0221415*^23;



Begin["`private`"];

(*Lists that store the unit coversion rules*)
$ToFundamental={};
$ExactUnitRules={};

(*Background behaviour of UnitSet*)
UnitSet["All"]={};
$DefaultUnitSet="SI";
UnitSet[]:= Quiet[Cases[#[[1, 1, 1]] & /@ DownValues[UnitSet], _String]];
UnitSet[name_]:=(Message[UnitSet::noset,name];{});
SyntaxInformation[UnitSet]={"ArgumentsPattern"->{_.}};

(*FundamentalUnits is a core function for reducing a unit expression to its lowest units*)
Unprotect[FundamentalUnits];
FundamentalUnits[expr_]:=
    expr/.Unit[n_,dims_]:>Unit[n,PowerExpand[dims/.$ToFundamental]];
Protect[FundamentalUnits];

(*Declare new unit in terms of old unit. User function but also used to create the intitial built in units*)
Unprotect[DeclareUnit];

DeclareUnit[name_String,val_Unit,OptionsPattern[]]:=
Block[{dispatchedq,existingrules,existingexactrules,msg},
	msg=If[OptionValue[UsageMessage]===Automatic,
			name<>" is a user defined unit"<>If[StringQ[#]," of "<>ToLowerCase[#]<>".","."]&@UnitToDimension[val],
			OptionValue[UsageMessage]
			];
		Which[
			Head[$ToFundamental]===Dispatch,existingrules=First[$ToFundamental];dispatchedq=True,
			Head[$ToFundamental]===List,existingrules=$ToFundamental,
			True,existingrules={}];
		(*If unit name is already decalared, issue warning and over-write definition*)
		If[MemberQ[existingrules[[All,1]],name],
					Message[Unit::exists,name];
					existingrules=DeleteCases[existingrules,HoldPattern[Rule[name,_]]]
			];		
		
				(*Store the rule for converting to fundamental*)	
			existingrules=Append[existingrules/.#,#]&[name->Apply[Times,FundamentalUnits[val]]];
					
		(*Store the new rule sets, Dispatched if appropriate*)
		$ToFundamental=If[TrueQ[dispatchedq],Dispatch,Identity][existingrules];
			
		
		(*If relationship is exact, store it explicitely *)
		If[Precision[val[[1]]]===Infinity,
			Which[
				Head[$ExactUnitRules]===Dispatch,existingexactrules=First[$ExactUnitRules];dispatchedq=True,
				Head[$ExactUnitRules]===List,existingexactrules=$ExactUnitRules,
				True,existingrules={}
				];
			existingexactrules=Append[existingexactrules/.#,#]&[name->Apply[Times,val/.existingexactrules]];
		(*Store the new rule sets, Dispatched if appropriate*)
		$ExactUnitRules=If[TrueQ[dispatchedq],Dispatch,Identity][existingexactrules]];

		
		If[OptionValue[CreateSymbol],
			Unprotect[name];
			Clear[name];
			(#::usage=msg)&[Symbol[Context[]<>name]];
			(Unit::name=msg);
			(*Make the name parse as a unit from in StandardForm or TraditionalForm*)
			UnitSymbolQ[name] = True; 
			StringToUnitSymbol[name];
			Protect[name]];
		
		If[OptionValue[TraditionalLabel]=!=None,
			SetTraditionalNotation[name,OptionValue[TraditionalLabel]]
			];
		UnitSet["All"]=Union[Append[If[Head[UnitSet["All"]]==List,UnitSet["All"],{}],Unit[name]]];
	Unit[1,name]];
	
DeclareUnit[name_String,opts:OptionsPattern[]]:=DeclareUnit[name,Unit[1,name],opts]; (*Base units can be declared to create symbols only*)
	
(*Fail if unit is declared in terms of something that is not a unit*)

(*When many units are going to be defined at the same time, we can optimize the cleaning of the unit lists,
application of Dispatch by doing it just once at the end. This gives much faster package initialization*)
FastGroupDeclareUnit[expr_]:=Block[{$UnitInitialization=True,newfund,newexact,junk},
	(*Make sure that the tables are plain lists*)
					If[Head[$ToFundamental]===Dispatch,$ToFundamental=First[$ToFundamental]];
					If[Head[$ToFundamental]===List,$ToFundamental={}];
					If[Head[$ExactUnitRules]===Dispatch,$ExactUnitRules=First[$ExactUnitRules]];
					If[Head[$ExactUnitRules]===List,$ExactUnitRules={}];
					
					(*expr should be a CompoundExpression of DeclareUnit expressions*)
					{junk, {{newfund}, {newexact}}}=Reap[expr,{"approx","exact"}];
	(*expr should be a CompoundExpression of DeclareUnit expressions*)
	(*Clean and Dispatch lists once all units are declared*)
					$ToFundamental=Dispatch[SimplifyUnitRules[Join[$ToFundamental,newfund]]];
					$ExactUnitRules=Dispatch[SimplifyUnitRules[Join[$ExactUnitRules,newexact]]];
								];
SetAttributes[FastGroupDeclareUnit,HoldAll];

DeclareUnit[name_String,val_Unit,OptionsPattern[]]/;TrueQ[$UnitInitialization]:=
Block[{dispatchedq,existingrules,existingexactrules,msg},
	msg=If[OptionValue[UsageMessage]===Automatic,name<>" is a user defined unit",OptionValue[UsageMessage]];
		
			
		(*If unit name is already decalared, issue warning and over-write definition*)
		(*Disabled error checking for fast load
		If[MemberQ[$ToFundamental[[All,1]],name],
					Message[Unit::exists,name];
					$ToFundamental=DeleteCases[$ToFundamental,HoldPattern[Rule[name,_]]]
			];	*)	
		
				(*Store the rule for converting to fundamental*)	
			(*AppendTo[$ToFundamental,name->Apply[Times,val]];*)
			Sow[name->Apply[Times,val],"approx"];
				
		(*If relationship is exact, store it explicitely *)
		If[MatchQ[val[[1]],_Integer|_Rational|_Symbol], Sow[name->Apply[Times,val],"exact"]];
		
		If[OptionValue[CreateSymbol],
			Unprotect[name];
			Clear[name];
			(#::usage=msg)&[Symbol[Context[]<>name]];
			(Unit::name=msg);
			(*Make the name parse as a unit from in StandardForm or TraditionalForm*)
			UnitSymbolQ[name] = True; 
			(*Make the symbol name evaluate to a Unit*)
			StringToUnitSymbol[name];
			Protect[name]];
		
		If[OptionValue[TraditionalLabel]=!=None,
			SetTraditionalNotation[name,OptionValue[TraditionalLabel]]
			];
		UnitSet["All"]=Union[Append[If[Head[UnitSet["All"]]==List,UnitSet["All"],{}],Unit[name]]];
	Unit[1,name]];

	

(*Fail if unit is declared in terms of something that is not a unit*)


(*ToDO: If we are not going to have interpretation boxes in output then CreateSymbol->False needs to override that
If we are then the paste of context name is a problem in standard form*)
DeclareUnit[name_String,val_,OptionsPattern[]]:=(Message[Unit::notunit,val];val);
Options[DeclareUnit]={CreateSymbol->True,TraditionalLabel->None,UsageMessage->Automatic};
SyntaxInformation[DeclareUnit] = {"ArgumentsPattern" -> {_, _., OptionsPattern[]}};
Protect[DeclareUnit];

Unprotect[DropUnits];
DropUnits[expr_]:=expr//.Unit[n_,un_]->n;
Protect[DropUnits];


(*==============================  Notation  ============================*)
AutomaticUnits`$UnitOutputForm="Powers"; (*alternatives "StandardForm","Linear" or "Powers"*)
AutomaticUnits`$UnitInteractiveOutput=False; (*These preferences should persist between sessions*)

(*Create a symbol that holds the Unit structure of a named unit*)
StringToUnitSymbol[str_String]:=(Clear[str];Evaluate[ToExpression[Context[]<>str]]=Unit[1,str]);

(*Make input of symbol names parse immediately as a Unit expression*)
UnitSymbolQ[_]=False;
MakeExpression[name_String?UnitSymbolQ, form_]:=MakeExpression[RowBox[{"Unit","[",RowBox[{"1",",",#}],"]"}],form]&[ToString[name,InputForm]];
MakeExpression[RowBox[{a___,name_String?UnitSymbolQ,b___}],form_]:=MakeExpression[
													RowBox[{a,RowBox[{"Unit","[",RowBox[{"1",",",#}],"]"}],b}]
																		,form]&[ToString[name,InputForm]];
																		
(*We don't want strings inside the unit description to format as strings. 
This is not necessary if Units are not represented as functions of strings*)

(*SetTraditionalNotation[name_,label_]:=MakeBoxes[UnitString[name],TraditionalForm]=TooltipBox[StyleBox[label,ShowAutoStyles -> False],name,LabelStyle->"TextStyling"]*)


$TraditionalUnitNameRules={};
SetTraditionalNotation[name_,label_]:=AppendTo[$TraditionalUnitNameRules,name->label];
MakeBoxes[UnitString[name_String],TraditionalForm]:=TooltipBox[StyleBox[name/.$TraditionalUnitNameRules,ShowAutoStyles -> False,FontSlant->Plain],name,LabelStyle->"TextStyling"];
MakeBoxes[UnitString[x_String], form_] := x;

(*StrictPower always formats as a superscript even if the power is negative, and sorts products so that negative powers come last*)
MakeBoxes[Times[a___,b_StrictPower,c___],form_]:=Block[{sp},
				sp=Append[Cases[{a,c},_StrictPower],b];
				RowBox[MakeBoxes[#,form]&/@Join[DeleteCases[{a,c},_StrictPower],Sort[sp,(#1[[2]]>#2[[2]])&]]]];
								
MakeBoxes[StrictPower[x_,y_],form_]:=SuperscriptBox[MakeBoxes[x,form],MakeBoxes[y,form]];


MakeBoxes[Times[a___,b_NegativeLinearPower,c___],form_]:=Block[{nlp},
				nlp=Append[Cases[{a,c},_NegativeLinearPower],b];
				RowBox[{MakeBoxes[#1,form],"/",If[Length[nlp]>1,
													RowBox[{"(",MakeBoxes[#2,form],")"}],
													MakeBoxes[#2,form]
													]}]&[
								Apply[Times,DeleteCases[{a,c},_NegativeLinearPower]],
								Apply[Times,nlp]/.NegativeLinearPower[q_,w_]->Power[q,-w]
								]];
MakeBoxes[NegativeLinearPower[a_,-1],form_]:=RowBox[{1,"/",MakeBoxes[a,form]}];
MakeBoxes[NegativeLinearPower[a_,b_],form_]:=RowBox[{1,"/",MakeBoxes[Power[a,#],form]&[-b]}];

SetAttributes[NegativeLinearPower,HoldAllComplete];
SetAttributes[StrictPower,HoldAllComplete];
SetAttributes[InvisibleHold,HoldAllComplete];

MakeBoxes[InvisibleHold[expr_],form_]:=MakeBoxes[expr,form];




Unit /: MakeBoxes[Unit[1, un_], form_] := InterpretationBox[#, Unit[1, un], AutoDelete->True]&[
				Switch[AutomaticUnits`$UnitOutputForm,
					"Linear",Function[{arg},MakeBoxes[arg,form]][#/.Power[a_,b_]/;b<0->NegativeLinearPower[a,b]],
					"Powers",Function[{arg},MakeBoxes[arg,form]][#/.Power->StrictPower],
					"StandardForm",MakeBoxes[#, form],
					_,MakeBoxes[#, form]] &[InvisibleHold[un] /. x_String -> UnitString[x]]
				];
				
				
Unit /: MakeBoxes[Unit[n_, un_], form_] := InterpretationBox[RowBox[{#1," ",#2}], Unit[n, un], AutoDelete->True]&[
				If[Head[Unevaluated[n]]===Plus,
					RowBox[{"(",MakeBoxes[n,form],")"}],
					MakeBoxes[n, form]
				],
				Switch[AutomaticUnits`$UnitOutputForm,
					"Linear",Function[{arg},MakeBoxes[arg,form]][#/.Power[a_,b_]/;b<0->NegativeLinearPower[a,b]],
					"Powers",Function[{arg},MakeBoxes[arg,form]][#/.Power->StrictPower],
					"StandardForm",MakeBoxes[#, form],
					_,MakeBoxes[#, form]] &[InvisibleHold[un] /. x_String -> UnitString[x]]
				];

(*Support for mouse driven conversion*)				
Unit /: MakeBoxes[Unit[n_, un_], form_] /;   AutomaticUnits`$UnitInteractiveOutput && Not[TrueQ[iflag]] := 
 Function[{arg},InterpretationBox[arg,Unit[n,un]]][MakeBoxes[DynamicModule[{val = NoInteractive[Unit[n, un]]},
     ActionMenu[Dynamic[val], #, Appearance -> None],Initialization:>Needs["AutomaticUnits`"]], form] &[
     (NoInteractive[#] :> (val = NoInteractive[Convert[Unit[n, un], #]])) & /@ CompatibleUnitsFromSet["InteractiveChoices", Unit[1,un]]]];
     
MakeBoxes[NoInteractive[expr_], form_] := Block[{iflag = True}, MakeBoxes[expr, form]];

SyntaxInformation[Unit] = {"ArgumentsPattern" -> {_,_.,OptionsPattern[]}};

(*TODO: Move to FE Templates to improve copy paste especially for interactive output?*)


(*==============================  Utility functions  ============================*)
(*Utility function for quick declaration of prefixed SI symbols*)
SIPrefixify[name_String, dim_String, label_String] := Map[
  DeclareUnit[#[[1]] <> ToLowerCase[name], Unit[#[[2]], name], 
    UsageMessage -> #[[1]] <> ToLowerCase[name] <> " is a prefixed SI unit of " <> 
      dim <> ".", TraditionalLabel -> #[[3]] <> label] &,
  {{"Yotta", 10^24, "Y"},
   {"Zetta", 10^21, "Z"},
   {"Exa", 10^18, "E"},
   {"Peta", 10^15, "P"},
   {"Tera", 10^12, "T"},
   {"Giga", 10^9, "G"},
   {"Mega", 10^6, "M"},
   {"Kilo", 10^3, "k"},
   {"Hecto", 100, "h"},
   {"Deca", 10, "da"},
   {"Deci", 1/10, "d"},
   {"Centi", 1/10^2, "c"},
   {"Milli", 1/10^3, "m"},
   {"Micro", 1/10^6, "\[Micro]"},
   {"Nano", 1/10^9, "n"},
   {"Pico", 1/10^12, "p"},
   {"Femto", 1/10^15, "f"},
   {"Atto", 1/10^18, "a"},
   {"Zepto", 1/10^21, "z"},
   {"Yocto", 1/10^24, "y"}}];

(*Test whether a list of units are dimensionally equivelent*)
CompatibleUnitQ[Unit[_, un_]..]:=True;
(*faster test when all the same unit*)

(*General test*)
CompatibleUnitQ[a__Unit]:=Block[{differentunits=Union[{a}/.Unit[_,un_]->Unit[1,un]]},
        	Which[
    		Apply[And,NumericQ/@#],True,
    		Apply[SameQ,Map[Last,#]],True,
    		True,Message[Unit::"incomp1",differentunits];False]&[
    			FundamentalUnits[differentunits]]];
    		
CompatibleUnitQ[{a__Unit}]:=CompatibleUnitQ[a];
CompatibleUnitQ[a___]/;FreeQ[{a}, Unit, Infinity]:=True; (*When no units are present*)
CompatibleUnitQ[a___]:=False;(*Mix of units and non units*)

GetPreferredUnits[]:=Which[
					MatchQ[#,_String],UnitSet[#],
					MatchQ[#,{__Unit}],#,
					True,Message[UnitSet::nounits,#];UnitSet["SI"]]&[$DefaultUnitSet];



(* ======================= Conversions ===========================*)

Convert[Unit[n1_,un1_], Unit[n_, un_]] :=Block[{exactconversion},
	(*If input is exact, test for an exact conversion*)
	If[Precision[n1]==Infinity,	exactconversion=(Unit[n1,un1]/Unit[1,un])/.$ExactUnitRules];
	If[NumericQ[exactconversion],
		exactconversion Unit[1,un],(*If there is an exact conversion, use it*)

   		If[ NumericQ[#](*Could alternatively test FreeQ[#1,Unit]*), 
   			Unit[1, un]*#1, 
     		Message[Unit::incomp2]; Unit[n1,un1]
    		] & [FundamentalUnits[Unit[n1,un1]/Unit[1,un]]]
    	]];



Convert[expr_List,target_]:=Convert[#,target]&/@expr;

Convert[expr:{__Unit}]:=If[CompatibleUnitQ[expr],Convert[expr,Mean[expr]],expr];
Convert[expr_,_]:=expr;

Convert[currentunit_,setname_String]:=Convert[currentunit,UnitSet[setname]];
	
Convert[currentunit_Unit,target:{__Unit}]:=Block[
	{ce,cf,unitlist},
	(*Test for exact cancellation only if input is exact*)
	If[Precision[currentunit[[1]]]===Infinity,ce=currentunit/.$ExactUnitRules];
	Which[
		NumericQ[ce],ce,
		
		(*Test for inexact cancellation in all cases*)
		cf=FundamentalUnits[currentunit];
		NumericQ[cf],cf,	
		(*find compatible units in the target list to the entire composite unit*)
		unitlist=Select[target,(FundamentalUnits[#][[2]]===cf[[2]])&];
		Length[unitlist]===0,
		(*If fail then try converting components individually.*)
		If[MatchQ[cf[[2]],_String],
			(*If there are no components, fail*)
			Message[Unit::noavailableunit,cf[[2]]];currentunit,
			
			cf[[1]] Apply[Times,ToObjectPower[cf[[2]]]/.HeldPower[un_,p_]:>Convert[Unit[1,un],target]^p]],
			
		(*Convert to the most appropriate*)
		True,
			First[Sort[
				Map[ Convert[currentunit,#]&,unitlist],
            	(Abs[Log[10,Abs[First[#1]]]]<Abs[Log[10,Abs[First[#2]]]])&
            		]          	
		]]];

SyntaxInformation[Convert] = {"ArgumentsPattern" -> {_, _.}};

(*Legacy functions from the old Units package*)
SI[un_]:=Convert[un,UnitSet["SI"]];
SyntaxInformation[SI] = {"ArgumentsPattern" -> {_}};
CGS[un_]:=Convert[un,UnitSet["CGS"]];
SyntaxInformation[CGS] = {"ArgumentsPattern" -> {_}};
MKS[un_]:=SI[un];(*In old units package MKS is the same as SI, here we actually do give MKS units*)
SyntaxInformation[MKS] = {"ArgumentsPattern" -> {_}};

UnitList[a_Unit, set_String]:=ToUnitsList[a,UnitSet[set]];
UnitList[a_Unit, {b__Unit}] := 
 Block[{units = Select[{b},FreeQ[FundamentalUnits[#/a],Unit]&], remain = Abs[a], result = {}, cands,converted},
 	If[Length[units]==0,Message[UnitsList::nounits,a];a,
 		
  While[Length[units] > 0&&First[remain]!=0,
   converted = ({#, First[#]} & /@ (Convert[remain, #] & /@ units));
   cands = 
    SortBy[DeleteCases[converted, {_, n_} /; Abs[n] < 1], Abs[Last[#]] &];
   Which[
   	(*Multiple possible units, use the largest possible unit*)
    Length[cands] > 1,
    	AppendTo[result, Floor[cands[[1, 1]]]];
    	remain = remain - Floor[cands[[1, 1]]];
    	units = DeleteCases[units, Unit[_, name_] /; name === cands[[1, 1, 2]]],
    	
    (*One unit with value >1 convert all the remainder into that unit*)
    Length[cands] == 1,
    	AppendTo[result, cands[[1, 1]]];
    	remain = remain - cands[[1, 1]];
    	units = {},
    
    (*No full units for remainder -- use smallest unit*)	
    Length[cands] == 0,
    	AppendTo[result, 
     Convert[remain, SortBy[converted, Abs[Last[#]] &][[-1, 1]]]];
    	units = {}
    ]
   ];
   (*Replace the sign and merge multiple uses of the same unit*)
  Sign[a] result /. {q___, Unit[n1_, name_], w___, Unit[n2_, name_], 
     e___} -> {q, Unit[n1 + n2, name], w, e}]];
SyntaxInformation[UnitList] = {"ArgumentsPattern" -> {_, _.}};
     (*TODO: Test this and add error message*)
  

(*Temperature conversion that is not part of a compound unit needs special handling for 
Celsius and Fahrenheit that do not have an origin at absolute zero*)
ConvertTemperature[Unit[a_,b:"Rankine"|"Kelvin"],Unit[c_,d:"Rankine"|"Kelvin"]]:=Convert[Unit[a,b],Unit[c,d]];
ConvertTemperature[Unit[a1_,un1:("Celsius"|"Centigrade")],Unit[a2_,un2:("Celsius"|"Centigrade")]]:=Convert[Unit[a1,un1],Unit[a2,un2]];
ConvertTemperature[Unit[a_,un:("Celsius"|"Centigrade")],b_]/;CompatibleUnitQ[Unit[a,un],b]:=ConvertTemperature[Unit[a+27315/100,"Kelvin"],b]
ConvertTemperature[b_,Unit[a_,un:("Celsius"|"Centigrade")]]/;CompatibleUnitQ[Unit[a,un],b]:=ConvertTemperature[b,Unit[a,"Kelvin"]]/.Unit[f_,"Kelvin"]:>Unit[f-27315/100,un]
ConvertTemperature[Unit[a_,"Fahrenheit"],b_]/;CompatibleUnitQ[Unit[a,"Fahrenheit"],b]:=ConvertTemperature[Unit[a+45967/100,"Rankine"],b]
ConvertTemperature[b_,Unit[a_,"Fahrenheit"]]/;CompatibleUnitQ[Unit[a,"Fahrenheit"],b]:=ConvertTemperature[b,Unit[a,"Rankine"]]/.Unit[f_,"Rankine"]:>Unit[f-45967/100,"Fahrenheit"]
SyntaxInformation[ConvertTemperature] = {"ArgumentsPattern" -> {_,_}};
ConvertTemperature[n_,old_,new_]:=ConvertTemperature[n old, new]; (*Legacy syntax from Mathematica 7 package*)

(*Internal utility function to put columns of a matrix into common units and strip out the units*)
ColumnConvert[data_List]/;(TensorRank[data]==2):=Reap[
	Transpose@Map[If[FreeQ[#,Unit],
			Sow[None];#,
			Function[{arg},Sow[arg[[1,2]]];First/@arg][Convert[#]]]&,
		Transpose[data]]];





(*====================Unit object behaviour ==================*)

Unit[un_]/;Not[FreeQ[un,_String]]:=Unit[1,un]; (*Convenience for faster InputForm entry*)
Unit[]=Unit["Indeterminate" ]; (*Not meaningful*)

(*Structural corrections. Simplify nested units*)
Unit[n_?NumericQ, Unit[m_?NumericQ,dims_]]:=Unit[n m, dims];
Unit[n_?NumericQ,a__ Unit[m_?NumericQ,dims_]]:=Unit[n m,a dims];
Unit[n_List,un_]:=Unit[#,un]&/@n;



(*Dimensionless quantities discard their Unit head*)
Unit/:Unit[n_,u_Real]:=n u ;
Unit/:Unit[n_,u_Integer]:=n u ;
Unit/:Unit[n_,u_Rational]:=n u ;
Unit/:Unit[n_,u_Complex]:=n u ;
Unit/:Unit[n_,u_Symbol?NumericQ]:=n u ;
Unit/:Unit[n_,u_Power?NumericQ]:=n u ;

(*==============Add rules for built in Mathematica functions handling of units====================*)

(*=====================Times==================================*)
Unit/:Unit[n_,Times[i_Real,u___]]:=Unit[n i,Times[u]];
Unit/:Unit[n_,Times[i_Integer,u___]]:=Unit[n i,Times[u]];
Unit/:Unit[n_,Times[i_Rational,u___]]:=Unit[n i,Times[u]];
Unit/:Unit[n_,Times[i_Complex,u___]]:=Unit[n i,Times[u]];
Unit/:Unit[n_,Times[i_Symbol?NumericQ,u___]]:=Unit[n i,Times[u]];
Unit/:Unit[n_,Times[i_Power?NumericQ,u___]]:=Unit[n i,Times[u]];


	
Unit/:Times[a___,b_Unit,c___]/;MemberQ[{a,c},(_Rational|_Unit|_Real|_Integer|_?NumericQ)]:=Block[{uns,nums,rest,unlist,unsorted,splitlist,finallist,finalunit,finalnumber},
	(*Split the product into numbers, units and other stuff*)
	rest={a,b,c};
	uns=Cases[rest,_Unit];
	rest=DeleteCases[rest,_Unit];
	nums=Cases[rest,_?NumericQ];
	rest=DeleteCases[rest,_?NumericQ];
	If[Length[uns]==1,finalunit=uns[[1]],
		unlist=Flatten[Last/@uns/.Times->List]; (*Get a list of all the individual multiplied unit symbols*)
  		(*Pair with FundamentalUnit and Sort so that dimensionally equivelent units are next to each other in power order*)
   		unsorted=Sort[Map[{FundamentalUnits[Unit[1,#]],Unit[1,#]}&,unlist],UnitSortfn];
   		splitlist=Split[unsorted,TimesCancelTest];(*Split the list into items that cancel out*)
   		finallist=
        	Flatten[       	
        		Map[If[Length[#[[All,2]]]==1,
        			#[[1,2]],(*If it split to one unit then it won't cancel and so we use it*)
        			Convert[Unit[1,Apply[Times,#[[All,2,2]]]],GetPreferredUnits[]] 
        			(*If thare are two, then they cancel so we put them together and convert*)
        			]&,
            	splitlist]];
        (*Any cancelled units are now numbers and need to be pulled out of the list and put in nums*)
        nums=Join[nums,Cases[finallist,_?NumericQ]];
        finallist=DeleteCases[finallist,_?NumericQ];
    	finalunit=Apply[Unit,Apply[Times,finallist/.Unit->List]]; (*Recompose into a unit*)
	];(*All units are now squashed into one unit. Now we address the numbers.*)
	finalnumber=Apply[Times,Join[First/@uns,nums]];
	
    Apply[Times,rest] If[NumericQ[finalunit],
    	finalunit finalnumber ,(*If unit cancelled completely, just return a number*)
    	Unit[finalnumber,Last[finalunit]] (*Otherwise multiply the units number part*)
    	]];
	
            
UnitSortfn[x_List,y_List]:=Block[{un1=x[[1]],un2=y[[1]]},
      					If[Head[un1]===Unit,un1=un1[[2]]];
      					If[Head[un2]===Unit,un2=un2[[2]]];
      					OrderedQ[{un1,un2}]];

TimesCancelTest[{f1_,un1_},{f2_,un2_}]:=Block[{
	fa=If[Length[f1]==1,f1,f1[[2]]],fb=If[Length[f2]==1,f2,f2[[2]]]},
      OppositePowersOfTheSameThingQ[fa, fb]
];

(*Test if two expressions are powers of the same sub expression*)
OppositePowersOfTheSameThingQ[a_,b_]:=
    Block[{ap=CollectObjectPowers[a],bp=CollectObjectPowers[b]},
      		(ap[[1]]===bp[[1]]&&ap[[2]]==-bp[[2]]||
      		(ap[[1]]===1/bp[[1]])&&ap[[2]]==bp[[2]])];
      		

(*Test if two expressions are powers of the same sub expression*)
PowersOfTheSameThingQ[a_,b_]:=
    Block[{ap=CollectObjectPowers[a],bp=CollectObjectPowers[b]},
      		(ap[[1]]===bp[[1]])||(ap[[1]]===1/bp[[1]])];



(*Turn a product of things^powers into a list of {thing, power} pairs*)
ToObjectPower[Times[a_,b__]]:=
    Map[If[Head[#]===Power,Apply[HeldPower,#],HeldPower[#,1]]&,{a,b}];
ToObjectPower[Power[a_,n_]]:={HeldPower[a,n]};
ToObjectPower[a_]:={HeldPower[a,1]};

CollectObjectPowers[obj_]:=
    Block[{ops=ToObjectPower[obj],gcd,reduced},
    	gcd=Apply[GCD,Map[Last,ops]];
      	reduced=Map[#[[1]]^(#[[2]]/gcd)&,ops];
      	HeldPower[Apply[Times,reduced],gcd]
    ];


(*=======================Elementary functions=================================*)
	
Unit/:Power[Unit[a_,b_],c_?NumericQ]:=Unit[a^c,PowerExpand[b^c]];


(*Comment: The rule should really be something like this.
Unit/:Plus[a_Unit,b__Unit]/;CompatibleUnitQ[a,b]:=Unit[Total[First/@#],#[[1,2]]]&[Convert[{a,b}]];
The work that is done here in Plus should really be done in Convert
*)

Unit/:Plus[a_Unit,b__Unit]/;CompatibleUnitQ[a,b]:=
Block[{targetunit,commonexactunits,temp,relatedtargetunits,values=First/@{a,b}},
	Which[(*If all argumenets are in the same unit, apply no unit converstion*)
		Apply[SameQ,Map[Last,{a,b}]],
      Unit[Apply[Plus,values],Last[a]],
      
      (*Test if there are any reals, if not search for commonality in the units *)
    If[Union[Precision/@values]=!={Infinity},True,
    	commonexactunits={a,b}/.$ExactUnitRules;
    	Not[Apply[SameQ,Map[Last,commonexactunits]]]],
    	(*if there are reals OR no commonality then fundamentalize, sum and convert to preferred*)
    temp=FundamentalUnits[{a,b}];
    Convert[Unit[Total[First/@temp],temp[[1,2]]],GetPreferredUnits[]],
    
    (*Reaching here we must have commonality of exact quantities*)
    (*First we do the sum in the common unit*)
    True,
    temp=Unit[Total[First/@commonexactunits],commonexactunits[[1,2]]];
    (*Now seek a preferred unit with exact commonality*)
    relatedtargetunits=Select[GetPreferredUnits[],(#/.$ExactUnitRules)[[2]]===temp[[2]]&];
    If[Length[relatedtargetunits]==0,temp,Convert[temp,relatedtargetunits]]
	]];


 (*Special case of adding a number to a unit. Fails unless the unit can be simplified to a number*)
 Unit/:(a_?NumericQ+Unit[b_,c_])/;Not[TrueQ[compflag]]:=
    Block[{compflag=True},
      If[NumericQ[#],a+#,
        Message[Unit::"incomp",c];a+Unit[b,c]]&[FundamentalUnits[Unit[b,c]]]];
        
(*========================Other functions behaviour=========================*)

(*Square roots*)
Unit/:Sqrt[Unit[a_,b_]]:=Unit[Sqrt[a],PowerExpand[Sqrt[b]]];


(*Inequalities*)
Unit/:Unequal[a__Unit]:=
    If[Quiet[CompatibleUnitQ[a]],Apply[Unequal,Map[First,Convert[{a}]]],
      True];


(*Sorting*)
(*Sort will already work for any ordering function which can handle units but here we 
apply a fast method for the common case of Automatic ordering function that avoids 
explicitely comparing each pair of units.*)
Unprotect[Sort];
Sort[{a__Unit}]:=Block[{data=Convert[{a}]},
		If[!FreeQ[data,Unit],data=First/@data];
			SortBy[Transpose[{data,{a}}],First][[All,2]]
			];
(*And another special case for the other most common Sort*)
Sort[{a_Unit},Greater]:=Reverse[Sort[{a}]];

Protect[Sort];


Unit/:Min[a_Unit,b__Unit]/;CompatibleUnitQ[{a,b}]:=First[Sort[{a,b}]];
Unit/:Max[a_Unit,b__Unit]/;CompatibleUnitQ[{a,b}]:=Last[Sort[{a,b}]];
Unprotect[Min,Max];
Min[{a_Unit,b__Unit}]/;CompatibleUnitQ[{a,b}]:=First[Sort[{a,b}]];
Max[{a_Unit,b__Unit}]/;CompatibleUnitQ[{a,b}]:=Last[Sort[{a,b}]];
Protect[Min,Max];

(*Make sure ? works for usage. This could be better handled by not using symbol::usage at all*)
Unit/:Information[Unit[_,name_String],opts___]:=Information[name,opts];


(*Functions of one argument which apply directly to the quantity and remain in unit*)
(Unit/:#[Unit[a_,b_]]:=Unit[#[a],b])&/@
	{Abs,Re,Im,Conjugate,Round,Arg,Ceiling,Floor,IntegerPart,Chop,Clip,Minus,Range,IntegerPartitions};
	

(*fn[unit,{unit,unit}] which must be the compatible and stay in the unit*)	
Function[{fn}, Unit/:fn[a_Unit,{b_Unit,c_Unit}]/;CompatibleUnitQ[a,b,c]:=Block[{common=Convert[{a,b,c}]},
									Unit[1,common[[1,2]]] Apply[fn[#1,{#2,#3}]&,First/@common]]]/@
	{Clip,Rescale};
	
(*fn[unit,{unit,unit},{unit,unit}] which must be the compatible and stay in the unit*)	
Function[{fn}, Unit/:fn[a_Unit,{b_Unit,c_Unit},{d_Unit,e_Unit}]/;CompatibleUnitQ[a,b,c,d,e]:=Block[{common=Convert[{a,b,c,d,e}]},
									Unit[1,common[[1,2]]] Apply[fn[#1,{#2,#3},{#4,#5}]&,First/@common]]]/@
	{Rescale};


(*Functions of one argument which apply directly to the quantity and discard in unit*)
(Unit/:#[Unit[a_,b_]]:=#[a];)&/@{Sign,IntegerDigits,RealDigits,DigitCount,RealExponent, MantissaExponent,
	IntegerExponent,IntegerLength,UnitStep,Unitize,UnitBox,UnitTriangle,SquareWave,TriangleWave,SawtoothWave,EvenQ,OddQ,PrimeQ,Divisors}

      
(*Functions of two units which must be compatible and kept in the common unit*)
(Unit/:#[a_Unit,b_Unit]/;CompatibleUnitQ[a,b]:=Block[
										{converted=Convert[{a,b}]},
										If[FreeQ[converted,Unit],#[converted],
										#[Apply[Sequence,First/@converted]] Unit[1,converted[[1,2]]]
										]])&/@{Range,Quotient,QuotientRemainder,Round,Chop};
										
(*Functions of three units which must be compatible and kept in the common unit*)
(Unit/:#[a_Unit,b_Unit,c_Unit]/;CompatibleUnitQ[a,b,c]:=Block[
										{converted=Convert[{a,b,c}]},
										If[FreeQ[converted,Unit],#[converted],
										#[Apply[Sequence,First/@converted]] Unit[1,converted[[1,2]]]
										]])&/@{Range};

(*Functions which return False if mixed units are given or units and numbers are mixed*)
(Unit/:#[a__Unit]/;Not[Quiet[CompatibleUnitQ[a]]]:=False;
Unit/:#[a__Unit,b_?NumericQ,c___Unit]:=False;)&/@{Equal,Greater,Less,GreaterEqual,LessEqual,Divisible};

(*Functions which return True if mixed units are given or units and numbers are mixed*)
(Unit/:#[a__Unit]/;Not[Quiet[CompatibleUnitQ[a]]]:=False;
Unit/:#[a__Unit,b_?NumericQ,c___Unit]:=False;)&/@{Unequal,NotGreater,NotLess};

(*Functions of two units which must be compatible and discard the unit*)
(Unit/:#[a_Unit,b_Unit]/;CompatibleUnitQ[a,b]:=Block[
										{converted=Convert[{a,b}]},
										If[FreeQ[converted,Unit],Apply[#,converted],
										#[Apply[Sequence,First/@converted]]
										]])&/@{Divisible};	
										
(*Functions of any number units which must be compatible and discard the unit*)
(Unit/:#[a__Unit]/;CompatibleUnitQ[a]:=Block[
										{converted=Convert[{a}]},
										If[FreeQ[converted,Unit],Apply[#,converted],
										#[Apply[Sequence,First/@converted]]
										]])&/@{Equal,Greater,Less,GreaterEqual,LessEqual,Unequal,NotGreater,NotLess};	
																		
(*Functions of any number units which must be compatible and kept in the common unit*)
(Unit/:#[a__Unit]/;CompatibleUnitQ[a]:=Block[
										{converted=Convert[{a}]},
										If[FreeQ[converted,Unit],#[converted],
										#[Apply[Sequence,First/@converted]] Unit[1,converted[[1,2]]]
										]])&/@{GCD,LCM};
										
						

(*TODO: More distributions need covering*)
(*Distributions of one or more arguments where all are united and units are preserved*)
(Unit/:#[x__Unit]/;CompatibleUnitQ[x]:=Block[{uns=Convert[{x}]},
											Unit[uns[[1,2]]] Apply[#,First/@uns]])&/@{
												NormalDistribution,PoissonDistribution};
(Unprotect[#];
#[{x__Unit}]/;CompatibleUnitQ[x]:=Block[{uns=Convert[{x}]},
											Unit[uns[[1,2]]] Apply[#,First/@uns]];
Protect[#])&/@{UniformDistribution};
(*Random numbers*)


Unprotect[RandomReal];
RandomReal[x_Unit,args___]:=x RandomReal[1,args];
RandomReal[{x_Unit,y_Unit},args___]/;CompatibleUnitQ[x,y]:=
		Block[{range=Convert[{x,y}]},Unit[1,range[[1,2]]] RandomReal[First/@range,args]];
RandomReal[x_Unit dist_,args___]:=x RandomReal[dist,args];
Protect[RandomReal];

Unprotect[RandomInteger];
RandomInteger[x_Unit,args___]:=x RandomInteger[1,args];
RandomInteger[{x_Unit,y_Unit},args___]/;CompatibleUnitQ[x,y]:=
		Block[{range=Convert[{x,y}]},Unit[1,range[[1,2]]] RandomInteger[First/@range,args]];
RandomInteger[x_Unit dist_,args___]:=x RandomInteger[dist,args];
Protect[RandomInteger];

Unit/:Times[a_Interval,Unit[n_,un_]]:=Unit[n a,un];
Unprotect[Interval];
Interval[pat:{__Unit}..]/;CompatibleUnitQ[Flatten[{pat}]]:=Block[{un},
				un=First[Convert[Flatten[{pat}]]][[2]];
				Unit[Apply[Interval,{pat}/Unit[1,un]],un]];
Protect[Interval];
				

								
(*TODO: These rules are not taking enough precidence over standard Table behaviour
Unprotect[Table];								
Table[expr_,{var_Symbol,Unit[x_,un1_]}]:=Table[expr,{var,x}]Unit[1,un1];

Table[expr_,{var_Symbol,Unit[x_,un1_],Unit[y_,un1_]}]:=Table[expr,{var,x,y}]Unit[1,un1]
Table[expr_,{var_Symbol,Unit[x_,un1_],Unit[y_,un2_]}]/;CompatibleUnitQ[Unit[x,un1],Unit[y,un2]]:=
								Table[expr,{var,Unit[x,un1],Convert[Unit[y,un2],Unit[1,un1]]}];
								
Table[expr_,{var_Symbol,Unit[x_,un1_],Unit[y_,un1_],Unit[z_,un1_]}]:=Table[expr,{var,x,y,z}]Unit[1,un1];
Table[expr_,{var_Symbol,Unit[x_,un1_],Unit[y_,un2_],Unit[z_,un3_]}]/;CompatibleUnitQ[Unit[x,un1],Unit[y,un2],Unit[z,un3]]:=
								Table[expr,{var,Unit[x,un1],Convert[Unit[y,un2],Unit[1,un1]],Convert[Unit[z,un3],Unit[1,un1]]}];
Protect[Table];
*)

(*TODO This rule needs considering...
Unprotect[Integrate];
Integrate[expr_, {var_, lo_Unit, hi_Unit},opts:OptionsPattern[]] /; 
  CompatibleUnitQ[lo, hi] := Block[{lo2, hi2},
  {lo2, hi2} = Convert[{lo, hi}];
  (lo2/DropUnits[lo2]) Integrate[
    expr, {var, DropUnits[lo2], DropUnits[hi2]},opts]];
Protect[Integrate];

Is it true? Also need to cover multiple integrals?
    *)
    
(*Trig rules only apply to angle units*)
(Unit/:#[ang_Unit]/;CompatibleUnitQ[ang,Unit[1,"Radian"]]:=#[FundamentalUnits[ang/Unit[1,"Radian"]]])&/@
			{Sin,Cos,Tan,Csc,Sec,Cot,Sinh,Cosh,Tanh,Sinc,Haversine,Exp};


(*UnitSimplify will convert a unit to an equivelent unit if one can be found that is non-compiund out of 
preferred units, fundamental units, or is dimensionless*)
SimplifyUnits[a_]:=(a/.expr_Unit:>SimplifyUnits[expr]);

(*TODO: The idea was to insert this into Simplify butComplexity function prevents 
it getting used on things like Atmosphere Acre etc. Need to find a ComplexityFunction that works in general*)
SimplifyUnits[a_Unit]:=Block[{exactU,fundU,prefU},
	
	(*Generate alternative representations of the unit*)
	fundU=FundamentalUnits[a];
	prefU=Convert[a,GetPreferredUnits[]];
	exactU=If[Precision[a[[1]]]==Infinity,
		a/.$ExactUnitRules,
		None];	

	Which[(*If it resolves to a number or non-unit, return that*)
		NumericQ[fundU],fundU,
		(*If prefU uses fewer unit names use that*)
		Length[Cases[prefU[[2]],_String,Infinity]]<Length[Cases[a[[2]],_String,Infinity]],prefU,
		(*If exactU has a value and uses fewer unit names use that*)
		(exactU=!=None)&&Length[Cases[exactU[[2]],_String,Infinity]]<Length[Cases[a[[2]],_String,Infinity]],exactU,
		(*If fundU uses fewer unit names use that*)
		Length[Cases[fundU[[2]],_String,Infinity]]<Length[Cases[a[[2]],_String,Infinity]],fundU,         
 		(*Otherwise return it unchanged*)
          True,a]];
          
(*Use this rule as part of the Simplify commands

SetOptions[Simplify,
    TransformationFunctions->
      Union[Flatten[{TransformationFunctions/.Options[Simplify,
                TransformationFunctions],UnitSimplify}]]];
SetOptions[FullSimplify,
    TransformationFunctions->
      Union[Flatten[{TransformationFunctions/.Options[Simplify,
                TransformationFunctions],UnitSimplify}]]];
*)
                

(*=================================== Data plotting ===========================================*)

(*Plots of flat lists*)
(*TODO: Handle Tooltips*)

Function[{plottype},
	Unprotect[plottype];
	plottype[data:{__Unit},opts:OptionsPattern[]]/;CompatibleUnitQ[data]:=
			Function[{arg},plottype[First/@arg,opts,AxesLabel->Unit[1,arg[[1,2]]]]][Convert[data]];
			
(*Broken
	plottype[data:Tooltip[{__Unit}],opts:OptionsPattern[]]/;CompatibleUnitQ[data]:=
			Function[{arg},
				plottype[Tooltip[First[#],#]&/@arg,opts,AxesLabel->Unit[1,arg[[1,2]]]]][
				Convert[data]
				];
*)
			
	Protect[plottype];
]/@{ListPlot,ListLinePlot,DiscretePlot,ListLogPlot,ListPolarPlot,BarChart,Histogram};

(*Pie chart*)


(*TODO: Improve piechart labelling, handling of tooltips and labels etc*)
Unprotect[PieChart];			
  PieChart[data : {__Unit}, opts : OptionsPattern[]] /; CompatibleUnitQ[data] :=  Function[{arg}, PieChart[First /@ arg, opts]][Convert[data]]; 
PieChart[data : {{__Unit} ..}, opts : OptionsPattern[]] /; CompatibleUnitQ[data] :=  Function[{arg}, PieChart[arg,opts]][  Map[First, Convert /@ data, {2}]];
 Protect[PieChart];
 
			
			
(*Indexed data*)



(*Paired data with labels*)
(Unprotect[#];
#[pat:{{_,_}..},opts:OptionsPattern[]]/;If[FreeQ[pat,Unit],False,Apply[And,Map[CompatibleUnitQ,Transpose[pat]]]]:=
	Block[{data=ColumnConvert[pat]},
		#[data[[1]],opts,FilterRules[{           
           						FrameLabel -> Most[data[[2,1]]], 
           						AxesLabel -> data[[2,1]]
           								}, Options[#]]
		
		]];
Protect[#])&/@{ListPlot,ListLinePlot,ListLogPlot,ListPolarPlot,Histogram3D};

(*Paired data, no axes labels*)
(Unprotect[#];
#[pat:{{_,_}..},opts:OptionsPattern[]]/;If[FreeQ[pat,Unit],False,Apply[And,Map[CompatibleUnitQ,Transpose[pat]]]]:=
	Block[{data=ColumnConvert[pat]},
		#[data[[1]],opts]];
Protect[#])&/@{SectorChart};



(*Plots of trippled data with labels*)
(Unprotect[#];
#[pat:{{_,_,_}..},opts:OptionsPattern[]]/;If[FreeQ[pat,Unit],False,Apply[And,Map[CompatibleUnitQ,Transpose[pat]]]]:=
	Block[{data=ColumnConvert[pat]},
		#[data[[1]],opts,
			Apply[Sequence, FilterRules[{           
           						FrameLabel -> Most[data[[2,1]]], 
           						AxesLabel -> data[[2,1]]
           								}, Options[#]]
           		]]];
Protect[#])&/@{ListDensityPlot,ListContourPlot,ListPlot3D,ListPointPlot3D};

(*Plots of trippled data, no axes labels*)
(Unprotect[#];
#[pat:{{_,_,_}..},opts:OptionsPattern[]]/;If[FreeQ[pat,Unit],False,Apply[And,Map[CompatibleUnitQ,Transpose[pat]]]]:=
	Block[{data=ColumnConvert[pat]},
		#[data[[1]],opts]];
Protect[#])&/@{SectorChart3D};



(*DateListPlot*)(*TODO: FrameLabel doesn't work*)
Quiet[DateListPlot[{{1, 2}}]];(*Force loading of definitions before we modify them*)
Unprotect[DateListPlot];
DateListPlot[data:{__Unit},datespec_,opts:OptionsPattern[]]/;CompatibleUnitQ[data]:=
Function[{arg},DateListPlot[First/@arg,datespec,opts,FrameLabel->{Automatic,Unit[1,arg[[1,2]]]}]][Convert[data]];


DateListPlot[pat : {{_, _Unit} ..},opts:OptionsPattern[]]/;CompatibleUnitQ[pat[[All,2]]] := 
Block[{data=Convert[pat[[All,2]]]},DateListPlot[Transpose[{pat[[All,1]],First/@data}],opts,
		AxesLabel->{Automatic,Unit[1,data[[1,2]]]}]];
Protect[DateListPlot];




(*Plots of matrix data*)
(Unprotect[#];
#[pat : {{_Unit,_Unit,_Unit,__Unit} ..},opts:OptionsPattern[]]/;(CompatibleUnitQ[Flatten[pat]]&&TensorRank[pat]===2):= 
Block[{data=Convert[Flatten[pat]]},
	#[Partition[First/@data,Length[First[pat]]],opts,AxesLabel->Unit[1,data[[1,2]]]]];
Protect[#];)&/@{ListDensityPlot,ListContourPlot,ListPlot3D,ListPointPlot3D,BoxWhiskerChart};



(*=====================================Function plotting=================================*)
(*Utility function for passing the unit quanity from a range into the function*)
RemoveUnitsFromRange[lo_, hi_] := Block[{un, nlo, nhi},
   If[Not[FreeQ[lo, _Unit]] && CompatibleUnitQ[lo, hi],
    (*Then*)
    	{nlo, nhi} = Convert[{lo, hi}];
    	un = Unit[1,nlo[[2]]];
    	{nlo, nhi} = {nlo, nhi}/un;,
    (*Else*)
    	{nlo, nhi} = {lo, hi};
    	un = 1;
    ];
   {un, nlo, nhi}];


(*Function visualization one variable*)

(Unprotect[#];
    #[expr_, {var_Symbol, lo_, hi_}, 
       opts : OptionsPattern[]] /; ((Not[FreeQ[lo, _Unit]] && CompatibleUnitQ[lo, hi]) || Not[FreeQ[Unevaluated[expr] /. var -> lo, _Unit]]) && (lo != hi) :=
  
     	Module[{nlo, nhi, un, newvar, unit},
      
      (*Strip units out of range*)
      {un, nlo, nhi} = RemoveUnitsFromRange[lo, hi];
      
      unit =  If[MatchQ[#, _Unit], Unit[1, #[[2]]], 1] &[(Unevaluated[expr] /.var -> (un nlo))];
       #[DropUnits[(Unevaluated[expr] /unit) /. var -> (un newvar)], {newvar, nlo, nhi}, opts, 
        AxesLabel -> {If[un === 1, None, un], If[unit == 1, None, unit]}]
        ];
    Protect[#]; ) & /@ 
    	{Plot, DiscretePlot, LogPlot, LogLinearPlot, LogLogPlot};

(*Function visualization two variable*)

(Unprotect[#];
    #[expr_, {var_Symbol, lo_, hi_}, {var2_Symbol, lo2_, hi2_}, 
       opts : OptionsPattern[]] /; ((Not[FreeQ[lo, _Unit]] &&  CompatibleUnitQ[lo, hi])|| (Not[FreeQ[lo2, _Unit]] && CompatibleUnitQ[lo2, hi2])
         || Not[FreeQ[expr /. {var -> lo, var2 -> lo2}, _Unit]]) && (lo != hi && lo2 != hi2) :=
     Module[{nlo, nhi, nlo2, nhi2, un, un2, newvar, newvar2, unit},
      
      (*Strip units out of first range*)
      {un, nlo, nhi} = RemoveUnitsFromRange[lo, hi];
      (*Strip units out of second range*)
      {un2, nlo2, nhi2} = RemoveUnitsFromRange[lo2, hi2];
      
      
      unit = 
       If[MatchQ[#, _Unit], Unit[1, #[[2]]], 1] &[(expr /. {var -> (un nlo), var2 -> (un2 nlo2)})];
      Apply[#, {(expr /unit) /. {var -> (un newvar), var2 -> (un2 newvar2)}, {newvar, nlo, nhi}, {newvar2, nlo2,nhi2}, 
      	opts, Apply[Sequence, FilterRules[{           
           FrameLabel -> {If[un === 1, None, un], 
             If[un2 === 1, None, un2] }, 
           AxesLabel -> {If[un === 1, None, un], 
             If[un2 === 1, None, un2] , If[unit == 1, None, unit]}
           	}, Options[#]]]}
       ]];
    Protect[#]; ) & /@ {ContourPlot, 
   DensityPlot, RegionPlot, Plot3D};

(*Functions of three vars*)

(Unprotect[#];
    #[expr_, {var_Symbol, lo_, hi_}, {var2_Symbol, lo2_, hi2_}, {var3_Symbol, lo3_, hi3_}, opts : OptionsPattern[]] /; 
    (((Not[FreeQ[lo, _Unit]] && CompatibleUnitQ[lo, hi])|| (Not[FreeQ[lo2, _Unit]] &&  CompatibleUnitQ[lo2, hi2])
          || (Not[FreeQ[lo3, _Unit]] &&  CompatibleUnitQ[lo3, hi3]) || Not[FreeQ[ expr /. {var -> lo, var2 -> lo2,  var3 -> lo3}, _Unit]]) 
          && (lo != hi && lo2 != hi2 && lo3 != hi3)) :=
     Module[{nlo, nhi, nlo2, nhi2, nlo3, nhi3, un, un2, un3, newvar, newvar2, newvar3, unit},
      
      (*Strip units out of first range*)
      {un, nlo, nhi} = RemoveUnitsFromRange[lo, hi];
      (*Strip units out of second range*)
      {un2, nlo2, nhi2} = RemoveUnitsFromRange[lo2, hi2];
      (*Strip units out of third range*)
      {un3, nlo3, nhi3} = RemoveUnitsFromRange[lo3, hi3];
      
      unit = 
       If[MatchQ[#, _Unit], Unit[1, #[[2]]],  1] &[(expr /. {var -> (un nlo), var2 -> (un2 nlo2),  var3 -> (un3 nlo3)})];
      Apply[#, {(expr /unit) /. {var -> (un newvar),   var2 -> (un2 newvar2), var3 -> (un3 nlo3)}, {newvar, nlo,  nhi}, {newvar2, nlo2, nhi2}, {newvar3, nlo3, nhi3}, opts,
        AxesLabel -> {If[un === 1, None, un],  If[un2 === 1, None, un2] , If[un3 === 1, None, un3]}}
       ]];
    Protect[#]; ) & /@ {RegionPlot3D, ContourPlot3D};
   
   (*Utility function for making sure that the definitions in this package are applied first*)
PromoteUnitDownValue[sym_Symbol] := (Unprotect[sym]; 
   DownValues[sym] =  Sort[DownValues[sym], (Length[Cases[#1,Unit,Infinity]]>Length[Cases[#2,Unit,Infinity]])&]; 
   Protect[sym]);
   
PromoteUnitDownValue/@{
	BarChart,PieChart,DateListPlot,ListPointPlot3D,ListLogPlot,LogPlot,LogLinearPlot,LogLogPlot,
	SectorChart,SectorChart3D,BoxWhiskerChart,Histogram,Histogram3D};

SimplifyUnitRules[rulelist_List]:=Block[{rhsset,finalrules,rhsruleset},
	finalrules=DeleteCases[rulelist,HoldPattern[x_->x_]];
	rhsset=Cases[rulelist[[All,2]],_String,Infinity];
	rhsruleset=Cases[rulelist,HoldPattern[x_->_]/;MemberQ[rhsset,x]];
	finalrules=finalrules/.HoldPattern[x_->y_]:>(x->(y//.rhsruleset))];



(*====================================Unit declarations===========================================*)
(*Now we can load all of the pre-defined unit values*)
FastGroupDeclareUnit[
Begin["AutomaticUnits`"];(*Move to public context so that unit symbols are on context path*)
Get["AutomaticUnits`SI`"]; (*Must be first*)
Get["AutomaticUnits`PrefixedSI`"];
Get["AutomaticUnits`Troy`"];
Get["AutomaticUnits`BritishAvoirdupois`"];
Get["AutomaticUnits`Avoirdupois`"];
Get["AutomaticUnits`Imperial`"];(*Needs Troy and BritishAvoirdupois to be loaded first*)
Get["AutomaticUnits`CGS`"];
Get["AutomaticUnits`MKS`"];
Get["AutomaticUnits`Survey`"]; (*Needs Troy, Avoirdupois,Survey to be loaded first*)
Get["AutomaticUnits`USCustomary`"];
Get["AutomaticUnits`Atomic`"];
Get["AutomaticUnits`Planck`"];
Get["AutomaticUnits`Astronomical`"];
Get["AutomaticUnits`IEC`"];
Get["AutomaticUnits`MeterTonneSecond`"];
Get["AutomaticUnits`Alternative`"];
Get["AutomaticUnits`AlternativeNames`"];
Get["AutomaticUnits`Champagne`"];
Get["AutomaticUnits`Anthropic`"];
(*Regional and obsolete units*)
Get["AutomaticUnits`RegionalUnits`"];
Get["AutomaticUnits`Arabic`"];
Get["AutomaticUnits`Japanese`"];
Get["AutomaticUnits`Malay`"];
Get["AutomaticUnits`Maltese`"];
Get["AutomaticUnits`Norwegian`"];
Get["AutomaticUnits`Roman`"];
Get["AutomaticUnits`Russian`"];
Get["AutomaticUnits`Scottish`"];
Get["AutomaticUnits`Spanish`"];
Get["AutomaticUnits`Swedish`"];
Get["AutomaticUnits`Taiwanese`"];
(*Special unit set needed for mouse interactivity*)
UnitSet["InteractiveChoices"]=Union[UnitSet["SI"],UnitSet["Imperial"],UnitSet["USCustomary"]]; 
End[];(*Return to private context*)
	];

Get["AutomaticUnits`PaletteCache`"];(*Pre calculated contents of palette*)

(*FrontEnd tools. Used for the palette and also interactive conversion*)
CompatibleUnitsFromSet[set_, un_Unit] := CompatibleUnitsFromSet[set, un]= Quiet[Sort@Select[UnitSet[set], CompatibleUnitQ[#, un] &]];
DimensionSelect[set_,dim_]:=DimensionSelect[set,dim]=CompatibleUnitsFromSet[set,dim/.$DimensionRepresentatives];
 (*Find which dimensions are represented in a UnitSet*)
AvailableDimensions[set_] :=  AvailableDimensions[set] =  Select[$Dimensions, Length[DimensionSelect[set, #]] > 0 &];
(*This could be faster to improve palette opening*)

(*List of possible dimensions with an example of a unit in that dimension*)
$DimensionRepresentatives={
			"Length"->Unit[1, "Meter"],
			"Area"->Unit[1, "Meter"]^2,
			"Volume"->Unit[1, "Meter"]^3,
			"Wavenumber"->1/Unit["Meter"],
			"Mass"->Unit["Kilogram"],
			"Time"->Unit["Second"],
			"Frequency"->Unit["Hertz"],
			"Velocity"-> Unit["Meter"]/Unit["Second"],
			"Force"->Unit["Newton"],
			"Energy"-> Unit["Joule"],
			"Power"-> Unit["Watt"],
			"Pressure"->Unit["Pascal"],
			"Viscosity"->Unit["Poise"],
			"Charge"->Unit["Coulomb"],
			"Current"->Unit["Ampere"],
			"Voltage"-> Unit["Volt"],
			"Magnetic Field Strength"->Unit["Volt"]/Unit["Meter"],
			"Magnetic Induction"->Unit["Tesla"],
			"Magnetic Field Strength"->Unit["Ampere"]/Unit["Meter"],
			"Magnetic Dipole Moment"->Unit["Ampere"] Unit["Meter"]^2,
			"Resistance"-> Unit["Ohm"],
			"Resistivity"->Unit["Ohm"] Unit["Meter"],
			"Capacitance"-> Unit["Farad"],
			"Inductance"->Unit["Henry"],
			"Data"->Unit["Byte"],
			"Angle"->Unit["Radian"]};
			
UnitToDimension[un_Unit]:=Quiet[Select[$DimensionRepresentatives,CompatibleUnitQ[#[[2]],un]&][[1,1]]];

$Dimensions = First/@$DimensionRepresentatives;
 

(*Make buttons for the palette*)
UnitButton[tradform_] :=  Tooltip[
									Button[#,  
										NotebookWrite[InputNotebook[], ToBoxes[#, 
											If[tradform,TraditionalForm,StandardForm]]],Appearance -> "Palette"],
									TraditionalForm[#]] &
									
End[];

	
EndPackage[]

