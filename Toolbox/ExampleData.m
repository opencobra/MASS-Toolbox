(* ::Package:: *)

(* ::Title:: *)
(*ExampleData*)


Unprotect[ExampleData];
ExampleData::notFound="`1` is not a known collection for ExampleData. Use ExampleData[] for a list of collections.";
ExampleData[{"Toolbox", "Glycolysis"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","SB2","glycolysis.m.gz"}]];
ExampleData[{"Toolbox", "PentosePhosphatePathway"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","SB2","ppp.m.gz"}]];
ExampleData[{"Toolbox", "NucleotideSalvagePathway"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","SB2","salvage.m.gz"}]];
ExampleData[{"Toolbox", "Hemoglobin"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","SB2","Hemoglobin.m.gz"}]];
ExampleData[{"Toolbox", "PFK"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","SB2","pfk.m.gz"}]];
ExampleData[{"Toolbox", "G6PDH"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","SB2","G6PDH.m.gz"}]]
ExampleData[{"Toolbox", "PK"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","SB2","pk.m.gz"}]];
ExampleData[{"Toolbox", "RedBloodCellMap"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","SB2","SB2_map_complete.m"}]];
ExampleData[{"Toolbox", "EcoliCore"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","EcoliCore","EcoliCore.m.gz"}]];
ExampleData[{"Toolbox", "EcoliCoreMap"}] := importBIGGmap[FileNameJoin[{$ToolboxPath,"ExampleData","EcoliCore","EcoliCoreMap.svg"}]];
ExampleData[{"Toolbox", "SBMLModel"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","SBML","BIOMD0000000172.xml"}],"XML"];
ExampleData[{"Toolbox", "iAB-RBC-238"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","iAB-RBC-238","iAB-RBC-238.m.gz"}]];
ExampleData[{"Toolbox", "iAB-RBC-238-Glycolysis"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","iAB-RBC-238","iAB-RBC-238-Glycolysis.m.gz"}]];
ExampleData[{"Toolbox", "iAB-RBC-238-PentosePhosphatePathway"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","iAB-RBC-238","iAB-RBC-238-PentosePhosphatePathway.m.gz"}]];
ExampleData[{"Toolbox", "iAB-RBC-238-NucleotideSalvagePathway"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","iAB-RBC-238","iAB-RBC-238-NucleotideSalvagePathway.m.gz"}]];
ExampleData[{"Toolbox", "iAB-RBC-238-Hemoglobin"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","iAB-RBC-238","iAB-RBC-238-Hemoglobin.m.gz"}]];
ExampleData[{"Toolbox", "bigg2equilibrator"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","eQuilibrator","bigg2equilibrator.m.gz"}]];
ExampleData["Toolbox"]:=Cases[DownValues@ExampleData,{"Toolbox",_String},\[Infinity]];
ExampleData[pat:{"Toolbox", _}]:=(Message[ExampleData::notFound,pat];Abort[];)
Protect[ExampleData]
