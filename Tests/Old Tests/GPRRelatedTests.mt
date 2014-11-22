(* Mathematica Test File *)

SetDirectory[FileNameJoin[FileNameSplit[DirectoryName[FindFile["Toolbox`"]]][[;; -3]]]];

ecolicore=Import["Models/EcoliCoreLikeDanielPlusGPR.m"];

testGene = gene["b0002"];
testGene2 = gene["b0001","Locus"->{190, 255},"Synonyns"->{"thrL"}];

testProtein = protein["ThrL"]
testProtein2 = protein["ThrL", "EC"->"1.2.3.11"]


Test[
	getID[testProtein]
	,
	"ThrL"
	,
	TestID->"GPRRelatedTests-20120326-C1A3V8"
]

Test[
    getCompartment[testProtein]
    ,
    None
    ,
    TestID->"GPRRelatedTests-20120326-C1A3V8"
]

Test[
	getMetaData[testProtein]
	,
	{}
	,
	TestID->"GPRRelatedTests-20120326-D4G5Y7"
]

Test[
	getID[testProtein2]
	,
	"ThrL"
	,
	TestID->"GPRRelatedTests-20120326-M3M9D8"
]

Test[
	getMetaData[testProtein2]
	,
	{"EC"->"1.2.3.11"}
	,
	TestID->"GPRRelatedTests-20120326-G9C4S1"
]


Test[
	getID[testGene]
	,
	"b0002"
	,
	TestID->"GPRRelatedTests-20120326-R4O0H9"
]

Test[
	getMetaData[testGene]
	,
	{}
	,
	TestID->"GPRRelatedTests-20120326-Y1K4G8"
]

Test[
	getID[testGene2]
	,
	"b0001"
	,
	TestID->"GPRRelatedTests-20120326-B9D5B5"
]

Test[
	getMetaData[testGene2]
	,
	{"Locus"->{190, 255},"Synonyns"->{"thrL"}}
	,
	TestID->"GPRRelatedTests-20120326-O4I3X4"
]

Test[
	ecolicore["Genes"]
	,
	{gene["b0008"], gene["b0114"], gene["b0115"], gene["b0116"], gene["b0118"], gene["b0351"], gene["b0356"], gene["b0451"], gene["b0474"], gene["b0485"], gene["b0720"], gene["b0721"], gene["b0722"], gene["b0723"], gene["b0724"], gene["b0726"], gene["b0727"], gene["b0728"], gene["b0729"], gene["b0733"], gene["b0734"], gene["b0755"], gene["b0767"], gene["b0809"], gene["b0810"], gene["b0811"], gene["b0875"], gene["b0902"], gene["b0903"], gene["b0904"], gene["b0978"], gene["b0979"], gene["b1101"], gene["b1136"], gene["b1241"], gene["b1276"], gene["b1297"], gene["b1380"], gene["b1478"], gene["b1479"], gene["b1524"], gene["b1602"], gene["b1603"], gene["b1611"], gene["b1612"], gene["b1621"], gene["b1676"], gene["b1702"], gene["b1723"], gene["b1761"], gene["b1773"], gene["b1779"], gene["b1812"], gene["b1817"], gene["b1818"], gene["b1819"], gene["b1849"], gene["b1852"], gene["b1854"], gene["b2029"], gene["b2097"], gene["b2133"], gene["b2276"], gene["b2277"], gene["b2278"], gene["b2279"], gene["b2280"], gene["b2281"], gene["b2282"], gene["b2283"], gene["b2284"], gene["b2285"], gene["b2286"], gene["b2287"], gene["b2288"], gene["b2296"], gene["b2297"], gene["b2415"], gene["b2416"], gene["b2417"], gene["b2458"], gene["b2463"], gene["b2464"], gene["b2465"], gene["b2492"], gene["b2579"], gene["b2587"], gene["b2779"], gene["b2914"], gene["b2925"], gene["b2926"], gene["b2935"], gene["b2975"], gene["b2976"], gene["b2987"], gene["b3114"], gene["b3115"], gene["b3212"], gene["b3213"], gene["b3236"], gene["b3386"], gene["b3403"], gene["b3493"], gene["b3528"], gene["b3603"], gene["b3612"], gene["b3731"], gene["b3732"], gene["b3733"], gene["b3734"], gene["b3735"], gene["b3736"], gene["b3737"], gene["b3738"], gene["b3739"], gene["b3870"], gene["b3916"], gene["b3919"], gene["b3925"], gene["b3951"], gene["b3952"], gene["b3956"], gene["b3962"], gene["b4014"], gene["b4015"], gene["b4025"], gene["b4077"], gene["b4090"], gene["b4122"], gene["b4151"], gene["b4152"], gene["b4153"], gene["b4154"], gene["b4232"], gene["b4301"], gene["b4395"], gene["s0001"]}
	,
	TestID->"GPRRelatedTests-20120326-Z1H8X7"
]

