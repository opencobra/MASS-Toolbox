(* Mathematica Test File *)

Needs["Toolbox`"]

SetDirectory[FileNameJoin[FileNameSplit[DirectoryName[FindFile["Toolbox`"]]][[;; -3]]]];

referenceFluxesPlusBounds = 
  getReferenceFluxesAndBoundsFromXML["Models/Ec_core_flux1.xml.gz"];
referenceBounds = #[[1]] -> #[[2, 1 ;; 2]] & /@ 
   referenceFluxesPlusBounds;
referenceFluxes = #[[1]] -> #[[2, -1]] & /@ 
   referenceFluxesPlusBounds;
referenceBounds = 
  referenceBounds /. {-999999. -> -100000, 999999. -> 100000};
(*ecolicore=Import["../Models/EcoliCoreLikeDanielPlusGPR.m"];*)

ecolicore = 
  sbml2model["Models/Ec_core_flux1.xml.gz", "Method" -> "Light"];
updateConstraints[ecolicore, referenceBounds];

lpSol = fba[ecolicore, "R_Biomass_Ecoli_core_N__w_GAM_"] // Chop;
gurobiSol = fba[ecolicore, "R_Biomass_Ecoli_core_N__w_GAM_", Solver -> GurobiSolve, Loopless -> True] // Chop;

Print[lpSol];
Print[gurobiSol];

Test[
    !MemberQ[Chop[Abs[Subtract@@@Thread[{lpSol[[All,2]],lpSol[[All,1]]/.gurobiSol}]]],num_/;num>1*^-6]
    ,
    True
    ,
    TestID->"CobraRelatedTests-20120326-X3P9F2"
]
Print["he2"]
Test[
    !MemberQ[Chop[Abs[Subtract@@@Thread[{referenceFluxes[[All,2]],referenceFluxes[[All,1]]/.gurobiSol}]]],num_/;num>1*^-6]
    ,
    True
    ,
    TestID->"CobraRelatedTests-20120326-X4A8B2"
]

Test[
    !MemberQ[Chop[Abs[Subtract@@@Thread[{referenceFluxes[[All,2]],referenceFluxes[[All,1]]/.lpSol}]]],num_/;num>1*^-6]
    ,
    True
    ,
    TestID->"CobraRelatedTests-20120326-S5D4G3"
]

fva1 = Chop@fva[ecolicore, Solver -> LinearProgramming, "ProgressBar" -> False];
fva2 = Chop@fva[ecolicore, Solver -> GurobiSolve, "ProgressBar" -> False];
fva3 = Chop@GurobiFVA[ecolicore];

Test[
    ! MemberQ[Abs[fva1[[All, 2, 1]] - fva2[[All, 2, 1]]], num_ /; num > 1*^-6]
    ,
    True
    ,
    TestID->"CobraRelatedTests-20120326-V7X5D6"
]

Test[
    ! MemberQ[Abs[fva1[[All, 2, 2]] - fva2[[All, 2, 2]]], num_ /; num > 1*^-6]
    ,
    True
    ,
    TestID->"CobraRelatedTests-20120326-Y2V8X7"
]

Test[
    ! MemberQ[Abs[fva1[[All, 2, 1]] - fva3[[All, 2, 1]]], num_ /; num > 1*^-6]
    ,
    True
    ,
    TestID->"CobraRelatedTests-20120410-K8E1Q2"
]

Test[
    ! MemberQ[Abs[fva1[[All, 2, 2]] - fva3[[All, 2, 2]]], num_ /; num > 1*^-6]
    ,
    True
    ,
    TestID->"CobraRelatedTests-20120410-R2C9V4"
]

ecolicore=Import["Models/EcoliCoreLikeDanielPlusGPR.m"]

testProblems = {"prob1" -> {"def" -> {{1, 1}, {{1, 2}}, {3}}, 
     "sol" -> {0, 3/2}},
   "prob2" -> {"def" -> {{1, 1}, {{1, 2}}, {{3, 0}}}, 
     "sol" -> {0, 3/2}},
   "prob3" -> {"def" -> {{1, 1}, {{1, 2}}, {{3, -1}}}, 
     "sol" -> {0, 0}},
   "prob4" -> {"def" -> {{1, 1}, {{1, 2}}, {3}, {-1, -1}}, 
     "sol" -> {-1, 2}},
   "prob5" -> {"def" -> {{1, 1}, {{1, 2}}, {3}, {{-1, 2}, {-1, 1}}}, 
     "sol" -> {1, 1}},
   "prob6" -> {"def" -> {{2, -3}, {{-1, -2}}, {{3, -1}}, {{-Infinity, 
         1}, {-Infinity, 1}}}, "sol" -> {-5, 1}},
   "prob7" -> {"def" -> {{1., 1.}, {{5., 2.}}, {3.}}, 
     "sol" -> {0.6`, 0.`}},
   "prob8" -> {"def" -> {{1., 1.}, {{5., 2.}}, {3.}, Automatic, 
       Integers}, "sol" -> {1, 0}},
   "prob9" -> {"def" -> {{1., 1.}, {{5., 2.}}, {3.}, 
       Automatic, {Integers, Reals}}, "sol" -> {1, 0.`}},
   "prob10" -> {"def" -> {{1, 2}, {{3, 4}}, {5}}, "sol" -> {5/3, 0}}
   };

Test[
	#[[1]]->LinearProgramming[Sequence@@("def"/.#[[2]])]==("sol"/.#[[2]])&/@testProblems
	,
	{"prob1" -> True, "prob2" -> True, "prob3" -> True, "prob4" -> True, "prob5" -> True, "prob6" -> True, "prob7" -> True, "prob8" -> True, "prob9" -> True, "prob10" -> True}
	,
	TestID->"CobraRelatedTests-20120410-L5E5B7"
]

(*
Test[
    #[[1]]->GLPKStandalone[Sequence@@("def"/.#[[2]])]==("sol"/.#[[2]])&/@testProblems
    ,
    {"prob1" -> True, "prob2" -> True, "prob3" -> True, "prob4" -> True, "prob5" -> True, "prob6" -> True, "prob7" -> True, "prob8" -> True, "prob9" -> True, "prob10" -> True}
    ,
    TestID->"CobraRelatedTests-20120410-L9M7F9"
]

Test[
    #[[1]]->CPLEXStandalone[Sequence@@("def"/.#[[2]])]==("sol"/.#[[2]])&/@testProblems
    ,
    {"prob1" -> True, "prob2" -> True, "prob3" -> True, "prob4" -> True, "prob5" -> True, "prob6" -> True, "prob7" -> True, "prob8" -> True, "prob9" -> True, "prob10" -> True}
    ,
    TestID->"CobraRelatedTests-20120410-J8N8S4"
]
*)