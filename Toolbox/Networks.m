(* ::Package:: *)

(* ::Title:: *)
(*Networks*)


(* ::Section:: *)
(*Definitions*)


Begin["`Private`"]


Unprotect[stoich2bipartite];
stoich2bipartite[stoich_?MatrixQ,rxns_List,mets_List]:=Block[{productPos,substratePos},
productPos=Position[stoich,a_/;a>0];
substratePos=Position[stoich,a_/;a<0];
Join[Table[Rule[rxns[[elem[[2]]]],mets[[elem[[1]]]]],{elem,productPos}],Table[Rule[mets[[elem[[1]]]],rxns[[elem[[2]]]]],{elem,substratePos}]]
];
def:stoich2bipartite[___]:=(Message[Toolbox::badargs,stoich2bipartite,Defer@def];Abort[])
Protect[stoich2bipartite];


Unprotect[reactions2bipartite];
Options[reactions2bipartite]={"AliasingRules"->{},"DeletionRules"->{},"EdgeDirections"->False};
reactions2bipartite[reactions:{_reaction..},opts:OptionsPattern[]]:=Module[{id,aliasing,substr,prod,revQ,tmpRxns},
If[OptionValue["EdgeDirections"]===True,#,#[[All,1]]]&@Flatten[Table[
	id=v[getID[rxn]];
	revQ=reversibleQ[rxn];
	aliasing=#->m[getID[#]<>ToString[Unique[]],getCompartment[#]]&/@(id/.OptionValue["AliasingRules"]/.id->{});
	substr=DeleteCases[getSubstrates[rxn]/.Dispatch[aliasing],elem_/;MemberQ[id/.OptionValue["DeletionRules"]/.id->{},elem]];
	prod=DeleteCases[getProducts[rxn]/.Dispatch[aliasing],elem_/;MemberQ[id/.OptionValue["DeletionRules"]/.id->{},elem]];
	tmpRxns=Thread[{Join[Thread[Rule[substr,id]],Thread[Rule[id,prod]]],"Forward"}];
	If[revQ,Join[tmpRxns,Thread[{Reverse/@tmpRxns[[All,1]],"Reverse"}]],tmpRxns]
,{rxn,reactions}],1]
];
def:reactions2bipartite[___]:=(Message[Toolbox::badargs,reactions2bipartite,Defer@def];Abort[])
Protect[reactions2bipartite];


Unprotect[model2bipartite];
Options[model2bipartite]=Options[reactions2bipartite];
model2bipartite[model_MASSmodel,opts:OptionsPattern[]]:=Module[{id,aliasing,substr,prod},
reactions2bipartite[model["Reactions"],opts]
];
def:model2bipartite[___]:=(Message[Toolbox::badargs,model2bipartite,Defer@def];Abort[])
Protect[model2bipartite];


Unprotect[gpr2graphs];
gpr2graphs[gpr:{_Rule..}]:=Module[{prots,genes,gprGraph,gprGraphs,genes2complexes},
genes2complexes=Flatten@Table[
prots=List@@complex;
genes=Flatten[ReplaceList[#,gpr]&/@prots];
Thread[Rule[genes,complex]]
,{complex,Union[Cases[gpr,_proteinComplex,\[Infinity]]]}];
gprGraph=DeleteCases[#,r_Rule/;r[[1]]==None,\[Infinity]]&@Join[Flatten[(Reverse/@gpr)/.Rule[proteins_Or,id_String]:>Thread[Rule[List@@proteins,id]]],genes2complexes];
gprGraph=DeleteCases[gprGraph,r_Rule/;Head[r[[2]]]===protein&&!MemberQ[gprGraph,Rule[r[[2]],_]]];gprGraphs=Cases[gprGraph,r_Rule/;MemberQ[#,r[[1]]]&&MemberQ[#,r[[2]]]]&/@ConnectedComponents[Graph[gprGraph/.r_Rule:>UndirectedEdge@@r]];
gprGraphs
];
gpr2graphs[model_MASSmodel]:=gpr2graphs[model["GPR"]]
gpr2graphs[{}]:={}
def:gpr2graphs[___]:=(Message[Toolbox::badargs,gpr2graphs,Defer@def];Abort[])
Protect[gpr2graphs];


Unprotect[pathwaytize];
Options[pathwaytize]={"Method"->"Mask"};
pathwaytize::wrngmethod="`1` is not suitable method for the function pathwaytize. Choose between 'Mask' and 'Remove'.";
pathwaytize::notenoughhubs="You are attempting to remove/mask more nodes from/in the network as have been identified as suitable hubs. Removing all hubs instead ...";
pathwaytize[net:{_Rule..},num_Integer,exclude_List:{},opts:OptionsPattern[]]:=Block[{hubs},
hubs=Cases[DeleteCases[Sort[Tally[Flatten[List@@@net]],#[[2]]>#2[[2]]&][[All,1]],a_/;MemberQ[exclude,a]],$MASS$speciesPattern];
hubs=Check[hubs[[1;;num]],Message[pathwaytize::notenoughhubs];hubs,Part::take];
Switch[OptionValue["Method"],
"Mask",net/.blub:$MASS$speciesPattern/;MemberQ[hubs,blub]:>metabolite[getID[blub]<>ToString[Unique[]],getCompartment[blub]],
"Remove",DeleteCases[net,r_Rule/;MemberQ[hubs,r[[1]]]||MemberQ[hubs,r[[2]]],\[Infinity]],
_,Message[pathwaytize::wrngmethod,OptionValue["Method"]];Abort[];
]
];
def:pathwaytize[___]:=(Message[Toolbox::badargs,pathwaytize,Defer@def];Abort[])
Protect[pathwaytize];


(* ::Subsection:: *)
(*End*)


End[]