Test[
	ecolicore["Proteins"]
	,
	{protein["AceA"], protein["AceB"], protein["AceEec"], protein["AceFec"], protein["AckA"], protein["AcnA"], protein["AcnB"], protein["AdhE"], protein["AdhP"], protein["Adk"], protein["AmtB"], protein["AqpZ"], protein["AtpF0"], protein["AtpF1"], protein["AtpI"], protein["B1773"], protein["CbdAB"], protein["Crr"], protein["CydA"], protein["DctA"], protein["Dld"], protein["Eno"], protein["EutD"], protein["FbaA"], protein["FbaB"], protein["Fbp"], protein["FocA"], protein["FocB"], protein["Frd"], protein["FrmA"], protein["FumA"], protein["FumB"], protein["FumCec"], protein["GapA"], protein["GdhA"], protein["GlcA"], protein["GlcB"], protein["GlnA"], protein["GlnHec"], protein["GlnPec"], protein["GlnQec"], protein["GlpX"], protein["GltA"], protein["GltB"], protein["GltP"], protein["Gnd"], protein["GpmA"], protein["GpmB"], protein["Icd"], protein["KgtPec"], protein["Ldh"], protein["LldP"], protein["LpdA"], protein["Mae"], protein["MalX"], protein["ManX"], protein["ManY"], protein["ManZ"], protein["Mdh"], protein["MhpF"], protein["Nuo"], protein["PabBec"], protein["Pck"], protein["PfkA"], protein["PfkB"], protein["PflBec"], protein["PflDec"], protein["Pgi"], protein["Pgk"], protein["Pgl"], protein["PitA"], protein["PitBec"], protein["Pnt"], protein["Ppc"], protein["Ppsa"], protein["Pta"], protein["PtsG"], protein["PtsH"], protein["PtsI"], protein["PurT"], protein["Pyka"], protein["Pykf"], protein["Rpeec"], protein["RpiA"], protein["RpiB"], protein["Sdh"], protein["Sfc"], protein["SgcE"], protein["SPONTANEOUS"], protein["SthA"], protein["SucAec"], protein["SucBec"], protein["SucCD"], protein["TalA"], protein["TalB"], protein["TdcD"], protein["TdcEec"], protein["TktA"], protein["TktB"], protein["Tpi"], protein["YbaS"], protein["YcjK"], protein["YfiD"], protein["YibO"], protein["YneH"], protein["Zwf"]}
	,
	TestID->"GPRRelatedTests-20120326-L3H9N8"
]

