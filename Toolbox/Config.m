(* ::Package:: *)

(* ::Title:: *)
(*Config*)


(* Exported symbols added here with SymbolName::usage *) 

$SystemCommandPrefix::usage = "Put this in front of your system command call, e.g., Import[\"!\" <> $SystemCommandPrefix <> \"shellCommand --option 1 ...\", \"Text\"]"

$ToolboxPath=FileNameJoin[FileNameSplit[DirectoryName[FindFile["Toolbox`"]]][[;;-2]]];

$ToolboxVersion="1.1.5";

Begin["`Private`"]

$ShellProfiles = {
    "$HOME/.bashrc",
    "$HOME/.bash_profile"
}

If[StringMatchQ[$System, RegularExpression[".*Microsoft.*"]],
    $SystemCommandPrefix = "";,
    $SystemCommandPrefix = StringJoin[Sequence@@Riffle["source " <> #<>" > /dev/null" & /@ $ShellProfiles, ";"]] <> ";";
];
End[]
