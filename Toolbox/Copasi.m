(* ::Package:: *)

(* ::Title:: *)
(*Copasi*)


(* ::Section:: *)
(*Package Header*)


BeginPackage["Toolbox`Copasi`",{"Toolbox`","Toolbox`IO`"}]


(* Exported symbols added here with SymbolName::usage *) 


(* ::Section:: *)
(*Documentation*)


copasiParameterEstimation::usage="copasiParameterEstimation[model, paramaters, experimentalData, opts] utilizes CopasiSE for parameter estimation.
Function arguments:
'model' has to be either a symbolic XML representation of a Copasi model (as produced by model2copasi or sbml2copasi) or a MASSmodel.
'parameters' has to be a list of specifications for the parameters to be estimated({{param, startValue, lowerBound, upperBound}, ..}).
'experimentalData' has to a set of experiment descriptions ({experimentID_String, (\"SteadyState\"|\"TimeCourse\")} \[Rule] data; data has to be in form of table where the first row is a header of the columns' descriptions).
"


copasiParseParameterEstimationReport::usage="Parses the parameter estimation report produced by Copasi."


copasiParseSteadyStateReport::usage="Parses the steady-state analysis report produced by Copasi."


copasiPlotParameterEstimationResult::usage="Plots the results of a parameter estimation. Takes a parsed parameter estimation report as input (copasiParseParameterEstimationReport)."


copasiSteadyStateAnalysis::usage="copasiSteadyStateAnalysis[model] performs a steady-state analysis of model using CopasiSE. 'model' can either be a symbolic XML representation of a Copasi model (as produced by model2copasi or sbml2copasi) or a MASSmodel."


model2copasi::usage="model2copasi[model_MASSmodel,opts] returns a symbolic XML representation of the copasi CPS model definition."


sbml2copasi::usage="sbml2copasi[sbml, opts] returns a symbolic XML representation of the copasi CPS model definition. Accepts both symbolic or string representations of an 'sbml' model."


(* ::Section:: *)
(*Definitions*)


Begin["`Private`"]


getParameterEstimationTask=Cases[#,XMLElement["Task",attr_/;("name"/.attr)=="Parameter Estimation",_],\[Infinity]][[1]]&;


scheduleTask[XMLElement["Task",attr_,data_]]:=XMLElement["Task",updateRules[attr,{"scheduled"->"true"}],data]


setReportTarget[xml_XMLElement,path_String:"/dev/stdout"]:=xml/.XMLElement["Report",attr_,dat_]:>XMLElement["Report",attr/.Rule["target",_String]:>Rule["target",path],dat];


Options[setParameterEstimationMethod]={"Iteration Limit"->Automatic,"Number of Generations"->Automatic,"Number of Iterations"->Automatic,"Population Size"->Automatic,"Random Number Generator"->Automatic,"Rho"->Automatic,"Seed"->Automatic,"Std. Deviation"->Automatic,"Swarm Size"->Automatic,"Tolerance"->Automatic};
setParameterEstimationMethod[task:XMLElement["Task",{___,"name"->"Parameter Estimation",___},_],method_String,opts:OptionsPattern[]]:=Module[{methods},
methods={"GeneticAlgorithm"->XMLElement["Method",{"name"->"Genetic Algorithm","type"->"GeneticAlgorithm"},{XMLElement["Parameter",{"name"->"Number of Generations","type"->"unsignedInteger","value"->"200"},{}],XMLElement["Parameter",{"name"->"Population Size","type"->"unsignedInteger","value"->"20"},{}],XMLElement["Parameter",{"name"->"Random Number Generator","type"->"unsignedInteger","value"->"1"},{}],XMLElement["Parameter",{"name"->"Seed","type"->"unsignedInteger","value"->"0"},{}]}],
"GeneticAlgorithmSR"->XMLElement["Method",{"name"->"Genetic Algorithm SR","type"->"GeneticAlgorithmSR"},{XMLElement["Parameter",{"name"->"Number of Generations","type"->"unsignedInteger","value"->"200"},{}],XMLElement["Parameter",{"name"->"Population Size","type"->"unsignedInteger","value"->"20"},{}],XMLElement["Parameter",{"name"->"Random Number Generator","type"->"unsignedInteger","value"->"1"},{}],XMLElement["Parameter",{"name"->"Seed","type"->"unsignedInteger","value"->"0"},{}],XMLElement["Parameter",{"name"->"Pf","type"->"float","value"->"0.475"},{}]}];
"ParticleSwarm"->XMLElement["Method",{"name"->"Particle Swarm","type"->"ParticleSwarm"},{XMLElement["Parameter",{"name"->"Iteration Limit","type"->"unsignedInteger","value"->"2000"},{}],XMLElement["Parameter",{"name"->"Swarm Size","type"->"unsignedInteger","value"->"50"},{}],XMLElement["Parameter",{"name"->"Std. Deviation","type"->"unsignedFloat","value"->"1e-06"},{}],XMLElement["Parameter",{"name"->"Random Number Generator","type"->"unsignedInteger","value"->"1"},{}],XMLElement["Parameter",{"name"->"Seed","type"->"unsignedInteger","value"->"0"},{}]}],
"EvolutionaryProgramming"->XMLElement["Method",{"name"->"Evolutionary Programming","type"->"EvolutionaryProgram"},{XMLElement["Parameter",{"name"->"Number of Generations","type"->"unsignedInteger","value"->"200"},{}],XMLElement["Parameter",{"name"->"Population Size","type"->"unsignedInteger","value"->"20"},{}],XMLElement["Parameter",{"name"->"Random Number Generator","type"->"unsignedInteger","value"->"1"},{}],XMLElement["Parameter",{"name"->"Seed","type"->"unsignedInteger","value"->"0"},{}]}],
"HookeJeeves"->XMLElement["Method",{"name"->"Hooke & Jeeves","type"->"HookeJeeves"},{XMLElement["Parameter",{"name"->"Iteration Limit","type"->"unsignedInteger","value"->"50"},{}],XMLElement["Parameter",{"name"->"Tolerance","type"->"float","value"->"1e-05"},{}],XMLElement["Parameter",{"name"->"Rho","type"->"float","value"->"0.2"},{}]}],
"LevenbergMarquardt"->XMLElement["Method",{"name"->"Levenberg - Marquardt","type"->"LevenbergMarquardt"},{XMLElement["Parameter",{"name"->"Iteration Limit","type"->"unsignedInteger","value"->"200"},{}],XMLElement["Parameter",{"name"->"Tolerance","type"->"float","value"->"1e-05"},{}]}],
"RandomSearch"->XMLElement["Method",{"name"->"Random Search","type"->"RandomSearch"},{XMLElement["Parameter",{"name"->"Number of Iterations","type"->"unsignedInteger","value"->"100000"},{}],XMLElement["Parameter",{"name"->"Random Number Generator","type"->"unsignedInteger","value"->"1"},{}],XMLElement["Parameter",{"name"->"Seed","type"->"unsignedInteger","value"->"0"},{}]}]
};
Options[setParameterEstimationMethod]=Thread[Rule[Cases[methods,XMLElement["Parameter",{___,"name"->pat_,___},_]:>pat,\[Infinity]],Automatic]];
optsMod=Table[xml_XMLElement/;xml[[1]]==="Parameter"&&("name"/.xml[[2]])==#:>(xml/.Rule["value",_String]:>Rule["value",ToString[#2]])&[elem[[1]],elem[[2]]],{elem,List@opts}];
task/.XMLElement["Method",__]:>((method/.methods)/.optsMod)
];


constructOptimizationList[parameters:{_Rule..},modelID_]:=Module[{newOptimizationList,startValue,lowerBound,upperBound,parameterID,rxnID},
newOptimizationList=XMLElement["ParameterGroup",{"name"->"OptimizationItemList"},
Table[
{startValue,lowerBound,upperBound}={"StartValue","LowerBound","UpperBound"}/.Dispatch[set[[2]]];
(*parameterID=ToString[set[[1]]];
rxnID=getID[set[[1]]];*)
XMLElement["ParameterGroup",{"name"->"FitItem"},{
If[("AffectedExperiments"/.set[[2]])==="AffectedExperiments",
XMLElement["ParameterGroup",{"name"->"Affected Experiments"},{}],
(*Print["AffectedExperiments"/.set[[2]]];*)
XMLElement["ParameterGroup",{"name"->"Affected Experiments"},{XMLElement["Parameter",{"name"->"Experiment Key","type"->"key","value"->("AffectedExperiments"/.set[[2]])},{}]}]
],
XMLElement["Parameter",{"name"->"LowerBound","type"->"cn","value"->StringReplace[ToString[lowerBound],"Infinity"->"inf"]},{}],
Switch[set[[1]],
_rateconst|_Keq,
XMLElement["Parameter",{"name"->"ObjectCN","type"->"cn","value"->"CN=Root,Model="<>ToString[modelID]<>",Vector=Reactions["<>getID[set[[1]]]<>"],ParameterGroup=Parameters,Parameter="<>ToString[set[[1]]]<>",Reference=Value"},{}],
parameter[_String,_String],
XMLElement["Parameter",{"name"->"ObjectCN","type"->"cn","value"->"CN=Root,Model="<>ToString[modelID]<>",Vector=Reactions["<>getID[set[[1]]][[2]]<>"],ParameterGroup=Parameters,Parameter="<>getID[set[[1]]][[1]]<>",Reference=Value"},{}],
parameter[_String],
XMLElement["Parameter",{"name"->"ObjectCN","type"->"cn","value"->"CN=Root,Model="<>ToString[modelID]<>",Vector=Values["<>getID[set[[1]]]<>"],"<>"Reference=Value"},{}],
(_metabolite|_species),
XMLElement["Parameter",{"name"->"ObjectCN","type"->"cn","value"->"CN=Root,Model="<>ToString[modelID]<>",Vector=Compartments["<>getCompartment[set[[1]]]<>"],Vector=Metabolites["<>ToString[set[[1]]]<>"],Reference=InitialConcentration"},{}]
]
,XMLElement["Parameter",{"name"->"StartValue","type"->"float","value"->ToString[startValue]},{}],
XMLElement["Parameter",{"name"->"UpperBound","type"->"cn","value"->StringReplace[ToString[upperBound],"Infinity"->"inf"]},{}]}]
,{set,parameters}]]
];


setOptimizationList[task:XMLElement["Task",{___,"name"->"Parameter Estimation",___},_],parameters:{_Rule..},modelID_]:=Module[{newOptimizationList,startValue,lowerBound,upperBound,parameterID,rxnID},
newOptimizationList=constructOptimizationList[parameters,modelID];
task/.XMLElement["ParameterGroup",{___,"name"->"OptimizationItemList",___},_]:>newOptimizationList
];


setExperimentSets[task:XMLElement["Task",{___,"name"->"Parameter Estimation",___},_],experimentalData:{({(*experimentID*)_String,(*experimentType*)_String,(*vartypes*)_List,(*path*)_String}->(*data*)_List)..},modelID_String]:=Module[{experimentSets},
experimentSets=constructExperimentSets[experimentalData,modelID];
task/.XMLElement["ParameterGroup",{a___,"name"->"Experiment Set",b___},c_]:>experimentSets]


constructExperimentSets[experimentalData:{({(*experimentID*)_String,(*experimentType*)_String,(*vartypes*)_List,(*path*)_String}->(*data*)_List)..},modelID_String]:=Module[{},
XMLElement["ParameterGroup",{"name"->"Experiment Set"},Table[constructExperiment[exp,modelID],{exp,experimentalData}]]
];


constructExperiment[{experimentID_String,experimentType_String,varTypes_List,path_String}->data_List,modelID_String]:=Module[{experimentTypeMapping},
experimentTypeMapping={"SteadyState"->"0","TimeCourse"->"1"};
XMLElement["ParameterGroup",{"name"->experimentID},{
XMLElement["Parameter",{"name"->"Data is Row Oriented","type"->"bool","value"->"1"},{}],
XMLElement["Parameter",{"name"->"Experiment Type","type"->"unsignedInteger","value"->(experimentType/.experimentTypeMapping)},{}],
XMLElement["Parameter",{"name"->"File Name","type"->"file","value"->path},{}],
XMLElement["Parameter",{"name"->"First Row","type"->"unsignedInteger","value"->"1"},{}],
(*XMLElement["Parameter",{"name"->"Key","type"->"key","value"->ToString@Unique[]},{}],*)
XMLElement["Parameter",{"name"->"Key","type"->"key","value"->experimentID},{}],
XMLElement["Parameter",{"name"->"Last Row","type"->"unsignedInteger","value"->ToString[Length[data]]},{}],
XMLElement["Parameter",{"name"->"Number of Columns","type"->"unsignedInteger","value"->ToString[Length[Transpose[data]]]},{}],
XMLElement["Parameter",{"name"->"Row containing Names","type"->"unsignedInteger","value"->"1"},{}],
XMLElement["Parameter",{"name"->"Seperator","type"->"string","value"->"&#x09;"},{}],
XMLElement["Parameter",{"name"->"Weight Method","type"->"unsignedInteger","value"->"1"},{}],
constructObjectMap[data[[1]],varTypes,experimentType,modelID]
}
]
]


copasi::wrngVarType="The variable type `1` does not match any suitable category. Please, choose between 'dependent' or 'independent' ('ignored' is not supported).";
coapsi::ststIndpendentVar="###FIXME###";
constructObjectMap[header_List,varTypes_List,experimentType_String,modelID_String]:=Module[{},
Switch[experimentType,
"TimeCourse",XMLElement["ParameterGroup",{"name"->"Object Map"},{
XMLElement["ParameterGroup",{"name"->"0"},{XMLElement["Parameter",{"name"->"Role","type"->"unsignedInteger","value"->"3"},{}]}],
Sequence@@Table[
Switch[varTypes[[i]],
"dependent",dependentTransientConcentration[ToString[i],header[[i+1]],modelID],
"independent",independentInitialConcentration[ToString[i],header[[i+1]],modelID],
_,Message[copasi::wrngVarType,varTypes[[i+1]]];Abort[];]
,{i,1,Length[header]-1}]}],
"SteadyState",XMLElement["ParameterGroup",{"name"->"Object Map"},{
Sequence@@Table[
Switch[varTypes[[i]],
"dependent",dependentInitialConcentration[ToString[i],header[[i+1]],modelID],
"independent",Message[coapsi::ststIndpendentVar];Abort[];,
_,Message[copasi::wrngVarType,varTypes[[i+1]]]]
,{i,0,Length[header]-1}]}]
]
];


dependentTransientConcentration[columnID_String,met:(_metabolite|_species),modelID_String]:=Module[{},
XMLElement["ParameterGroup",{"name"->columnID},{
XMLElement["Parameter",{"name"->"Object CN","type"->"cn","value"->"CN=Root,Model="<>modelID<>",Vector=Compartments["<>getCompartment[met]<>"],Vector=Metabolites["<>getID[met]<>"],Reference=Concentration"},{}],XMLElement["Parameter",{"name"->"Role","type"->"unsignedInteger","value"->"2"},{}]}]
];


independentInitialConcentration[columnID_String,met:(_metabolite|_species),modelID_String]:=Module[{},

XMLElement["ParameterGroup",{"name"->columnID},{XMLElement["Parameter",{"name"->"Object CN","type"->"cn","value"->"CN=Root,Model="<>modelID<>",Vector=Compartments["<>getCompartment[met]<>"],Vector=Metabolites["<>getID[met]<>"],Reference=InitialConcentration"},{}],XMLElement["Parameter",{"name"->"Role","type"->"unsignedInteger","value"->"1"},{}]}]
];


dependentInitialConcentration[columnID_String,met:(_metabolite|_species),modelID_String]:=Module[{},
XMLElement["ParameterGroup",{"name"->columnID},{XMLElement["Parameter",{"name"->"Object CN","type"->"cn","value"->"CN=Root,Model="<>modelID<>",Vector=Compartments["<>getCompartment[met]<>"],Vector=Metabolites["<>getID[met]<>"],Reference=InitialConcentration"},{}],XMLElement["Parameter",{"name"->"Role","type"->"unsignedInteger","value"->"2"},{}]}]
];



Unprotect[model2copasi];
model2copasi[model_MASSmodel,opts:OptionsPattern[]]:=Module[{tmpFile},
tmpFile=OpenWrite[];
WriteString[tmpFile,ExportString[model2sbml[model,opts],"XML"]];
Close[tmpFile];
Import["!source ~/.bash_profile && CopasiSE -i "<>tmpFile[[1]]<>" -s "<>tmpFile[[1]]<>".cps","Text"];
Import[tmpFile[[1]]<>".cps","XML"]
];
Protect[model2copasi];


Unprotect[sbml2copasi];
ClearAll@sbml2copasi;
sbml2copasi[sbml_String,opts:OptionsPattern[]]:=Module[{tmpFile},
tmpFile=OpenWrite[];

WriteString[tmpFile,sbml];
Close[tmpFile];
Import["!source ~/.bash_profile && CopasiSE -i "<>tmpFile[[1]]<>" -s "<>tmpFile[[1]]<>".cps","Text"];
Import[tmpFile[[1]]<>".cps","XML"]
];
sbml2copasi[sbml_/;Head[sbml]===XMLObject["Document"],opts:OptionsPattern[]]:=Module[{tmpFile},
sbml2copasi[ExportString[sbml,"XML"],opts]
];
Protect[sbml2copasi];


Unprotect[copasiParameterEstimation];
Options[copasiParameterEstimation]=Join[{"Output"->"/dev/stdout","Method"->"EvolutionaryProgramming"},Options[setParameterEstimationMethod]];
copasiParameterEstimation[copasiModelXML:XMLObject["Document"][__],parameters:{(_->{(_->_)..})..},experimentalData:{({(*experimentID*)_String,(*experimentType*)_String,(*varTypes*)_List}->(*data*)_List)..},opts:OptionsPattern[]]:=Module[{tmpFile,experimentalData2,modelFile,modelID,adjustedModel},
modelID=StringReplace[Cases[copasiModelXML,XMLElement["Model",{___,"name"->id_,___},_]:>id,\[Infinity]][[1]],"$"->"_"];
experimentalData2=Table[
tmpFile=OpenWrite[];
WriteString[tmpFile,ExportString[exp[[2]],"TSV"]];
Close[tmpFile];
Append[exp[[1]],tmpFile[[1]]]->exp[[2]]
,{exp,experimentalData}];

adjustedModel=copasiModelXML/.task:XMLElement["Task",{___,"name"->"Parameter Estimation",___},_]:>
setExperimentSets[
setOptimizationList[
setParameterEstimationMethod[
setReportTarget[
scheduleTask[task],OptionValue["Output"]
],
OptionValue["Method"],Sequence@@FilterRules[List@opts,Options[setParameterEstimationMethod]]
],
parameters,modelID
],
experimentalData2,modelID
];

modelFile=OpenWrite[];
WriteString[modelFile,StringReplace[#,"&amp;#x09;"->"&#x09;"]&@ExportString[adjustedModel,"XML","AttributeQuoting"->"\"","Entities"->{"\t"->"&#x09;"}]];
Export["/Users/niko/Desktop/debugPE.cps",StringReplace[#,"&amp;#x09;"->"&#x09;"]&@ExportString[adjustedModel,"XML","AttributeQuoting"->"\"","Entities"->{"\t"->"&#x09;"}],"Text"];
Close[modelFile];

Import["!source ~/.bash_profile && CopasiSE "<>modelFile[[1]],"Text"]
];
copasiParameterEstimation[model_MASSmodel,paramaters:{{(*param*)_,(*startValue*)_Real,(*lowerBound*)_,(*upperBound*)_}..},experimentalData:{({(*experimentID*)_String,(*experimentType*)_String}->(*data*)_List)..},opts:OptionsPattern[]]:=copasiParameterEstimation[model2copasi[model],paramaters,experimentalData,opts]
Protect[copasiParameterEstimation];


Unprotect[copasiParseParameterEstimationReport];
copasiParseParameterEstimationReport[report_String]:=Module[{getExpTables,getExpTableHeader,getExpTableDat,getExpID,expTables},
getExpTables=StringCases[#,RegularExpression["(?ms)(File Name:.+?^$\n.*?)\n^$"]:>"$1"]&;
getExpTableHeader=StringSplit[StringCases[#,RegularExpression["(?ms)^Row.+?$"]][[1]],RegularExpression["\t"]][[2;;]]&;
getExpTableDat=ImportString[StringCases[#,RegularExpression["(?sm)^$\\n(.+)\nObjectiv"]:>"$1"][[1]],"Table"][[All,2;;]]&;
getExpID=StringCases[#,RegularExpression["Experiment:\\s+(\\w+)"]:>"$1"][[1]]&;
expTables=getExpTables[report];
getExpID[#]->{getExpTableHeader[#],getExpTableDat[#]}&/@expTables
];
Protect[copasiParseParameterEstimationReport];


Unprotect[copasiPlotParameterEstimationResult];
Options[copasiPlotParameterEstimationResult]=Join[{"PlotFunction"->ListLogLinearPlot},Options[ListPlot]];
copasiPlotParameterEstimationResult[parsedReportTable_Rule,opts:OptionsPattern[]]:=Module[{tableData,time,timeCourses,tableHeader,fitPos,datPos,timeCoursesData,timeCoursesFit,dataHeader,fitHeader,p1,p2},
tableData=parsedReportTable[[2,2]];
tableHeader=parsedReportTable[[2,1]];
time=Transpose[tableData][[1]];
fitPos=Position[tableHeader[[2;;]],s_String/;StringMatchQ[s,RegularExpression[".+Fit.+"]]];
datPos=Position[tableHeader[[2;;]],s_String/;StringMatchQ[s,RegularExpression[".+Data.+"]]];
timeCoursesData=Thread[List[time,#]]&/@Transpose[tableData][[2;;]][[Flatten@datPos]];
timeCoursesFit=Thread[List[time,#]]&/@Transpose[tableData][[2;;]][[Flatten@fitPos]];
dataHeader=tableHeader[[2;;]][[Flatten@datPos]];
fitHeader=tableHeader[[2;;]][[Flatten@fitPos]];
p1=OptionValue["PlotFunction"][Thread[Tooltip[timeCoursesData,dataHeader]],Sequence@@FilterRules[List[opts],Options[OptionValue["PlotFunction"]]],Joined->True,PlotStyle->Automatic,PlotLabel->parsedReportTable[[1]]];
p2=OptionValue["PlotFunction"][Thread[Tooltip[timeCoursesFit,fitHeader]],PlotStyle->{Dotted,Thick},PlotStyle->Automatic];
Show[p1,p2]
];
Protect[copasiPlotParameterEstimationResult];


Unprotect[copasiSteadyStateAnalysis];
copasiSteadyStateAnalysis[copasiModelXML:XMLObject["Document"][__],output_:"/dev/stdout"]:=Module[{rule,modModel,tmpFile},
rule=task:XMLElement["Task",attr_/;MemberQ[attr,Rule["name","Steady-State"]],_]:>setReportTarget[scheduleTask[task],output];
modModel=copasiModelXML/.rule;
tmpFile=OpenWrite[];
WriteString[tmpFile,ExportString[modModel/.rule,"XML"]];
Import["!source ~/.bash_profile && CopasiSE "<>tmpFile[[1]],"Text"]
];

copasiSteadyStateAnalysis[model_MASSmodel,output_:"/dev/stdout"]:=Module[{},
copasiSteadyStateAnalysis[model2copasi[model],output]
];
Protect[copasiSteadyStateAnalysis];


Unprotect[copasiParseSteadyStateReport];
copasiParseSteadyStateReport[report_String]:=Module[{getStatusLine,getSteadyStateConc,getSteadyStateFluxes,cleanHeader},
(*Copasi only attaches compartment information to species IDs if there are conflicts (e.g. atp{c} and atp{e})*)
cleanHeader=StringReplace[#,RegularExpression["(?ms)COPASI.+?^$\n"]->""]&;
getStatusLine=StringCases[#,RegularExpression["(?ms)(^.+?$)\n^$\n"]:>"$1"][[1]]&;
getSteadyStateConc=Rule@@@ImportString[StringCases[#,RegularExpression["(?ms).+?^$\n(^Species.+?$)\n^$\n"]:>"$1"][[1]],"Table"][[2;;,{1,2}]]&;
getSteadyStateFluxes=Rule@@@ImportString[StringCases[#,RegularExpression["(?ms).+?^$\n(^Reaction.+?$)\n^$\n"]:>"$1"][[1]],"Table"][[2;;,{1,2}]]&;
{getStatusLine[#],getSteadyStateConc[#],getSteadyStateFluxes[#]}&[cleanHeader@report]
];
Protect[copasiParseSteadyStateReport];


(* ::Section::Closed:: *)
(*Package Footer*)


End[]

EndPackage[]
