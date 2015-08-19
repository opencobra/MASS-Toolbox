(* ::Package:: *)

(* ::Title:: *)
(*GUI*)


Begin["`Private`"];


(* ::Section::Closed:: *)
(*Attribute Editing*)


(* Things to change:

	1) Make each attribute it's own edit function.
	2) Automatically populate things like synonyms and elemental composition with the metabolites.
	3) Use updateAttribute functions instead of setAttribute. This will make the final output much easier to read
	4) Get rid of Nulls when there is no unit.

*)


(* ::Subsection:: *)
(*Edit Attribute*)


SetAttributes[editAttribute,HoldFirst];
editAttribute[model_,attribute:Alternatives@@Toolbox`Private`$MASSmodel$MutableAttributes]:=Module[{data,name,output,result},
	data = model[attribute];
	name=ToString[SymbolName[Unevaluated@model]];
	output = editAttributeGUI[data,model,"Edit "<>attribute];
	If[output === $Canceled,
		$Canceled,
		result = "set"<>ToString[attribute]<>"["<>name<>","<>ToString[output,InputForm]<>"];";
		CellPrint[ExpressionCell[ToExpression[result,TraditionalForm,Defer],"Input"]]
	]
]/;MatchQ[model,_MASSmodel]


(* ::Subsubsection:: *)
(*Edit Empty Lists*)


editAttributeGUI[dat:{},model_MASSmodel,title_:"Default title"]:=Module[{out},
	ChoiceDialog["The selected attribute cannot be edited using the GUI for this model.","OK"->True];
	$Canceled
]


(* ::Subsubsection:: *)
(*Edit String Attributes (Name, ID, Notes etc.)*)


editAttributeGUI[dat_String,model_MASSmodel,title_:"Default title"]:=Module[{out},
	DynamicModule[{input},
		input=dat;
		out=DialogInput[
			{InputField[Dynamic[input],String,FieldSize->{50,12}],
				Row[{DefaultButton[DialogReturn[ToString[input]]],CancelButton[]}]
			},NotebookEventActions->{"ReturnKeyDown":>FrontEndExecute[{NotebookWrite[InputNotebook[],"\n",After]}]},WindowTitle->title
		]
	];
	out
]


(* ::Subsubsection:: *)
(*Edit List Attributes (Elemental Composition etc.)*)