Test[
	ecolicore["GPR"]
	,
	{"ACALD" -> protein["MhpF"] || protein["AdhE"], "ACALDt" -> protein["SPONTANEOUS"], "ACKr" -> protein["AckA"] || protein["TdcD"] || protein["PurT"], "ACONTa" -> protein["AcnB"] || protein["AcnA"], "ACONTb" -> protein["AcnB"] || protein["AcnA"], "ADK1" -> protein["Adk"], "AKGDH" -> proteinComplex[protein["LpdA"], protein["SucAec"], protein["SucBec"]], "AKGt2r" -> protein["KgtPec"], "ALCD2x" -> protein["FrmA"] || protein["AdhP"] || protein["AdhE"], "ATPS4r" -> proteinComplex[protein["AtpF0"], protein["AtpF1"], protein["AtpI"]] || proteinComplex[protein["AtpF0"], protein["AtpF1"]], "CO2t" -> protein["SPONTANEOUS"], "CS" -> protein["GltA"], "CYTBD" -> protein["CbdAB"] || protein["CydA"], "D_LACt2" -> protein["GlcA"] || protein["LldP"], "ENO" -> protein["Eno"], "FBA" -> protein["FbaA"] || protein["FbaB"] || protein["B1773"], "FBP" -> protein["Fbp"] || protein["GlpX"], "FORt2" -> protein["FocA"] || protein["FocB"], "FORti" -> protein["FocA"] || protein["FocB"], "FRD7" -> protein["Frd"], "FRUpts2" -> proteinComplex[protein["ManX"], protein["ManY"], protein["ManZ"], protein["PtsH"], protein["PtsI"]], "FUM" -> protein["FumA"] || protein["FumB"] || protein["FumCec"], "FUMt2_2" -> protein["DctA"], "G6PDH2r" -> protein["Zwf"], "GAPD" -> protein["GapA"], "GLCpts" -> proteinComplex[protein["Crr"], protein["MalX"], protein["PtsH"], protein["PtsI"]] || proteinComplex[protein["Crr"], protein["PtsG"], protein["PtsH"], protein["PtsI"]] || proteinComplex[protein["ManX"], protein["ManY"], protein["ManZ"], protein["PtsH"], protein["PtsI"]], "GLNabc" -> proteinComplex[protein["GlnHec"], protein["GlnPec"], protein["GlnQec"]], "GLNS" -> protein["GlnA"] || protein["YcjK"], "GLUDy" -> protein["GdhA"], "GLUN" -> protein["PabBec"] || protein["YbaS"] || protein["YneH"], "GLUSy" -> protein["GltB"], "GLUt2r" -> protein["GltP"], "GND" -> protein["Gnd"], "H2Ot" -> protein["AqpZ"], "ICDHyr" -> protein["Icd"], "ICL" -> protein["AceA"], "LDH_D" -> protein["Ldh"] || protein["Dld"], "MALS" -> protein["GlcB"] || protein["AceB"], "MALt2_2" -> protein["DctA"], "MDH" -> protein["Mdh"], "ME1" -> protein["Sfc"], "ME2" -> protein["Mae"], "NADH16" -> protein["Nuo"], "NADTRHD" -> protein["Pnt"] || protein["SthA"], "NH4t" -> protein["AmtB"], "O2t" -> protein["SPONTANEOUS"], "PDH" -> proteinComplex[protein["AceEec"], protein["AceFec"], protein["LpdA"]], "PFK" -> protein["PfkA"] || protein["PfkB"], "PFL" -> proteinComplex[protein["PflBec"], protein["YfiD"]] || protein["PflBec"] || protein["TdcEec"] || protein["PflDec"], "PGI" -> protein["Pgi"], "PGK" -> protein["Pgk"], "PGL" -> protein["Pgl"], "PGM" -> protein["GpmB"] || protein["GpmA"] || protein["YibO"], "PIt2r" -> protein["PitBec"] || protein["PitA"], "PPC" -> protein["Ppc"], "PPCK" -> protein["Pck"], "PPS" -> protein["Ppsa"], "PTAr" -> protein["Pta"] || protein["EutD"], "PYK" -> protein["Pyka"] || protein["Pykf"], "RPE" -> protein["Rpeec"] || protein["SgcE"], "RPI" -> protein["RpiA"] || protein["RpiB"], "SUCCt2_2" -> protein["DctA"], "SUCDi" -> protein["Sdh"], "SUCOAS" -> protein["SucCD"], "TALA" -> protein["TalB"] || protein["TalA"], "THD2" -> protein["Pnt"], "TKT1" -> protein["TktA"] || protein["TktB"], "TKT2" -> protein["TktA"] || protein["TktB"], "TPI" -> protein["Tpi"], protein["AceA"] -> gene["b4015"], protein["AceB"] -> gene["b4014"], protein["AceEec"] -> gene["b0114"], protein["AceFec"] -> gene["b0115"], protein["AckA"] -> gene["b2296"], protein["AcnA"] -> gene["b1276"], protein["AcnB"] -> gene["b0118"], protein["AdhE"] -> gene["b1241"], protein["AdhP"] -> gene["b1478"], protein["Adk"] -> gene["b0474"], protein["AmtB"] -> gene["b0451"], protein["AqpZ"] -> gene["b0875"], protein["AtpF0"] -> geneComplex[gene["b3736"], gene["b3737"], gene["b3738"]], protein["AtpF1"] -> geneComplex[gene["b3731"], gene["b3732"], gene["b3733"], gene["b3734"], gene["b3735"]], protein["AtpI"] -> gene["b3739"], protein["B1773"] -> gene["b1773"], protein["CbdAB"] -> geneComplex[gene["b0978"], gene["b0979"]], protein["Crr"] -> gene["b2417"], protein["CydA"] -> geneComplex[gene["b0733"], gene["b0734"]], protein["DctA"] -> gene["b3528"], protein["Dld"] -> gene["b2133"], protein["Eno"] -> gene["b2779"], protein["EutD"] -> gene["b2458"], protein["FbaA"] -> gene["b2925"], protein["FbaB"] -> gene["b2097"], protein["Fbp"] -> gene["b4232"], protein["FocA"] -> gene["b0904"], protein["FocB"] -> gene["b2492"], protein["Frd"] -> geneComplex[gene["b4151"], gene["b4152"], gene["b4153"], gene["b4154"]], protein["FrmA"] -> gene["b0356"], protein["FumA"] -> gene["b1612"], protein["FumB"] -> gene["b4122"], protein["FumCec"] -> gene["b1611"], protein["GapA"] -> gene["b1779"], protein["GdhA"] -> gene["b1761"], protein["GlcA"] -> gene["b2975"], protein["GlcB"] -> gene["b2976"], protein["GlnA"] -> gene["b3870"], protein["GlnHec"] -> gene["b0811"], protein["GlnPec"] -> gene["b0810"], protein["GlnQec"] -> gene["b0809"], protein["GlpX"] -> gene["b3925"], protein["GltA"] -> gene["b0720"], protein["GltB"] -> geneComplex[gene["b3212"], gene["b3213"]], protein["GltP"] -> gene["b4077"], protein["Gnd"] -> gene["b2029"], protein["GpmA"] -> gene["b0755"], protein["GpmB"] -> gene["b4395"], protein["Icd"] -> gene["b1136"], protein["KgtPec"] -> gene["b2587"], protein["Ldh"] -> gene["b1380"], protein["LldP"] -> gene["b3603"], protein["LpdA"] -> gene["b0116"], protein["Mae"] -> gene["b2463"], protein["MalX"] -> gene["b1621"], protein["ManX"] -> gene["b1817"], protein["ManY"] -> gene["b1818"], protein["ManZ"] -> gene["b1819"], protein["Mdh"] -> gene["b3236"], protein["MhpF"] -> gene["b0351"], protein["Nuo"] -> geneComplex[gene["b2276"], gene["b2277"], gene["b2278"], gene["b2279"], gene["b2280"], gene["b2281"], gene["b2282"], gene["b2283"], gene["b2284"], gene["b2285"], gene["b2286"], gene["b2287"], gene["b2288"]], protein["PabBec"] -> gene["b1812"], protein["Pck"] -> gene["b3403"], protein["PfkA"] -> gene["b3916"], protein["PfkB"] -> gene["b1723"], protein["PflBec"] -> geneComplex[gene["b0902"], gene["b0903"]], protein["PflDec"] -> geneComplex[gene["b3951"], gene["b3952"]], protein["Pgi"] -> gene["b4025"], protein["Pgk"] -> gene["b2926"], protein["Pgl"] -> gene["b0767"], protein["PitA"] -> gene["b3493"], protein["PitBec"] -> gene["b2987"], protein["Pnt"] -> geneComplex[gene["b1602"], gene["b1603"]], protein["Ppc"] -> gene["b3956"], protein["Ppsa"] -> gene["b1702"], protein["Pta"] -> gene["b2297"], protein["PtsG"] -> gene["b1101"], protein["PtsH"] -> gene["b2415"], protein["PtsI"] -> gene["b2416"], protein["PurT"] -> gene["b1849"], protein["Pyka"] -> gene["b1854"], protein["Pykf"] -> gene["b1676"], protein["Rpeec"] -> gene["b3386"], protein["RpiA"] -> gene["b2914"], protein["RpiB"] -> gene["b4090"], protein["Sdh"] -> geneComplex[gene["b0721"], gene["b0722"], gene["b0723"], gene["b0724"]], protein["Sfc"] -> gene["b1479"], protein["SgcE"] -> gene["b4301"], protein["SPONTANEOUS"] -> gene["s0001"], protein["SthA"] -> gene["b3962"], protein["SucAec"] -> gene["b0726"], protein["SucBec"] -> gene["b0727"], protein["SucCD"] -> geneComplex[gene["b0728"], gene["b0729"]], protein["TalA"] -> gene["b2464"], protein["TalB"] -> gene["b0008"], protein["TdcD"] -> gene["b3115"], protein["TdcEec"] -> geneComplex[gene["b0902"], gene["b3114"]], protein["TktA"] -> gene["b2935"], protein["TktB"] -> gene["b2465"], protein["Tpi"] -> gene["b3919"], protein["YbaS"] -> gene["b0485"], protein["YcjK"] -> gene["b1297"], protein["YfiD"] -> gene["b2579"], protein["YibO"] -> gene["b3612"], protein["YneH"] -> gene["b1524"], protein["Zwf"] -> gene["b1852"]}
	,
	TestID->"GPRRelatedTests-20120326-B6V3F5"
]

