(* Mathematica Test File *)

SetDirectory[FileNameJoin[FileNameSplit[DirectoryName[FindFile["Toolbox`"]]][[;; -3]]]];

modelsFromMatlab=mat2model["Tests/TestData/110831-forNiko.mat"]

(*Test[
	modelsFromMatlab
	,
	result
	,
	TestID->"IOrelatedTests-20120704-U9R1U9"
]*)