editAttributeGUI[dat:{_Rule..},model_MASSmodel,title_:"Default title",errors_List:{}]:=Module[{output},
	DynamicModule[{vars,names,values,inputs,inputGrid,buttonRow,result},
		(* Get the names and values of each item *)
		names = dat[[All,1]];
		values = dat[[All,2]]; 

		(* Create variables for the input fields *)
		MapThread[(vars[#1]=#2)&,{names,values}];

		(* Create the input fields *)
		inputs={#,InputField[Dynamic[vars[#]],ImageSize->100]}&/@names;
		
		inputGrid=Grid[Flatten/@Partition[inputs,2,2,1,{{"",""}}],Alignment->Left,Dividers->{4->True,All},Frame->True];
		result:=(#->vars[#])&/@names;
		buttonRow = Row[{
			DefaultButton[DialogReturn[result]],
			CancelButton[],
			Button["Set all to Null",(vars[#]=Null)&/@names],
			Button["Initialize",MapThread[(vars[#1]=#2)&,{names,values}]]
		}];
		output=DialogInput[
			Column[{
				Pane[inputGrid,Scrollbars->Automatic,ImageSize->{Automatic,600}],
				buttonRow
			}],WindowTitle->title
		]
	];
	output
]


(* ::Subsubsection:: *)
(*Edit numeric list attributes (Parameters, Initial Conditions etc.)*)


editAttributeGUI[dat:{Rule[_,(_Unit|_?NumericQ|Infinity)]..},model_MASSmodel,title_:"Default title",errors_List:{{},{}}]:=Module[{output,unitMessage,wrongMessage},
	DynamicModule[{vars,unitVars,names,values,units,amounts,inputs,inputGrid,buttonRow,result,errorPos,backgroundPos},
		(* Get the names and values of each item *)
		names = dat[[All,1]];
		values = dat[[All,2]];

		(* If any item is has units, separate it into units and amounts *)
		units = If[MatchQ[#,_Unit],#[[2]],""]&/@values;
		amounts = If[MatchQ[#,_Unit],#[[1]],#]&/@values;

		(* Create variables for the input fields for both the amounts and the units *)
		MapThread[(vars[#1]=#2)&,{names,amounts}];
		MapThread[(unitVars[#1]=#2/.x_String:>ToExpression[x,InputForm,HoldForm])&,{names,units}];

		(* If no items have units, ignore units. Else, create an input fields *)
		If[MatchQ[units,{Null...}],
			inputs={#,InputField[Dynamic[vars[#]],ImageSize->100],""}&/@names,
			inputs={#,InputField[Dynamic[vars[#]],ImageSize->100],InputField[Dynamic[unitVars[#]],ImageSize->100]}&/@names
		];

		(* Get positions of items with warnings *)
		errorPos = Flatten[Position[names,#]&/@errors];
		backgroundPos = Flatten[{{Ceiling[#/2],3Mod[#+1,2]+1},{Ceiling[#/2],3Mod[#+1,2]+2},{Ceiling[#/2],3Mod[#+1,2]+3}}&/@errorPos,1];

		inputGrid=Grid[Flatten/@Partition[inputs,2,2,1,{{"","",""}}],Alignment->Left,Dividers->{4->True,All},Frame->True,Background->{None,None,Thread[backgroundPos->Pink]}];
		(* Infinity doesn't play well with units, so I had to hack a way for infinity to be inside the unit *)
		result:=If[And[vars[#]==Infinity,ReleaseHold[unitVars[#]]=!=Null],
			#->Unit[vars[#],Last[ReleaseHold[unitVars[#]]]],
			(#->vars[#]*ReleaseHold[unitVars[#]]/.Null->1)
		]&/@names;
		
		buttonRow = Row[{
			DefaultButton[DialogReturn[result]],
			CancelButton[],
			Button["Set all to 0",(vars[#]=0)&/@names],
			Button["Initialize",MapThread[(vars[#1]=#2)&,{names,amounts}]]
		}];
		output=DialogInput[
			Column[{
				Pane[inputGrid,Scrollbars->Automatic,ImageSize->{Automatic,600}],
				buttonRow
			}],WindowTitle->title
		]
	];

	(* Check the units. Wrong has the outputs that are not units. Messages has information for incorrect units. *)
	If[output===$Canceled,
		unitMessage={};wrongMessage={},
		{unitMessage,wrongMessage}=checkUnits[output,model];
	];

	(* If no messages, return output *)
	If[unitMessage=={}&&wrongMessage=={},
		output,
		Module[{accept,newOutput}, (* If units are wrong, give messages and then create new window with edited units *)
			accept = ChoiceDialog[
				Column@Join[
					("Incompatible units detected for "<>ToString[#[[1]],TraditionalForm]<>". The value "<>ToString[#[[2]],TraditionalForm]<>" will be replaced by "<>ToString[#[[3]],TraditionalForm]<>".\n")
						&/@unitMessage,
					("The value of "<>ToString[#[[1]],TraditionalForm]<>", "<>ToString[#[[2]],TraditionalForm]<>", is not a unit.")
						&/@wrongMessage
				],"OK"->True,"Ignore Errors"->False
			];
			(* Change output to new units (if accept is true) and create new GUI*)
			If[accept,
				newOutput=output/.Join[(Rule[#[[1]],_]->Rule[#[[1]],#[[3]]]&/@unitMessage),(Rule[#[[1]],_]->Rule[#[[1]],1]&/@wrongMessage)];
				editAttributeGUI[newOutput,model,title,Join[First/@unitMessage,First/@wrongMessage]],
				output
			]
		]
	]

]


(* Most of this code was taken from adjustUnits. If adjustUnits has a bug, this may need to be edited as well *)
Options[checkUnits]={"Ignore"->{}};
checkUnits[stuff:{_Rule...},rxns:{_reaction...}:{},opts:OptionsPattern[]]:=Module[{id2rxns,unitLessQ,catchIncomp,volumeHelper,keqExp,speciesHelper,fluxHelper,fwdRateConstHelper,revRateConstHelper,keqHelper,rxnOrder,defaultAmountUnit,defaultVolumeUnit,defaultLengthUnit,defaultSurfaceUnit,defaultTimeUnit,defaultMassUnit,defaultConcUnit,defaultFluxUnit,rxn,KmHelper,VmaxHelper,getVolumeUnit1,getVolumeUnit2,compartmentFactor,newStuff={}},
	defaultAmountUnit=Millimole;
	defaultVolumeUnit=Liter;
	defaultSurfaceUnit=Meter^2;
	defaultLengthUnit=Meter;
	defaultTimeUnit=Hour;
	defaultMassUnit=Gram;
	defaultConcUnit=defaultAmountUnit defaultVolumeUnit^-1;
	defaultFluxUnit=defaultAmountUnit (*defaultVolumeUnit^-1*) defaultTimeUnit^-1;

	(* In general, this function will collect all incorrect units and save them as {item, current value, new value} *)
	unitLessQ=(NumberQ[#]||#===\[Infinity])&;

	getVolumeUnit1=spatialUnit[#,Sequence@@FilterRules[updateRules[Options[adjustUnits],List[opts]],Options[spatialUnit]]]&;
	getVolumeUnit2=spatialUnit[#1,#2,Sequence@@FilterRules[updateRules[Options[adjustUnits],List[opts]],Options[spatialUnit]]]&;

	(* If any volume/concentration/flux has no units, sow for later. *) 
	(* If they have units, make sure it is a compatible volume/conc/flux unit *)
	volumeHelper=If[unitLessQ[#[[2]]],
		Sow[{#[[1]],#[[2]],#[[2]]defaultVolumeUnit},"unit"],
		If[!Quiet@DimensionCompatibleUnitQ[#[[2]],defaultVolumeUnit],
			Sow[{#[[1]],#[[2]],stripUnits[#[[2]]]defaultVolumeUnit},"unit"]
		]
	]&;
	speciesHelper=If[unitLessQ[#[[2]]],
		Sow[{#[[1]],#[[2]],#[[2]]defaultConcUnit},"unit"],
		If[!Quiet@DimensionCompatibleUnitQ[#[[2]],defaultAmountUnit/getVolumeUnit1[#[[2]]]],
			Sow[{#[[1]],#[[2]],stripUnits[#[[2]]]defaultAmountUnit/getVolumeUnit1[#[[2]]]},"unit"]
		]
	]&;
	fluxHelper=If[unitLessQ[#[[2]]],
		Sow[{#[[1]],#[[2]],#[[2]]defaultFluxUnit},"unit"],
		If[!Quiet@DimensionCompatibleUnitQ[#[[2]],defaultAmountUnit getVolumeUnit1[#[[2]]]^-1 defaultTimeUnit^-1],
			Sow[{#[[1]],#[[2]],stripUnits[#[[2]]]defaultAmountUnit getVolumeUnit1[#[[2]]]^-1 defaultTimeUnit^-1},"unit"]
		]
	]&;

	fwdRateConstHelper=(rxn=getID[#[[1]]]/.id2rxns;
		(*If[!MatchQ[rxn,_reaction],Message[adjustUnits::noRxnInfo,#];Abort[];];*) (* <-- May be needed? If no error comes up then just delete this. *)
		rxnOrder=getReactionOrders[rxn,Ignore->OptionValue["Ignore"]][[1]];
		compartmentFactor=If[MatchQ[getCompartment[rxn],(None|_List)],0,1];
		Switch[#[[2]],
			_?unitLessQ,Sow[{#[[1]],#[[2]],#[[2]]defaultAmountUnit^(1-rxnOrder) defaultVolumeUnit^(rxnOrder-compartmentFactor) defaultTimeUnit^-1},"unit"],
			_,If[!Quiet@DimensionCompatibleUnitQ[#[[2]],defaultAmountUnit^(1-rxnOrder) getVolumeUnit2[#[[2]],rxnOrder-compartmentFactor]^(rxnOrder-compartmentFactor) defaultTimeUnit^-1],
				Sow[{#[[1]],#[[2]],stripUnits[#[[2]]]defaultAmountUnit^(1-rxnOrder) getVolumeUnit2[#[[2]],rxnOrder-compartmentFactor]^(rxnOrder-compartmentFactor) defaultTimeUnit^-1},"unit"]
			]
		])&;

	revRateConstHelper=(rxn=getID[#[[1]]]/.id2rxns;If[!MatchQ[rxn,_reaction],Message[adjustUnits::noRxnInfo,#];Abort[];];
		rxnOrder=getReactionOrders[rxn,Ignore->OptionValue["Ignore"]][[2]];
		compartmentFactor=If[MatchQ[getCompartment[rxn],(None|_List)],0,1];
		Switch[#[[2]],
			_?unitLessQ,Sow[{#[[1]],#[[2]],#[[2]]defaultAmountUnit^(1-rxnOrder) defaultVolumeUnit^(rxnOrder-compartmentFactor) defaultTimeUnit^-1},"unit"],
			_,If[!Quiet@DimensionCompatibleUnitQ[#[[2]],defaultAmountUnit^(1-rxnOrder) getVolumeUnit2[#[[2]],rxnOrder-compartmentFactor]^(rxnOrder-compartmentFactor) defaultTimeUnit^-1],
				Sow[{#[[1]],#[[2]],stripUnits[#[[2]]]defaultAmountUnit^(1-rxnOrder) getVolumeUnit2[#[[2]],rxnOrder-compartmentFactor]^(rxnOrder-compartmentFactor) defaultTimeUnit^-1},"unit"]
			]
		])&;

	keqHelper=(rxn=getID[#[[1]]]/.id2rxns;
		(*If[!MatchQ[rxn,_reaction],Message[adjustUnits::noRxnInfo,#];Abort[];];*) (* Same as above *)
		keqExp=Subtract@@Reverse[getReactionOrders[rxn,Ignore->OptionValue["Ignore"]]];
		Switch[#[[2]],
			_?unitLessQ,If[keqExp!=0,Sow[{#[[1]],#[[2]],#[[2]] (defaultAmountUnit defaultVolumeUnit^-1)^keqExp},"unit"]],
			_,If[!Quiet@DimensionCompatibleUnitQ[#[[2]],(defaultAmountUnit defaultVolumeUnit^-1)^keqExp],
				Sow[{#[[1]],#[[2]],(defaultAmountUnit defaultVolumeUnit^-1)^keqExp},"unit"] (* This is what it used to be. Which is correct??? (defaultAmountUnit getVolumeUnit2[#[[2]],Abs[keqExp]]^-1)^keqExp *)
			]
		])&;

	KmHelper=If[unitLessQ[#[[2]]],
		Sow[{#[[1]],#[[2]],#[[2]]defaultConcUnit},"unit"],
		If[!Quiet@DimensionCompatibleUnitQ[#[[2]],defaultAmountUnit getVolumeUnit1[#[[2]]]^-1],
			Sow[{#[[1]],#[[2]],stripUnits[#[[2]]]defaultAmountUnit getVolumeUnit1[#[[2]]]^-1},"unit"]
		]
	]&;

	VmaxHelper=If[unitLessQ[#[[2]]],
		Sow[{#[[1]],#[[2]],#[[2]]defaultFluxUnit},"unit"],
		If[!Quiet@DimensionCompatibleUnitQ[#[[2]],defaultAmountUnit getVolumeUnit1[#[[2]]]^-1 defaultTimeUnit^-1],
			Sow[{#[[1]],#[[2]],stripUnits[#[[2]]]defaultAmountUnit getVolumeUnit1[#[[2]]]^-1 defaultTimeUnit^-1},"unit"]
		]
	]&;
	
	id2rxns=Thread[(getID/@rxns)->rxns];	

	Flatten[#,1]&/@Reap[

			(* Return an error if something is either not a unit, number, or infinity *)
			If[MatchQ[#[[2]],(_?NumberQ|_DirectedInfinity|_Unit)],
				AppendTo[newStuff,#],
				Sow[{#[[1]],#[[2]]},"wrong"]
			]&/@stuff;
			(* After this, only check things that consist of real units *)	

			Switch[#[[1]],
				parameter["Volume",_],volumeHelper[#],
				$MASS$speciesPattern,speciesHelper[#],
				_v,fluxHelper[#],
				rateconst[_,True],fwdRateConstHelper[#],
				rateconst[_,False],revRateConstHelper[#],
				_Keq,keqHelper[#],
				_Km,KmHelper[#],
				_vmax,VmaxHelper[#],
				_,Null
			]&/@newStuff,{"unit","wrong"}
		][[2]]


]

checkUnits[stuff:{_Rule...},model_MASSmodel,opts:OptionsPattern[]]:=If[model["UnitChecking"],checkUnits[stuff,model["Reactions"],"Ignore"->Union[model["Ignore"],OptionValue["Ignore"]],Sequence@@FilterRules[List@opts,Except["Ignore"]]],stuff]


(* ::Subsubsection:: *)
(*Edit Annotations*)


editAttributeGUI[annotationPane_Pane,model_MASSmodel,title_:"Default title"]:=editAnnotationPane["Annotations"/.model[[1]],model,title];


editAnnotationPane[annot:{{_,_String,_String}..},model_MASSmodel,title_String,wrongAnnot_List:{}]:=Module[{newAnnotations,newWrong},

DynamicModule[{annotations,items,qualifiers,urls,wrongPos,itemChoices,qualChoices,urlVar,itemVar,qualVar,urlFields,qualMenu,itemMenu,deleteAnnotation,addAnnotation,urlButtons,grid},
	(* Must set annotations as a dynamic variable *)
	annotations=annot;
	items = #[[1]]&/@annotations;
	qualifiers = #[[2]]&/@annotations;
	urls = #[[3]]&/@annotations;

	(* Extract position of incorrect annotations *)
	wrongPos = Flatten@Position[annot,Alternatives@@wrongAnnot,1];
	(* Get all possible items that could have annotations *)
	(* model, species, fluxes, compartments, parameters, rate laws, events, initial items *)
	itemChoices = DeleteDuplicates@Join[{model["ID"]},model["Species"],model["Fluxes"],model["Compartments"],First/@model["Parameters"],getID[#]<>" {rate law)"&/@model["Fluxes"],First/@model["Events"], {"Custom Rule"},items];
	(* Also do this for qualifiers *)
	qualChoices = Join[$MIRIAM$modelQualifiers,$MIRIAM$biologyQualifiers];

	(* Set up variables for pulldowns and input fields *)
	itemVar=Table[Unique["item"],{i,Length[annotations]}];
	qualVar=Table[Unique["qual"],{i,Length[annotations]}];
	urlVar=Table[Unique["url"],{i,Length[annotations]}];
	
	(* Initialize variables *)
	Table[(itemVar[[i]])=items[[i]],{i,Length[annotations]}];
	Table[(qualVar[[i]])=qualifiers[[i]],{i,Length[annotations]}];
	Table[(urlVar[[i]])=urls[[i]],{i,Length[annotations]}];

	(* Create interactive elements *)
	urlFields = Dynamic[Table[With[{i=i},InputField[Dynamic[urlVar[[i]]],String]],{i,Length[annotations]}]];
	qualMenu = Dynamic[Table[With[{i=i},PopupMenu[Dynamic[qualVar[[i]]],qualChoices]],{i,Length[annotations]}]];
	itemMenu = Dynamic[Table[With[{i=i},PopupMenu[Dynamic[itemVar[[i]]],itemChoices]],{i,Length[annotations]}]];

	(* Function to delete annotation at index i *)
	deleteAnnotation[i_]:=Module[{},
		annotations=Delete[annotations,i];
		itemVar=Delete[itemVar,i];
		qualVar=Delete[qualVar,i];
		urlVar=Delete[urlVar,i];
	];

	(* Function to add annotation at index i *)
	addAnnotation[index_]:=Module[{i},
		(* Insert below *)
		i = index + 1;
		annotations=Insert[annotations,{Null,"",""},i];
		itemVar=Insert[itemVar,Unique["item"],i];itemVar[[i]]=Null;
		qualVar=Insert[qualVar,Unique["qual"],i];qualVar[[i]]="";
		urlVar=Insert[urlVar,Unique["url"],i];urlVar[[i]]=""
	];

	(* Make buttons to add and delete annotations *)
	urlButtons = Dynamic[Table[With[{i=i},Row[{
		Button["+",addAnnotation[i],Appearance->"Palette"],
		Button["-",deleteAnnotation[i],Appearance->"Palette"]
	}]],{i,Length[annotations]}]];

	grid = Dynamic[Grid[
			Transpose[{
				First@itemMenu,
				First@qualMenu,
				First@urlFields,
				First@urlButtons
			}],
		Dividers->All,Alignment->{Center,Center},Background->{None,Thread[wrongPos->Pink]}]];
	newAnnotations = DialogInput[
		Pane[
			Column[{
				grid,
				Row[{
					Button["OK",DialogReturn[Transpose[{itemVar,qualVar,urlVar}]]],
					CancelButton[]
				}]
			}],Scrollbars->True,ImageSize->{Automatic,500}
		],WindowTitle->title
	];
];

	If[newAnnotations===$Canceled,
		$Canceled,
		newWrong = checkAnnotations[newAnnotations,model];
		If[newWrong=={},
			newAnnotations,
			editAnnotationPane[newAnnotations,model,title,newWrong]
		]
	]
];


checkAnnotations::wrongQualifer="The qualifier `1` in `2` cannot be used to annotate `3`";
checkAnnotations::invalidURN="The URN `1` does not follow the MIRIAM guidelines.";

checkAnnotations[annotations_List,model_MASSmodel]:=Module[{nonModel,urls,urns,wrongAnnot={},wrongURN={}},
	(* Check that only models have model qualifiers *)
	nonModel = Select[annotations,First[#]=!=model["ID"]&];
	If[!MemberQ[$MIRIAM$biologyQualifiers,#[[2]]],
		ChoiceDialog["The qualifier \""<>#[[2]]<>"\" in\n"<>ToString[#]<>"\ncan only be used to annotate models",
			"OK"->AppendTo[wrongAnnot,#]
		];
		Return[#]
	]&/@nonModel;

	(* Check that the URNs are correctly formatted *)
	(* First convert all URLs to URNs *)
	urls = Last/@annotations;

	urns = Which[
		StringMatchQ[#,"http://identifiers.org/"~~__],
			StringReplace[#,{"http://identifiers.org/"->"urn:miriam:","/"->":",":"->"%"}],
		StringMatchQ[#,"urn:miriam:"~~__],
			#,
		True,
			#;
	]&/@urls;

	wrongURN = Pick[annotations,!StringMatchQ[#,Alternatives@@RegularExpression/@$MIRIAM$rules]&/@urns];

	If[wrongURN!={},
		wrongURN=ChoiceDialog[Column@{"The following URNs do not follow the MIRIAM guidelines, or may use a deprecated format.\n",Pane[Column[wrongURN],{Automatic,300},Scrollbars->True],"\nThe MIRIAM registry pattern for the MASS Toolbox was last updated June 2015"},
				{"Ignore Errors"->{},
				"Go Back and Edit"->wrongURN},Modal->True
			]
	];
	Join[wrongAnnot,wrongURN]
]


(* ::Subsubsection:: *)
(*Edit Model*)


SetAttributes[editModelInPlace,HoldFirst];
editModelInPlace[model_]:=Module[{name},
	(* Get the model Name *)
	name=ToString[SymbolName[Unevaluated@model]];
	model=edit[model,"",name,"Evaluate"->True];

]/;MatchQ[model,_MASSmodel];


SetAttributes[edit,HoldFirst];
Options[edit]={"Evaluate"->False};
edit[model_,result_:"",modelName_:"",opts:OptionsPattern[edit]]:=Module[{modelTmp=model,attribute,out2,name,newResult=""},

	(* If the name comes in blank, then get the correct name *)
	If[modelName=="",
		name=ToString[SymbolName[Unevaluated@model]],
		name=modelName (* If it already has a name passed in from a previous call, then keep it *)
	];

	DynamicModule[{attr},

		(* First choose the attribute to edit *)
		attribute=DialogInput[Pane[
			Column[{
				"Choose attribute to edit:",
				RadioButtonBar[Dynamic[attr],{"ID","Name","InitialConditions","Parameters","ElementalComposition","Notes","Annotations","Synonyms"},Appearance->"Vertical"->{Automatic,2}],
				Row[{DefaultButton["Edit Attribute",DialogReturn[attr]],CancelButton[],DefaultButton["Save & Finish",DialogReturn[]]}]
			}]
		]];

		(* Quit GUI if cancelled *)
		If[attribute===$Canceled,Abort[]];

		(* If Save&Quit button is pressed, return the code. Else go back to edit code *)
		If[attribute===Null,
			newResult = result,
			Module[{},
				(* Run attribute editing GUI *)
				out2=editAttributeGUI[model[attribute],model,"Edit "<>attribute];
				(* If it was cancelled, do not change model *)
				If[out2===$Canceled,
					modelTmp=model,
					Module[{},
						(* Else, change the temporary model, and update the result code string *)
						setModelAttribute[modelTmp,attribute,out2,"Sloppy"->True];
						newResult = result<>"set"<>ToString[attribute]<>"["<>name<>","<>ToString[out2,InputForm]<>"];"
					]
				];
				newResult = edit[modelTmp,newResult,name,opts]
			]
			
		];

	];

	(* Return nothing if there is no "newResult" *)
	If[newResult===Null,
		newResult,
		If[OptionValue["Evaluate"]==True,
			modelTmp,
			CellPrint[ExpressionCell[ToExpression[newResult,TraditionalForm,Defer],"Input"]]
		]
	]
]/;MatchQ[model,_MASSmodel];


(* ::Section:: *)
(*QuickView*)


(* ::Code:: *)
(*SetAttributes[quickView,HoldFirst];*)
(*quickView[model_,modelName_String:""]:=Module[{pane,name,newModel},*)
(**)
(*	(* Get the name of the model variable *)*)
(*	If[modelName=="",*)
(*		name=ToString[SymbolName[Unevaluated@model]],*)
(*		name=modelName (* If the name has been passed in *)*)
(*	];*)
(*		*)
(**)
(*	DynamicModule[{met={},flux={},sim,mets,fluxes,vars,tStart=0,tFinal=10,simSize=300,ppSize=200},*)
(*		sim=simulate[model,{t,0,10}];*)
(**)
(*		mets=Column[{*)
(*			Dynamic@Button["Select/Deselect All",If[met==model["Species"],met={},met=model["Species"]]],*)
(*			CheckboxBar[Dynamic[met],model["Species"],Appearance->"Vertical"->{Automatic,3}]*)
(*		}];*)
(*		fluxes=Column[{*)
(*			Dynamic@Button["Select/Deselect All",If[flux==model["Fluxes"],flux={},flux=model["Fluxes"]]],*)
(*			CheckboxBar[Dynamic[flux],model["Fluxes"],Appearance->"Vertical"->{Automatic,3}]*)
(*		}];*)
(*		*)
(*		vars = Grid[{*)
(*			{"Start Time: ", InputField[Dynamic[tStart],Number]},*)
(*			{"End Time: ", InputField[Dynamic[tFinal],Number]}*)
(*		}];*)
(*		*)
(*		pane=DialogInput[*)
(*			Grid[{*)
(*				{mets,Dynamic[plotSimulation[FilterRules[sim[[1]],met],{t,tStart,tFinal},ImageSize->simSize]],*)
(*					plotPhasePortrait[sim[[1]],{t,0,10},ImageSize->ppSize]},*)
(*				{fluxes,Dynamic[plotSimulation[FilterRules[sim[[2]],flux],{t,0,10},ImageSize->simSize]],*)
(*					plotPhasePortrait[sim[[2]],{t,0,10},ImageSize->ppSize]},*)
(*				{Column[{Button["Edit model",DialogReturn["EDIT"]],Button["Save model",DialogReturn["SAVE"]]}],*)
(*					vars}*)
(*			}],WindowTitle->"Visualization Pane"*)
(*		];*)
(**)
(*		Switch[pane,*)
(*			"EDIT",*)
(*				newModel=edit[model,"","","Evaluate"->True];*)
(*				quickView[newModel,name],*)
(*			"SAVE",*)
(*				Evaluate@ToExpression[name]=model,*)
(*			$Failed,*)
(*				Null;*)
(*		]*)
(*	]*)
(*]/;MatchQ[model,_MASSmodel];*)


(* ::Section:: *)
(*End*)


End[]
