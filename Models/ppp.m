(* ::Package:: *)

(* Created by Wolfram Mathematica 8.0 : www.wolfram.com *)
MASSmodel[{"ID" -> "ID", "Stoichiometry" -> 
   {{0, 0, 1, 0, 0, 0, 0, 0, 0, 0, -1}, {0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0}, {-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 1, 1, -1, 0, 0, 0}, {1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 2, -2, 0}, 
    {1, 1, 0, 0, 0, 0, 0, 0, -1, 2, 0}, {-1, 0, -1, 0, 0, 0, 0, 0, 1, 0, 0}, 
    {1, 0, 1, 0, 0, 0, 0, 0, -1, 0, 0}, {0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 0}, 
    {0, 0, 1, -1, -1, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0}, 
    {0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0}, 
    {0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0}}, 
  "Species" -> {metabolite["co2", "c"], metabolite["e4p", "c"], 
    metabolite["f6p", "c"], metabolite["g6p", "c"], metabolite["gap", "c"], 
    metabolite["gl6p", "c"], metabolite["go6p", "c"], metabolite["gsh", "c"], 
    metabolite["h", "c"], metabolite["nadp", "c"], metabolite["nadph", "c"], 
    metabolite["r5p", "c"], metabolite["ru5p", "c"], metabolite["s7p", "c"], 
    metabolite["x5p", "c"], metabolite["gssg", "c"], metabolite["h2o", "c"]}, 
  "Fluxes" -> {v["vg6pdh"],v["vpglase"],v["vgl6pdh"],v["vr5pe"],v["vr5pi"],v["vtki"],v["vtkii"],v["vtala"],v["vgssgr"],v["vgshr"],v["vco2"]}, "Constraints" -> {}, 
  "InitialConditions" -> {}, "Parameters" -> {}, "GPR" -> {}, 
  "ReversibleColumnIndices" -> {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}, 
  "CustomRateLaws" -> {}, "Name" -> "ID", "ElementalComposition" -> 
   {metabolite["co2", "c"] -> "C" + 2*"O", metabolite["e4p", "c"] -> 
     4*"C" + 7*"H" + 7*"O" + "P", metabolite["f6p", "c"] -> 
     6*"C" + 11*"H" + 9*"O" + "P", metabolite["g6p", "c"] -> 
     6*"C" + 11*"H" + 9*"O" + "P", metabolite["gap", "c"] -> 
     3*"C" + 5*"H" + 6*"O" + "P", metabolite["gl6p", "c"] -> 
     6*"C" + 9*"H" + 9*"O" + "P", metabolite["go6p", "c"] -> 
     6*"C" + 10*"H" + 10*"O" + "P", metabolite["gsh", "c"] -> 
     10*"C" + 17*"H" + 3*"N" + 6*"O" + "S", metabolite["gssg", "c"] -> 
     20*"C" + 32*"H" + 6*"N" + 12*"O" + 2*"S", metabolite["h", "c"] -> "H", 
    metabolite["h2o", "c"] -> 2*"H" + "O", metabolite["nadp", "c"] -> "NADP", 
    metabolite["nadph", "c"] -> "H" + "NADP", metabolite["r5p", "c"] -> 
     5*"C" + 9*"H" + 8*"O" + "P", metabolite["ru5p", "c"] -> 
     5*"C" + 9*"H" + 8*"O" + "P", metabolite["s7p", "c"] -> 
     7*"C" + 13*"H" + 10*"O" + "P", metabolite["x5p", "c"] -> 
     5*"C" + 9*"H" + 8*"O" + "P"}, "Notes" -> ""}]
