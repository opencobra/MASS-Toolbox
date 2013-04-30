(* ::Package:: *)

(* ::Title:: *)
(*Util*)


(* ::Section:: *)
(*Definitions*)


Begin["`Private`"]


makeIdXmlConform[str_String]:=StringReplace[str,RegularExpression["([^a-z_A-Z0-9])"]:>("_Char"<>ToString[ToCharacterCode["$1"][[1]]]<>"_")]
reverseIdXmlConform[str_String]:=StringReplace[str,RegularExpression["(_Char)(\\d+)(_)"]:>FromCharacterCode[ToExpression["$2"]]]


filter[listOfRules:{(_Rule|_RuleDelayed)...},keys_List]:=Module[{cleanKeys},cleanKeys=Select[keys,MemberQ[listOfRules[[All,1]],#]&];Thread[cleanKeys->(cleanKeys/.FilterRules[listOfRules,cleanKeys])]]
filter[listOfRules:{(_Rule|_RuleDelayed)...},key_]:=filter[listOfRules,{key}]


query[attr_,{},default_:Automatic]:=default
query[attr_,dict:({_Rule..}|Dispatch[{_Rule..}]),default_:Automatic]:=If[default===Automatic,#,#/.attr:>default]&[(attr/.Dispatch[dict])]


(*extractXMLelement[xml_,tag_String]:=Replace[Cases[xml,XMLElement[tag,attrVal_,data_]:>Rule[attrVal,data],\[Infinity]],{}->{{}}][[1]]*)
extractXMLelement[xml_,tag:(_String|_Alternatives),0,level_:\[Infinity]]:=Cases[xml,XMLElement[tag,attrVal_,data_],level]
extractXMLelement[xml_,tag:(_String|_Alternatives),pos_,level_:\[Infinity]]:=Replace[Cases[xml,XMLElement[tag,attrVal_,data_]:>{attrVal,data}[[pos]],level],{}->{{}}][[1]]


SetAttributes[integerChop,Listable];
integerChop[number_Real]:=If[Round@number==number,Round@number,number]
integerChop[other_?NumberQ]:=other


getReferenceFluxesAndBoundsFromXML[path_String]:=Block[{tmp,tmp2,tmp3,tmp4},
tmp=Import[path,"Text"];
tmp2=StringCases[tmp,RegularExpression["(?s)listOfReactions.+"]];
tmp3=Flatten[StringSplit[tmp2,RegularExpression["<reaction id="]][[1]][[2;;]]];
tmp4=Quiet@StringCases[#,RegularExpression["(?s)^(\"R_.+?\").+\"LOWER_BOUND\"\\s*?value=\"([-\\d\\.]+)\".+?\"UPPER_BOUND\"\\s*?value=\"([\\d\\.]+)\".+?\"FLUX_VALUE\"\\s*?value=\"(.+?)\""]:>{"$1"->{ToExpression@"$2",ToExpression@"$3",ToExpression@"$4"}}]&/@tmp3;
Flatten[tmp4]/.s_String:>StringReplace[s,{"\""->""}]
];


Unprotect[parseJSON];
parseJSON[path_?FileExistsQ]:=parseJSON[Import[path,"Text"]]
parseJSON[json_String]:=Module[{cat,eval},
cat=StringJoin@@(ToString/@{##})&;(*Like sprintf/strout in C/C++.*)
eval=ToExpression;
ToExpression@StringReplace[cat@FullForm@eval[StringReplace[json,{"["->"(*MAGIC[*){","]"->"(*MAGIC]*)}",":"->"(*MAGIC:*)->","true"->"(*MAGICt*)True","false"->"(*MAGICf*)False","null"->"(*MAGICn*)Null","e"->"(*MAGICe*)*10^","E"->"(*MAGICE*)*10^"}]],{"(*MAGIC[*){"->"[","(*MAGIC]*)}"->"]","(*MAGIC:*)->"->":","(*MAGICt*)True"->"true","(*MAGICf*)False"->"false","(*MAGICn*)Null"->"null","(*MAGICe*)*10^"->"e","(*MAGICE*)*10^"->"E"}]]
def:parseJSON[___]:=(Message[Toolbox::badargs,parseJSON,Defer@def];Abort[])
Protect[parseJSON];


Unprotect[iwith];
iwith[pat_List,l_List] := Module[{mark},
iwith[mark, l /. Map[ (#-> mark)&,pat]]];
iwith[pat_,l_List] := Map[First,Position[l,pat]] //Union;
with[pat_,l_List] := l[[iwith[pat,l]]];
def:with[___]:=(Message[Toolbox::badargs,with,Defer@def];Abort[])
Protect[iwith];


Unprotect[updateRules];
updateRules[rules:{(_Rule|_RuleDelayed)..},newRules:{(_Rule|_RuleDelayed)..}]:=Module[{},
(*Join[DeleteCases[rules,r_Rule/;MemberQ[newRules[[All,1]],r[[1]]]],newRules]*)
Join[FilterRules[rules,Except[newRules/.pat_Blank:>Verbatim[pat]]],newRules]
];
updateRules[{},newRules:{(_Rule|_RuleDelayed)..}]:=newRules
updateRules[rules:{(_Rule|_RuleDelayed)..},{}]:=rules
updateRules[{},{}]:={}
updateRules[rules:{(_Rule|_RuleDelayed)..},rule:(_Rule|_RuleDelayed)]:=updateRules[rules,{rule}]
updateRules[rule:(_Rule|_RuleDelayed),rules:{(_Rule|_RuleDelayed)..}]:=updateRules[{rule},rules]
updateRules[rule1:(_Rule|_RuleDelayed),rule2:(_Rule|_RuleDelayed)]:=updateRules[{rule1},{rule2}]
updateRules[rules__]:=Fold[updateRules[#1,#2]&,List[rules][[1]],List[rules][[2;;]]]
def:updateRules[_,_]:=(Message[Toolbox::badargs,updateRules,Defer@def];Abort[])
Protect[updateRules];


Unprotect[scatterFromDicts];
scatterFromDicts[dicts__]:=Module[{ldicts,commonkeys},
ldicts=List[dicts];
commonkeys=Union[Flatten@Intersection[Sequence@@ldicts[[All,All,1]]]];
Table[k->(k/.#&/@ldicts),{k,commonkeys}]
];
Protect[scatterFromDicts];


Unprotect[calcLinkMatrix];
calcLinkMatrix[s_?MatrixQ]:=Module[{Q,R,independent,tmp,dependent,newOrder,rank},
	{Q,R}=QRDecomposition[N@Transpose[s]];
	dependent=Flatten[Position[Chop@Tr[R,List],0]];
	independent=Complement[Range[1,Length[s]],dependent];
	newOrder=Join[independent,dependent];
	s[[newOrder]].PseudoInverse[N@s[[independent]]];
	{newOrder,s[[newOrder]],s[[independent]],Chop[s[[newOrder]].PseudoInverse[N@s[[independent]]]]}
];
def:calcLinkMatrix[___]:=(Message[Toolbox::badargs,calcLinkMatrix,Defer@def];Abort[])
Protect[calcLinkMatrix];


(* ::Subsection::Closed:: *)
(*End*)


End[]