(*Test[
	Sort[gpr2graphs[ecolicore]]
	,
	Sort@{{protein["MhpF"] -> "ACALD", protein["AdhE"] -> "ACALD", protein["FrmA"] -> "ALCD2x", protein["AdhP"] -> "ALCD2x", protein["AdhE"] -> "ALCD2x", gene["b1241"] -> protein["AdhE"], gene["b1478"] -> protein["AdhP"], gene["b0356"] -> protein["FrmA"], gene["b0351"] -> protein["MhpF"]}, {protein["SPONTANEOUS"] -> "ACALDt", protein["SPONTANEOUS"] -> "CO2t", protein["SPONTANEOUS"] -> "O2t", gene["s0001"] -> protein["SPONTANEOUS"]}, {protein["AckA"] -> "ACKr", protein["TdcD"] -> "ACKr", protein["PurT"] -> "ACKr", gene["b2296"] -> protein["AckA"], gene["b1849"] -> protein["PurT"], gene["b3115"] -> protein["TdcD"]}, {protein["AcnB"] -> "ACONTa", protein["AcnA"] -> "ACONTa", protein["AcnB"] -> "ACONTb", protein["AcnA"] -> "ACONTb", gene["b1276"] -> protein["AcnA"], gene["b0118"] -> protein["AcnB"]}, {protein["Adk"] -> "ADK1", gene["b0474"] -> protein["Adk"]}, {proteinComplex[protein["LpdA"], protein["SucAec"], protein["SucBec"]] -> "AKGDH", proteinComplex[protein["AceEec"], protein["AceFec"], protein["LpdA"]] -> "PDH", gene["b0114"] -> proteinComplex[protein["AceEec"], protein["AceFec"], protein["LpdA"]], gene["b0115"] -> proteinComplex[protein["AceEec"], protein["AceFec"], protein["LpdA"]], gene["b0116"] -> proteinComplex[protein["AceEec"], protein["AceFec"], protein["LpdA"]], gene["b0116"] -> proteinComplex[protein["LpdA"], protein["SucAec"], protein["SucBec"]], gene["b0726"] -> proteinComplex[protein["LpdA"], protein["SucAec"], protein["SucBec"]], gene["b0727"] -> proteinComplex[protein["LpdA"], protein["SucAec"], protein["SucBec"]]}, {protein["KgtPec"] -> "AKGt2r", gene["b2587"] -> protein["KgtPec"]}, {proteinComplex[protein["AtpF0"], protein["AtpF1"], protein["AtpI"]] -> "ATPS4r", proteinComplex[protein["AtpF0"], protein["AtpF1"]] -> "ATPS4r", geneComplex[gene["b3736"], gene["b3737"], gene["b3738"]] -> proteinComplex[protein["AtpF0"], protein["AtpF1"]], geneComplex[gene["b3731"], gene["b3732"], gene["b3733"], gene["b3734"], gene["b3735"]] -> proteinComplex[protein["AtpF0"], protein["AtpF1"]], geneComplex[gene["b3736"], gene["b3737"], gene["b3738"]] -> proteinComplex[protein["AtpF0"], protein["AtpF1"], protein["AtpI"]], geneComplex[gene["b3731"], gene["b3732"], gene["b3733"], gene["b3734"], gene["b3735"]] -> proteinComplex[protein["AtpF0"], protein["AtpF1"], protein["AtpI"]], gene["b3739"] -> proteinComplex[protein["AtpF0"], protein["AtpF1"], protein["AtpI"]]}, {protein["GltA"] -> "CS", gene["b0720"] -> protein["GltA"]}, {protein["CbdAB"] -> "CYTBD", protein["CydA"] -> "CYTBD", geneComplex[gene["b0978"], gene["b0979"]] -> protein["CbdAB"], geneComplex[gene["b0733"], gene["b0734"]] -> protein["CydA"]}, {protein["GlcA"] -> "D_LACt2", protein["LldP"] -> "D_LACt2", gene["b2975"] -> protein["GlcA"], gene["b3603"] -> protein["LldP"]}, {protein["Eno"] -> "ENO", gene["b2779"] -> protein["Eno"]}, {protein["FbaA"] -> "FBA", protein["FbaB"] -> "FBA", protein["B1773"] -> "FBA", gene["b1773"] -> protein["B1773"], gene["b2925"] -> protein["FbaA"], gene["b2097"] -> protein["FbaB"]}, {protein["Fbp"] -> "FBP", protein["GlpX"] -> "FBP", gene["b4232"] -> protein["Fbp"], gene["b3925"] -> protein["GlpX"]}, {protein["FocA"] -> "FORt2", protein["FocB"] -> "FORt2", protein["FocA"] -> "FORti", protein["FocB"] -> "FORti", gene["b0904"] -> protein["FocA"], gene["b2492"] -> protein["FocB"]}, {protein["Frd"] -> "FRD7", geneComplex[gene["b4151"], gene["b4152"], gene["b4153"], gene["b4154"]] -> protein["Frd"]}, {proteinComplex[protein["ManX"], protein["ManY"], protein["ManZ"], protein["PtsH"], protein["PtsI"]] -> "FRUpts2", proteinComplex[protein["Crr"], protein["MalX"], protein["PtsH"], protein["PtsI"]] -> "GLCpts", proteinComplex[protein["Crr"], protein["PtsG"], protein["PtsH"], protein["PtsI"]] -> "GLCpts", proteinComplex[protein["ManX"], protein["ManY"], protein["ManZ"], protein["PtsH"], protein["PtsI"]] -> "GLCpts", gene["b2417"] -> proteinComplex[protein["Crr"], protein["MalX"], protein["PtsH"], protein["PtsI"]], gene["b1621"] -> proteinComplex[protein["Crr"], protein["MalX"], protein["PtsH"], protein["PtsI"]], gene["b2415"] -> proteinComplex[protein["Crr"], protein["MalX"], protein["PtsH"], protein["PtsI"]], gene["b2416"] -> proteinComplex[protein["Crr"], protein["MalX"], protein["PtsH"], protein["PtsI"]], gene["b2417"] -> proteinComplex[protein["Crr"], protein["PtsG"], protein["PtsH"], protein["PtsI"]], gene["b1101"] -> proteinComplex[protein["Crr"], protein["PtsG"], protein["PtsH"], protein["PtsI"]], gene["b2415"] -> proteinComplex[protein["Crr"], protein["PtsG"], protein["PtsH"], protein["PtsI"]], gene["b2416"] -> proteinComplex[protein["Crr"], protein["PtsG"], protein["PtsH"], protein["PtsI"]], gene["b1817"] -> proteinComplex[protein["ManX"], protein["ManY"], protein["ManZ"], protein["PtsH"], protein["PtsI"]], gene["b1818"] -> proteinComplex[protein["ManX"], protein["ManY"], protein["ManZ"], protein["PtsH"], protein["PtsI"]], gene["b1819"] -> proteinComplex[protein["ManX"], protein["ManY"], protein["ManZ"], protein["PtsH"], protein["PtsI"]], gene["b2415"] -> proteinComplex[protein["ManX"], protein["ManY"], protein["ManZ"], protein["PtsH"], protein["PtsI"]], gene["b2416"] -> proteinComplex[protein["ManX"], protein["ManY"], protein["ManZ"], protein["PtsH"], protein["PtsI"]]}, {protein["FumA"] -> "FUM", protein["FumB"] -> "FUM", protein["FumCec"] -> "FUM", gene["b1612"] -> protein["FumA"], gene["b4122"] -> protein["FumB"], gene["b1611"] -> protein["FumCec"]}, {protein["DctA"] -> "FUMt2_2", protein["DctA"] -> "MALt2_2", protein["DctA"] -> "SUCCt2_2", gene["b3528"] -> protein["DctA"]}, {protein["Zwf"] -> "G6PDH2r", gene["b1852"] -> protein["Zwf"]}, {protein["GapA"] -> "GAPD", gene["b1779"] -> protein["GapA"]}, {proteinComplex[protein["GlnHec"], protein["GlnPec"], protein["GlnQec"]] -> "GLNabc", gene["b0811"] -> proteinComplex[protein["GlnHec"], protein["GlnPec"], protein["GlnQec"]], gene["b0810"] -> proteinComplex[protein["GlnHec"], protein["GlnPec"], protein["GlnQec"]], gene["b0809"] -> proteinComplex[protein["GlnHec"], protein["GlnPec"], protein["GlnQec"]]}, {protein["GlnA"] -> "GLNS", protein["YcjK"] -> "GLNS", gene["b3870"] -> protein["GlnA"], gene["b1297"] -> protein["YcjK"]}, {protein["GdhA"] -> "GLUDy", gene["b1761"] -> protein["GdhA"]}, {protein["PabBec"] -> "GLUN", protein["YbaS"] -> "GLUN", protein["YneH"] -> "GLUN", gene["b1812"] -> protein["PabBec"], gene["b0485"] -> protein["YbaS"], gene["b1524"] -> protein["YneH"]}, {protein["GltB"] -> "GLUSy", geneComplex[gene["b3212"], gene["b3213"]] -> protein["GltB"]}, {protein["GltP"] -> "GLUt2r", gene["b4077"] -> protein["GltP"]}, {protein["Gnd"] -> "GND", gene["b2029"] -> protein["Gnd"]}, {protein["AqpZ"] -> "H2Ot", gene["b0875"] -> protein["AqpZ"]}, {protein["Icd"] -> "ICDHyr", gene["b1136"] -> protein["Icd"]}, {protein["AceA"] -> "ICL", gene["b4015"] -> protein["AceA"]}, {protein["Ldh"] -> "LDH_D", protein["Dld"] -> "LDH_D", gene["b2133"] -> protein["Dld"], gene["b1380"] -> protein["Ldh"]}, {protein["GlcB"] -> "MALS", protein["AceB"] -> "MALS", gene["b4014"] -> protein["AceB"], gene["b2976"] -> protein["GlcB"]}, {protein["Mdh"] -> "MDH", gene["b3236"] -> protein["Mdh"]}, {protein["Sfc"] -> "ME1", gene["b1479"] -> protein["Sfc"]}, {protein["Mae"] -> "ME2", gene["b2463"] -> protein["Mae"]}, {protein["Nuo"] -> "NADH16", geneComplex[gene["b2276"], gene["b2277"], gene["b2278"], gene["b2279"], gene["b2280"], gene["b2281"], gene["b2282"], gene["b2283"], gene["b2284"], gene["b2285"], gene["b2286"], gene["b2287"], gene["b2288"]] -> protein["Nuo"]}, {protein["Pnt"] -> "NADTRHD", protein["SthA"] -> "NADTRHD", protein["Pnt"] -> "THD2", geneComplex[gene["b1602"], gene["b1603"]] -> protein["Pnt"], gene["b3962"] -> protein["SthA"]}, {protein["AmtB"] -> "NH4t", gene["b0451"] -> protein["AmtB"]}, {protein["PfkA"] -> "PFK", protein["PfkB"] -> "PFK", gene["b3916"] -> protein["PfkA"], gene["b1723"] -> protein["PfkB"]}, {proteinComplex[protein["PflBec"], protein["YfiD"]] -> "PFL", protein["PflBec"] -> "PFL", protein["TdcEec"] -> "PFL", protein["PflDec"] -> "PFL", geneComplex[gene["b0902"], gene["b0903"]] -> protein["PflBec"], geneComplex[gene["b3951"], gene["b3952"]] -> protein["PflDec"], geneComplex[gene["b0902"], gene["b3114"]] -> protein["TdcEec"], geneComplex[gene["b0902"], gene["b0903"]] -> proteinComplex[protein["PflBec"], protein["YfiD"]], gene["b2579"] -> proteinComplex[protein["PflBec"], protein["YfiD"]]}, {protein["Pgi"] -> "PGI", gene["b4025"] -> protein["Pgi"]}, {protein["Pgk"] -> "PGK", gene["b2926"] -> protein["Pgk"]}, {protein["Pgl"] -> "PGL", gene["b0767"] -> protein["Pgl"]}, {protein["GpmB"] -> "PGM", protein["GpmA"] -> "PGM", protein["YibO"] -> "PGM", gene["b0755"] -> protein["GpmA"], gene["b4395"] -> protein["GpmB"], gene["b3612"] -> protein["YibO"]}, {protein["PitBec"] -> "PIt2r", protein["PitA"] -> "PIt2r", gene["b3493"] -> protein["PitA"], gene["b2987"] -> protein["PitBec"]}, {protein["Ppc"] -> "PPC", gene["b3956"] -> protein["Ppc"]}, {protein["Pck"] -> "PPCK", gene["b3403"] -> protein["Pck"]}, {protein["Ppsa"] -> "PPS", gene["b1702"] -> protein["Ppsa"]}, {protein["Pta"] -> "PTAr", protein["EutD"] -> "PTAr", gene["b2458"] -> protein["EutD"], gene["b2297"] -> protein["Pta"]}, {protein["Pyka"] -> "PYK", protein["Pykf"] -> "PYK", gene["b1854"] -> protein["Pyka"], gene["b1676"] -> protein["Pykf"]}, {protein["Rpeec"] -> "RPE", protein["SgcE"] -> "RPE", gene["b3386"] -> protein["Rpeec"], gene["b4301"] -> protein["SgcE"]}, {protein["RpiA"] -> "RPI", protein["RpiB"] -> "RPI", gene["b2914"] -> protein["RpiA"], gene["b4090"] -> protein["RpiB"]}, {protein["Sdh"] -> "SUCDi", geneComplex[gene["b0721"], gene["b0722"], gene["b0723"], gene["b0724"]] -> protein["Sdh"]}, {protein["SucCD"] -> "SUCOAS", geneComplex[gene["b0728"], gene["b0729"]] -> protein["SucCD"]}, {protein["TalB"] -> "TALA", protein["TalA"] -> "TALA", gene["b2464"] -> protein["TalA"], gene["b0008"] -> protein["TalB"]}, {protein["TktA"] -> "TKT1", protein["TktB"] -> "TKT1", protein["TktA"] -> "TKT2", protein["TktB"] -> "TKT2", gene["b2935"] -> protein["TktA"], gene["b2465"] -> protein["TktB"]}, {protein["Tpi"] -> "TPI", gene["b3919"] -> protein["Tpi"]}}
	,
	TestID->"GPRRelatedTests-20120326-V3J1L4", EquivalenceFunction -> Equal
]
*)
Test[
	ecolicore["GeneAssociations"]
	,
	{"ACALD" -> gene["b0351"] || gene["b1241"], "ACALDt" -> gene["s0001"], "ACKr" -> gene["b2296"] || gene["b3115"] || gene["b1849"], "ACONTa" -> gene["b0118"] || gene["b1276"], "ACONTb" -> gene["b0118"] || gene["b1276"], "ADK1" -> gene["b0474"], "AKGDH" -> gene["b0116"] && gene["b0726"] && gene["b0727"], "AKGt2r" -> gene["b2587"], "ALCD2x" -> gene["b0356"] || gene["b1478"] || gene["b1241"], "ATPS4r" -> (gene["b3736"] && gene["b3737"] && gene["b3738"] && gene["b3731"] && gene["b3732"] && gene["b3733"] && gene["b3734"] && gene["b3735"] && gene["b3739"]) || (gene["b3736"] && gene["b3737"] && gene["b3738"] && gene["b3731"] && gene["b3732"] && gene["b3733"] && gene["b3734"] && gene["b3735"]), "CO2t" -> gene["s0001"], "CS" -> gene["b0720"], "CYTBD" -> (gene["b0978"] && gene["b0979"]) || (gene["b0733"] && gene["b0734"]), "D_LACt2" -> gene["b2975"] || gene["b3603"], "ENO" -> gene["b2779"], "FBA" -> gene["b2925"] || gene["b2097"] || gene["b1773"], "FBP" -> gene["b4232"] || gene["b3925"], "FORt2" -> gene["b0904"] || gene["b2492"], "FORti" -> gene["b0904"] || gene["b2492"], "FRD7" -> gene["b4151"] && gene["b4152"] && gene["b4153"] && gene["b4154"], "FRUpts2" -> gene["b1817"] && gene["b1818"] && gene["b1819"] && gene["b2415"] && gene["b2416"], "FUM" -> gene["b1612"] || gene["b4122"] || gene["b1611"], "FUMt2_2" -> gene["b3528"], "G6PDH2r" -> gene["b1852"], "GAPD" -> gene["b1779"], "GLCpts" -> (gene["b2417"] && gene["b1621"] && gene["b2415"] && gene["b2416"]) || (gene["b2417"] && gene["b1101"] && gene["b2415"] && gene["b2416"]) || (gene["b1817"] && gene["b1818"] && gene["b1819"] && gene["b2415"] && gene["b2416"]), "GLNabc" -> gene["b0811"] && gene["b0810"] && gene["b0809"], "GLNS" -> gene["b3870"] || gene["b1297"], "GLUDy" -> gene["b1761"], "GLUN" -> gene["b1812"] || gene["b0485"] || gene["b1524"], "GLUSy" -> gene["b3212"] && gene["b3213"], "GLUt2r" -> gene["b4077"], "GND" -> gene["b2029"], "H2Ot" -> gene["b0875"], "ICDHyr" -> gene["b1136"], "ICL" -> gene["b4015"], "LDH_D" -> gene["b1380"] || gene["b2133"], "MALS" -> gene["b2976"] || gene["b4014"], "MALt2_2" -> gene["b3528"], "MDH" -> gene["b3236"], "ME1" -> gene["b1479"], "ME2" -> gene["b2463"], "NADH16" -> gene["b2276"] && gene["b2277"] && gene["b2278"] && gene["b2279"] && gene["b2280"] && gene["b2281"] && gene["b2282"] && gene["b2283"] && gene["b2284"] && gene["b2285"] && gene["b2286"] && gene["b2287"] && gene["b2288"], "NADTRHD" -> (gene["b1602"] && gene["b1603"]) || gene["b3962"], "NH4t" -> gene["b0451"], "O2t" -> gene["s0001"], "PDH" -> gene["b0114"] && gene["b0115"] && gene["b0116"], "PFK" -> gene["b3916"] || gene["b1723"], "PFL" -> (gene["b0902"] && gene["b0903"] && gene["b2579"]) || (gene["b0902"] && gene["b0903"]) || (gene["b0902"] && gene["b3114"]) || (gene["b3951"] && gene["b3952"]), "PGI" -> gene["b4025"], "PGK" -> gene["b2926"], "PGL" -> gene["b0767"], "PGM" -> gene["b4395"] || gene["b0755"] || gene["b3612"], "PIt2r" -> gene["b2987"] || gene["b3493"], "PPC" -> gene["b3956"], "PPCK" -> gene["b3403"], "PPS" -> gene["b1702"], "PTAr" -> gene["b2297"] || gene["b2458"], "PYK" -> gene["b1854"] || gene["b1676"], "RPE" -> gene["b3386"] || gene["b4301"], "RPI" -> gene["b2914"] || gene["b4090"], "SUCCt2_2" -> gene["b3528"], "SUCDi" -> gene["b0721"] && gene["b0722"] && gene["b0723"] && gene["b0724"], "SUCOAS" -> gene["b0728"] && gene["b0729"], "TALA" -> gene["b0008"] || gene["b2464"], "THD2" -> gene["b1602"] && gene["b1603"], "TKT1" -> gene["b2935"] || gene["b2465"], "TKT2" -> gene["b2935"] || gene["b2465"], "TPI" -> gene["b3919"]}
	,
	TestID->"GPRRelatedTests-20120326-V2C8N1"
]

