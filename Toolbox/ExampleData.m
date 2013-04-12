(* ::Package:: *)

(* ::Title:: *)
(*ExampleData*)


Unprotect[ExampleData];
ExampleData::notFound="`1` is not a known collection for ExampleData. Use ExampleData[] for a list of collections.";
ExampleData["Toolbox"]:={{"Toolbox","Glycolysis"},{"Toolbox", "PentosePhosphatePathway"},{"Toolbox", "EcoliCore"},{"Toolbox", "SBMLModel"}};
ExampleData[{"Toolbox", "Glycolysis"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","SB2","glycolysis.m.gz"}]];
ExampleData[{"Toolbox", "PentosePhosphatePathway"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","SB2","ppp.m.gz"}]];
ExampleData[{"Toolbox", "NucleotideSalvagePathway"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","SB2","salvage.m.gz"}]];
ExampleData[{"Toolbox", "Hemoglobin"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","SB2","Hemoglobin.m.gz"}]];
ExampleData[{"Toolbox", "EcoliCore"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","EcoliCore","EcoliCore.m.gz"}]];
ExampleData[{"Toolbox", "EcoliCoreMap"}] := importBIGGmap[FileNameJoin[{$ToolboxPath,"ExampleData","EcoliCore","EcoliCoreMap.svg"}]];
ExampleData[{"Toolbox", "SBMLModel"}] := Import[FileNameJoin[{$ToolboxPath,"ExampleData","SBML","BIOMD0000000172.xml"}],"XML"];
ExampleData[pat:{"Toolbox", _}]:=(Message[ExampleData::notFound,pat];Abort[];)
Protect[ExampleData];
