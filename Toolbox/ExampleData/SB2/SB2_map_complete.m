(* ::Package:: *)

Module[{iABmets2sb2,iABrxns2sb2,changeDirection,cmpdPos,rxnPos,text,metLabels,rxnLabels,otherLabels},
	iABmets2sb2={"glc-D"->"glu","g3p"->"gap","pi"->"phos","13dpg"->"pg13","23dpg"->"dpg23","3pg"->"pg3","2pg"->"pg2","lac-L"->"lac","6pgl"->"gl6p","6pgc"->"go6p","ru5p-D"->"ru5p","xu5p-D"->"x5p","gthox"->"gssg","gthrd"->"gsh","adn"->"ado","ins"->"ino","hxan"->"hyp","nh4"->"nh3","ppi"->"phos"};
	iABrxns2sb2={"HEX1"->"vhk","PGI"->"vpgi","PFK"->"vpfk","TPI"->"vtpi","FBA"->"vald","GAPD"->"vgapdh","PGK"->"vpgk","PGM"->"vpglm","ENO"->"veno","PYK"->"vpk","LDH_L"->"vldh","ADK1"->"vapk","PYRt2r"->"vpyr","L-LACt2r"->"vlac","ATPM"->"vatp","DM_nadh"->"vnadh","GLCt1r"->"vgluin","Ht"->"vh","H2Ot"->"vh2o","G6PDH2r"->"vg6pdh","PGL"->"vpglase","GND"->"vgl6pdh","RPE"->"vr5pe","RPI"->"vr5pi","TKT1"->"vtki","TKT2"->"vtkii","TALA"->"vtala","GTHO"->"vgssgr","GTHP"->"vgshr","ADA"->"vada","ADPT"->"vadprt","ADNK1"->"vak","NTD7"->"vampase","AMPDA"->"vampda","NTD11"->"vimpase","PUNP5"->"vpnpase","PPM"->"vprm","PRPPS"->"vprppsyn","NH4t3r"->"vnh3","CO2t"->"vco2","HYXNt"->"vhyp","ADNt"->"vado","ADEt"->"vade","INSt"->"vino","PIt"->"vphos"};
	changeDirection={"vpyr","vlac","vldh","vpglm","vpgk","vr5pi","vapk","vh2o"};
	{cmpdPos,rxnPos,text}=importBIGGmap[FileNameJoin[{$ToolboxPath,"ExampleData","SB2","RBC_complete.svg"}]]/.iABmets2sb2/.iABrxns2sb2;
	rxnPos=rxnPos/.r_Rule/;MemberQ[changeDirection,r[[1]]]:>(r[[1]]->({Reverse@#[[1]],-1*#[[2]]}&/@r[[2]]));
	cmpdPos=Join[cmpdPos,{"dpg23"->{2089,-1947,25},"deoxyHb"->{1900,-1745,25},"Hb"->{1900,-1950,25},"Hb[c] & o2[c]"->{1900,-2145,25},"Hb[c] & 2 o2[c]"->{1900,-2345,25},"Hb[c] & 3 o2[c]"->{1900,-2545,25},"Hb[c] & 4 o2[c]"->{1900,-2745,25},"o2"->{1750,-2000,20},"o2"->{1750,-2200,20},"o2"->{1750,-2400,20},"o2"->{1750,-2600,20}}];
	rxnPos=Join[rxnPos,{
		"vdpgm"->{{{{2226,-1945},{2128,-1945}},-1}},
		"vdpgase"->{{{{2100,-2000},{2250,-2200}},-1}},
		"vhbdpg"->{{{{1900,-1905},{1900,-1790}},1},{{{2042,-1938},{1901,-1900},{1901,-1900},{1901,-1794}},1},{{{1900,-1905},{1900,-1790}},-1},{{{2042,-1938},{1901,-1900},{1901,-1900},{1901,-1794}},-1}},
		"vhbo1"->{{{{1900,-1990},{1900,-2105}},1},{{{1900,-1990},{1900,-2105}},-1},{{{1782,-2004},{1900,-1990},{1900,-2090},{1900,-2060}},1}},
		"vhbo2"->{{{{1900,-2190},{1900,-2305}},1},{{{1900,-2190},{1900,-2305}},-1},{{{1782,-2204},{1900,-2190},{1900,-2290},{1900,-2260}},1}},
		"vhbo3"->{{{{1900,-2390},{1900,-2505}},1},{{{1900,-2390},{1900,-2505}},-1},{{{1782,-2404},{1900,-2390},{1900,-2490},{1900,-2460}},1}},
		"vhbo4"->{{{{1900,-2590},{1900,-2705}},1},{{{1900,-2590},{1900,-2705}},-1},{{{1782,-2604},{1900,-2590},{1900,-2690},{1900,-2660}},1}}
	}];
	metLabels=Join[text[[1]],{Text["dpg23",{2015,-1971}],Text["deoxyHb",{1850,-1780},Right],Text["Hb",{1850,-1950},Right],Text["Hb&\!\(\*SubscriptBox[\(O\), \(2\)]\)",{2050,-2150},Right],Text["Hb&2\!\(\*SubscriptBox[\(O\), \(2\)]\)",{2050,-2350},Right],Text["Hb&3\!\(\*SubscriptBox[\(O\), \(2\)]\)",{2050,-2550},Right],Text["Hb&4\!\(\*SubscriptBox[\(O\), \(2\)]\)",{2050,-2750},Right],Text["\!\(\*SubscriptBox[\(O\), \(2\)]\)",{1709,-2009},Right],Text["\!\(\*SubscriptBox[\(O\), \(2\)]\)",{1709,-2209},Right],Text["\!\(\*SubscriptBox[\(O\), \(2\)]\)",{1709,-2409},Right],Text["\!\(\*SubscriptBox[\(O\), \(2\)]\)",{1709,-2609},Right]}];
	rxnLabels=Join[text[[2]],{Text["vdpgm",{2181,-1971}],Text["vdpgase",{2145,-2244}]}];
	otherLabels=Join[text[[3]][[2;;,2]],{Text["Hemoglobin",{1702, -1552}]}];
	{cmpdPos,rxnPos,Join[metLabels,rxnLabels,otherLabels]}
]