Test[
	ecolicore["ProteinAssociations"]
	,
	{"ACALD" -> protein["MhpF"] || protein["AdhE"], "ACALDt" -> protein["SPONTANEOUS"], "ACKr" -> protein["AckA"] || protein["TdcD"] || protein["PurT"], "ACONTa" -> protein["AcnB"] || protein["AcnA"], "ACONTb" -> protein["AcnB"] || protein["AcnA"], "ADK1" -> protein["Adk"], "AKGDH" -> protein["LpdA"] && protein["SucAec"] && protein["SucBec"], "AKGt2r" -> protein["KgtPec"], "ALCD2x" -> protein["FrmA"] || protein["AdhP"] || protein["AdhE"], "ATPS4r" -> (protein["AtpF0"] && protein["AtpF1"] && protein["AtpI"]) || (protein["AtpF0"] && protein["AtpF1"]), "CO2t" -> protein["SPONTANEOUS"], "CS" -> protein["GltA"], "CYTBD" -> protein["CbdAB"] || protein["CydA"], "D_LACt2" -> protein["GlcA"] || protein["LldP"], "ENO" -> protein["Eno"], "FBA" -> protein["FbaA"] || protein["FbaB"] || protein["B1773"], "FBP" -> protein["Fbp"] || protein["GlpX"], "FORt2" -> protein["FocA"] || protein["FocB"], "FORti" -> protein["FocA"] || protein["FocB"], "FRD7" -> protein["Frd"], "FRUpts2" -> protein["ManX"] && protein["ManY"] && protein["ManZ"] && protein["PtsH"] && protein["PtsI"], "FUM" -> protein["FumA"] || protein["FumB"] || protein["FumCec"], "FUMt2_2" -> protein["DctA"], "G6PDH2r" -> protein["Zwf"], "GAPD" -> protein["GapA"], "GLCpts" -> (protein["Crr"] && protein["MalX"] && protein["PtsH"] && protein["PtsI"]) || (protein["Crr"] && protein["PtsG"] && protein["PtsH"] && protein["PtsI"]) || (protein["ManX"] && protein["ManY"] && protein["ManZ"] && protein["PtsH"] && protein["PtsI"]), "GLNabc" -> protein["GlnHec"] && protein["GlnPec"] && protein["GlnQec"], "GLNS" -> protein["GlnA"] || protein["YcjK"], "GLUDy" -> protein["GdhA"], "GLUN" -> protein["PabBec"] || protein["YbaS"] || protein["YneH"], "GLUSy" -> protein["GltB"], "GLUt2r" -> protein["GltP"], "GND" -> protein["Gnd"], "H2Ot" -> protein["AqpZ"], "ICDHyr" -> protein["Icd"], "ICL" -> protein["AceA"], "LDH_D" -> protein["Ldh"] || protein["Dld"], "MALS" -> protein["GlcB"] || protein["AceB"], "MALt2_2" -> protein["DctA"], "MDH" -> protein["Mdh"], "ME1" -> protein["Sfc"], "ME2" -> protein["Mae"], "NADH16" -> protein["Nuo"], "NADTRHD" -> protein["Pnt"] || protein["SthA"], "NH4t" -> protein["AmtB"], "O2t" -> protein["SPONTANEOUS"], "PDH" -> protein["AceEec"] && protein["AceFec"] && protein["LpdA"], "PFK" -> protein["PfkA"] || protein["PfkB"], "PFL" -> (protein["PflBec"] && protein["YfiD"]) || protein["PflBec"] || protein["TdcEec"] || protein["PflDec"], "PGI" -> protein["Pgi"], "PGK" -> protein["Pgk"], "PGL" -> protein["Pgl"], "PGM" -> protein["GpmB"] || protein["GpmA"] || protein["YibO"], "PIt2r" -> protein["PitBec"] || protein["PitA"], "PPC" -> protein["Ppc"], "PPCK" -> protein["Pck"], "PPS" -> protein["Ppsa"], "PTAr" -> protein["Pta"] || protein["EutD"], "PYK" -> protein["Pyka"] || protein["Pykf"], "RPE" -> protein["Rpeec"] || protein["SgcE"], "RPI" -> protein["RpiA"] || protein["RpiB"], "SUCCt2_2" -> protein["DctA"], "SUCDi" -> protein["Sdh"], "SUCOAS" -> protein["SucCD"], "TALA" -> protein["TalB"] || protein["TalA"], "THD2" -> protein["Pnt"], "TKT1" -> protein["TktA"] || protein["TktB"], "TKT2" -> protein["TktA"] || protein["TktB"], "TPI" -> protein["Tpi"]}
	,
	TestID->"GPRRelatedTests-20120326-I8P6E1"
]

