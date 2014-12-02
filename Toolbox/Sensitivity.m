(* ::Package:: *)

(* ::Title:: *)
(*Sensitivity*)


(* ::Section:: *)
(*Definitions*)


Begin["`Private`"]


calculatePartialVariances[data_List,frequ_List,order_:4]:=Module[{fourierT,pwerspec},
fourierT=#[[2;;Ceiling[Length[#]/2]]]&@Fourier[data,FourierParameters->{-1,1}];
pwerspec=Abs[fourierT]^2;
Table[2*Sum[pwerspec[[harmonic*f]],{harmonic,1,order}],{f,frequ}]/(2*Sum[pwerspec[[f]],{f,1,Max[frequ]*order}])
];


calcLinIndependentFreq::dim="Sorry, so far we're only able to provide frequency sets up to dimension 50 (they have been determined empirically; see Cukier et al. 1975).";
calcLinIndependentFreq[numParameters_]:=Module[{tmpD,d,\[CapitalOmega]},
If[numParameters>50,Message[calcLinIndependentFreq::dim];Abort[]];
tmpD={4,8,6,10,20,22,32,40,38,26,56,62,46,76,96,60,86,126,134,112,92,128,154,196,34,416,106,208,328,198,382,88,348,186,140,170,284,568,302,438,410,248,448,388,596,216,100,488,166};
Do[d[n]=tmpD[[n]],{n,1,Length[tmpD]}];
\[CapitalOmega]={Indeterminate,Indeterminate,1,5,11,1,17,23,19,25,41,31,23,87,67,73,85,143,149,99,119,237,267,283,151,385,157,215,449,163,337,253,375,441,673,773,875,873,587,849,623,637,891,943,1171,1225,1335,1725,1663,2019};
RecurrenceTable[{\[Omega][t]==\[Omega][t-1]+d[numParameters+1-t],\[Omega][1]==\[CapitalOmega][[numParameters]]},\[Omega],{t,1,numParameters}]
];


Options[FASTsimul]={"Frequencies"->Automatic,"SearchFunction"->(#1 Exp[4.39*Sin[#2*#3]]&),"SampleNum"->Automatic,"Partitioning"->"Saltelli99","ProgressBar"->True};
FASTsimul::freq="Provided frequencies `1` do not match the pattern of a list of integers `2`.";
FASTsimul::samplenum="Provided sample number `1` do not match the pattern of a integer `2`.";
FASTsimul::unreconPartitioningMethod="Partitioning method `1` not recognized.";
FASTsimul[func_Function,parametersOfInterest:{_Rule..},opts:OptionsPattern[]]:=Module[{j,sampleNum,resampleNum,freq,sdivisions,oscillatingParameters,output,searchFunction,progressBarQ},
	searchFunction=OptionValue["SearchFunction"];
	Switch[OptionValue["Frequencies"],
		Automatic,freq=calcLinIndependentFreq[Length[parametersOfInterest]],
		{_Integer..},freq=OptionValue["Frequencies"],
		_,Message[FASTsimul::freq,OptionValue["Frequencies"],{_Integer..}];Abort[];
	];
	Switch[OptionValue["SampleNum"],
		Automatic,sampleNum=2*4*Max[freq]+1,
		_Integer,sampleNum=OptionValue["SampleNum"],
		_,Message[FASTsimul::samplenum,OptionValue["SampleNum"],_Integer];Abort[];
	];
	Switch[OptionValue["Partitioning"],
		"Saltelli99",sdivisions=NestList[(2Pi/(sampleNum-1))+#1&,-Pi,(sampleNum-1)],
		"Cukier73",sdivisions=N@(2Pi*#/sampleNum)&/@Range[1,sampleNum],(*Wrong? definition in Cukier 1973*)
		_,Message[FASTsimul::unreconPartitioningMethod,OptionValue["Partitioning"]];Abort[];
	];
	j=0;SetSharedVariable[j];
	progressBarQ=If[$FrontEnd=!=Null,OptionValue["ProgressBar"],False];
	output=If[progressBarQ,Monitor[ReleaseHold[#],ProgressIndicator[j,{1,Length[sdivisions]}]],ReleaseHold[#]]&@
			Hold@ParallelTable[
				j++;
				oscillatingParameters=Thread[Rule[parametersOfInterest[[All,1]],Thread[searchFunction[parametersOfInterest[[All,2]],freq,s,0.]]]];
				func@oscillatingParameters
				,{s,sdivisions},DistributedContexts->{"Toolbox`","Toolbox`Private`","Global`","AutomaticUnits`"}];
	{output,Thread[Rule[parametersOfInterest[[All,1]],freq]],sdivisions}
];


computeFourierSineAmplitude[data_List,frequ_,sdivisions_List]:=Block[{n},
n=Length[sdivisions];
(2/n)*Sum[data[[q]]*Sin[frequ*sdivisions[[q]]],{q,1,n}]
];


FASTcalcSensitivities[timeSeries_List,paramFreqDict_List,sdivisions_List]:=Module[{},
	#[[1]]->computeFourierSineAmplitude[timeSeries,#[[2]],sdivisions]&/@paramFreqDict
];


(* ::Subsection::Closed:: *)
(*End*)


End[]
