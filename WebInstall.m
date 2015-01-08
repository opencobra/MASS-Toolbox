(* ::Package:: *)

(* ::Subsection:: *)
(*Update code*)


Needs["JLink`"];
Needs["Utilities`URLTools`"];
InstallJava[];


httpGet[url_String]:=
	JavaBlock@Module[{http,get},
		http=JavaNew["org.apache.commons.httpclient.HttpClient"];
		get=JavaNew["org.apache.commons.httpclient.methods.GetMethod",url];
		http@executeMethod[get];
		get@addRequestHeader["content-type","application/json"];
		get@getResponseBodyAsString[]
	];


latestRelease[]:=
	Module[{code,tags},
		code = httpGet["https://api.github.com/repos/opencobra/MASS-Toolbox/releases"];
		tags = StringTake[Select[StringSplit[code,","],StringMatchQ[#,"\"tag_name"~~___]&],14;;-2];
		First[tags]
	];


Clear[Global`progress];
Module[{version,directory,fileName,url,progFunction,task1,task2,newDirectory,installNotebook,nb},
	(* Find latest version *)
	version = latestRelease[];

	(* Download tar file *)
	directory = $TemporaryDirectory;
	fileName=directory<>"/MASS-Toolbox-"<>version<>".tar.gz";
	Print["Please wait. Downloading Toolbox v"<>version<>"..."];
	url="https://github.com/opencobra/MASS-Toolbox/archive/v"<>version<>".tar.gz";
	Global`progress= 0.;
	progFunction[_, "progress", {dlnow_, dltotal_, _, _}]:= Quiet[Global`progress = dlnow/dltotal];
	task1=URLSaveAsynchronous[url, fileName, progFunction, "Progress"->True];
	Monitor[WaitAsynchronousTask[task1],Dynamic[If[NumberQ[Global`progress],ProgressIndicator[Global`progress],""]]];
	Print["Download Complete!"];

	(* Extract files *)
	Print["Please wait. Extracting Files..."];
	task2=ExtractArchive[fileName,directory];
	WaitAsynchronousTask[task2];

	(* Install new Toolbox *)
	Print["Installing Toolbox..."];
	newDirectory=FileNameJoin[{directory,"MASS-Toolbox-"<>version}];
	installNotebook=FileNameJoin[{newDirectory,"Installer.nb"}];
	nb=NotebookOpen[installNotebook,Visible->False];
	SelectionMove[nb,Next,Cell,3];
	SelectionEvaluate[nb];
	Pause[2];
	NotebookClose[nb];
	Print["The MASS Toolbox was successfully installed! To load the Toolbox, quit the kernel and run \"<<Toolbox`\""];
];