If[$VersionNumber > 7,
Test[
	(*KO of a gene that is not present in the model*)
	CheckAbort[deleteGene[ecolicore,gene["Fake"]],True]
	,
	True
	,
	deleteGenes::notexists
	,
	TestID->"GPRRelatedTests-20120326-O1X0U5"
]
]

If[$VersionNumber > 7,
Test[
	(*KO of a protein that is not present in the model*)
	CheckAbort[deleteProtein[ecolicore,protein["Fake"]],True]
	,
	True
	,
	deleteProteins::notexists
	,
	TestID->"GPRRelatedTests-20120326-D8U9Y3"
]
]

Test[
	(*KO of one of the PYK isozymes; No reactions should be affected; *)
	{Dimensions[#],Length[#["Genes"]],Length[#["Proteins"]]}&[deleteGene[ecolicore,gene["b1854"]]]
	,
	{Dimensions[ecolicore],Length[ecolicore["Genes"]]-1,Length[ecolicore["Proteins"]]-1}
	,
	TestID->"GPRRelatedTests-20120326-V0K6P2"
]

Test[
	(*KO of both of the PYK isozymes; 1 reaction should be affected; *)
	{Dimensions[#],Length[#["Genes"]],Length[#["Proteins"]]}&[deleteGenes[ecolicore,{gene["b1854"],gene["b1676"]}]]
	,
	{{74, 97},Length[ecolicore["Genes"]]-2,Length[ecolicore["Proteins"]]-2}
	,
	TestID->"GPRRelatedTests-20120326-O6W1W1"
]

Test[
	(*Protein KO of one of the PYK isozymes; No reactions should be affected*)
	{Dimensions[#],Length[#["Genes"]],Length[#["Proteins"]]}&[deleteProtein[ecolicore,protein["Pyka"]]]
	,
	{Dimensions[ecolicore],Length[ecolicore["Genes"]]-1,Length[ecolicore["Proteins"]]-1}
	,
	TestID->"GPRRelatedTests-20120326-X8N7M1"
]

Test[
	(*Protein KO of both of the PYK isozymes; 1 reaction should be affected; *)
	{Dimensions[#],Length[#["Genes"]],Length[#["Proteins"]]}&[deleteProteins[ecolicore,{protein["Pyka"],protein["Pykf"]}]]
	,
	{{74, 97},Length[ecolicore["Genes"]]-2,Length[ecolicore["Proteins"]]-2}
	,
	TestID->"GPRRelatedTests-20120326-U8J8R5"
]

Test[
	(*Deletion of AtpF0 and AtpF1; ATPS4r should be gone but AtpI and b3739 should be still in the model (not connect to any reaction though)*)
	{Length[#["Fluxes"]],Length[#["Genes"]],Length[#["Proteins"]],
		MemberQ[#["Genes"],gene["b3739"]],
		MemberQ[#["Proteins"],protein["AtpI"]],
		MemberQ[gpr2graphs[#],gene["b3739"],Infinity],
		MemberQ[gpr2graphs[#],protein["AtpI"],Infinity],
		Complement[ecolicore["Genes"],#["Genes"]],
		Complement[ecolicore["Proteins"],#["Proteins"]]}&[deleteProteins[ecolicore,{protein["AtpF0"], protein["AtpF1"]}]]
	,
	{97,Length[ecolicore["Genes"]]-8,Length[ecolicore["Proteins"]]-2, True,True,False,False,{gene["b3731"], gene["b3732"], gene["b3733"], gene["b3734"], gene["b3735"], gene["b3736"], gene["b3737"], gene["b3738"]}, {protein["AtpF0"], protein["AtpF1"]}}
	,
	TestID->"GPRRelatedTests-20120326-H7Z8L0"
]

Test[
	{Dimensions[#],Length[#["Genes"]],Length[#["Proteins"]],
		MemberQ[#["Proteins"],(protein["GlnHec"])],MemberQ[gpr2graphs[#],protein["GlnHec"],Infinity],
		MemberQ[#["Proteins"],(protein["GlnQec"])],MemberQ[gpr2graphs[#],protein["GlnQec"],Infinity],
		MemberQ[#["Proteins"],protein["GlnPec"]],MemberQ[gpr2graphs[#],protein["GlnPec"],Infinity]}&@deleteGene[ecolicore,gene["b0810"]]
	,
	{{74, 97}, Length[ecolicore["Genes"]]-1,Length[ecolicore["Proteins"]]-1,True,False,True,False,False,False}
	,
	TestID->"GPRRelatedTests-20120326-T4B6K0"
]


