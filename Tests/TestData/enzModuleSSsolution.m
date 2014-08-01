(* Created by Wolfram Mathematica 9.0 : www.wolfram.com *)
{enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> {}, 
    "BoundActivators" -> {}, "BoundInhibitors" -> {}, 
    "CatalyticSites" -> Infinity, "ActivationSites" -> 0, 
    "InhibitionSites" -> 0}] -> (Keq["E2"]*parameter["E_total"]*
    (Keq["E4"]*Keq["E5"]*rateconst["E1", True]*rateconst["E2", True]*
      rateconst["E3", True]*rateconst["E4", True] + 
     Keq["E4"]*rateconst["E1", True]*rateconst["E2", True]*
      rateconst["E3", True]*rateconst["E5", True] + 
     Keq["E3"]*Keq["E4"]*Keq["E5"]*rateconst["E1", True]*
      rateconst["E2", True]*rateconst["E4", True]*rateconst["E5", True] + 
     metabolite["P", "c"]*rateconst["E1", True]*rateconst["E3", True]*
      rateconst["E4", True]*rateconst["E5", True] + 
     Keq["E1"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["B", "c"]*
      rateconst["E2", True]*rateconst["E3", True]*rateconst["E4", True]*
      rateconst["E5", True]))/(Keq["E2"]*Keq["E4"]*Keq["E5"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True] + Keq["E1"]*Keq["E2"]*Keq["E4"]*Keq["E5"]*
     metabolite["A", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E4", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["A", "c"]*
     metabolite["B", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E4", True] + 
    Keq["E4"]*Keq["E5"]*metabolite["Q", "c"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E3", True]*rateconst["E4", True] + 
    Keq["E5"]*metabolite["P", "c"]*metabolite["Q", "c"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E3", True]*rateconst["E4", True] + 
    Keq["E2"]*Keq["E4"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E4"]*metabolite["A", "c"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*metabolite["A", "c"]*
     metabolite["B", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["A", "c"]*
     metabolite["B", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E4"]*metabolite["Q", "c"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["A", "c"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E3"]*Keq["E4"]*Keq["E5"]*
     metabolite["Q", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E3"]*metabolite["P", "c"]*metabolite["Q", "c"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E3"]*Keq["E5"]*metabolite["P", "c"]*metabolite["Q", "c"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*
     Keq["E5"]*metabolite["A", "c"]*metabolite["B", "c"]*
     rateconst["E1", True]*rateconst["E3", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E2"]*metabolite["P", "c"]*
     rateconst["E1", True]*rateconst["E3", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E1"]*Keq["E2"]*metabolite["A", "c"]*
     metabolite["P", "c"]*rateconst["E1", True]*rateconst["E3", True]*
     rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*metabolite["A", "c"]*metabolite["B", "c"]*
     metabolite["P", "c"]*rateconst["E1", True]*rateconst["E3", True]*
     rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E5"]*metabolite["A", "c"]*
     metabolite["B", "c"]*metabolite["P", "c"]*rateconst["E1", True]*
     rateconst["E3", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["B", "c"]*
     rateconst["E2", True]*rateconst["E3", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E1"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*
     metabolite["B", "c"]*metabolite["Q", "c"]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*metabolite["P", "c"]*metabolite["Q", "c"]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E3"]*metabolite["B", "c"]*metabolite["P", "c"]*
     metabolite["Q", "c"]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E3"]*Keq["E5"]*metabolite["B", "c"]*metabolite["P", "c"]*
     metabolite["Q", "c"]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True]*rateconst["E5", True]), 
 enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
     {Toolbox`Private`wrap[metabolite]["A", "c"]}, "BoundActivators" -> {}, 
    "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
    "ActivationSites" -> 0, "InhibitionSites" -> 0}] -> 
  (Keq["E1"]*parameter["E_total"]*(Keq["E2"]*Keq["E4"]*Keq["E5"]*
      metabolite["A", "c"]*rateconst["E1", True]*rateconst["E2", True]*
      rateconst["E3", True]*rateconst["E4", True] + 
     Keq["E2"]*Keq["E4"]*metabolite["A", "c"]*rateconst["E1", True]*
      rateconst["E2", True]*rateconst["E3", True]*rateconst["E5", True] + 
     Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["A", "c"]*
      rateconst["E1", True]*rateconst["E2", True]*rateconst["E4", True]*
      rateconst["E5", True] + Keq["E2"]*metabolite["A", "c"]*
      metabolite["P", "c"]*rateconst["E1", True]*rateconst["E3", True]*
      rateconst["E4", True]*rateconst["E5", True] + 
     metabolite["P", "c"]*metabolite["Q", "c"]*rateconst["E2", True]*
      rateconst["E3", True]*rateconst["E4", True]*rateconst["E5", True]))/
   (Keq["E2"]*Keq["E4"]*Keq["E5"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E4", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E4"]*Keq["E5"]*metabolite["A", "c"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True] + Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*
     Keq["E5"]*metabolite["A", "c"]*metabolite["B", "c"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True] + Keq["E4"]*Keq["E5"]*metabolite["Q", "c"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True] + Keq["E5"]*metabolite["P", "c"]*
     metabolite["Q", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E4", True] + 
    Keq["E2"]*Keq["E4"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E4"]*metabolite["A", "c"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*metabolite["A", "c"]*
     metabolite["B", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["A", "c"]*
     metabolite["B", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E4"]*metabolite["Q", "c"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["A", "c"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E3"]*Keq["E4"]*Keq["E5"]*
     metabolite["Q", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E3"]*metabolite["P", "c"]*metabolite["Q", "c"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E3"]*Keq["E5"]*metabolite["P", "c"]*metabolite["Q", "c"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*
     Keq["E5"]*metabolite["A", "c"]*metabolite["B", "c"]*
     rateconst["E1", True]*rateconst["E3", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E2"]*metabolite["P", "c"]*
     rateconst["E1", True]*rateconst["E3", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E1"]*Keq["E2"]*metabolite["A", "c"]*
     metabolite["P", "c"]*rateconst["E1", True]*rateconst["E3", True]*
     rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*metabolite["A", "c"]*metabolite["B", "c"]*
     metabolite["P", "c"]*rateconst["E1", True]*rateconst["E3", True]*
     rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E5"]*metabolite["A", "c"]*
     metabolite["B", "c"]*metabolite["P", "c"]*rateconst["E1", True]*
     rateconst["E3", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["B", "c"]*
     rateconst["E2", True]*rateconst["E3", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E1"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*
     metabolite["B", "c"]*metabolite["Q", "c"]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*metabolite["P", "c"]*metabolite["Q", "c"]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E3"]*metabolite["B", "c"]*metabolite["P", "c"]*
     metabolite["Q", "c"]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E3"]*Keq["E5"]*metabolite["B", "c"]*metabolite["P", "c"]*
     metabolite["Q", "c"]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True]*rateconst["E5", True]), 
 enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
     {Toolbox`Private`wrap[metabolite]["Q", "c"]}, "BoundActivators" -> {}, 
    "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
    "ActivationSites" -> 0, "InhibitionSites" -> 0}] -> 
  (parameter["E_total"]*(Keq["E4"]*Keq["E5"]*metabolite["Q", "c"]*
      rateconst["E1", True]*rateconst["E2", True]*rateconst["E3", True]*
      rateconst["E4", True] + Keq["E4"]*metabolite["Q", "c"]*
      rateconst["E1", True]*rateconst["E2", True]*rateconst["E3", True]*
      rateconst["E5", True] + Keq["E3"]*Keq["E4"]*Keq["E5"]*
      metabolite["Q", "c"]*rateconst["E1", True]*rateconst["E2", True]*
      rateconst["E4", True]*rateconst["E5", True] + 
     Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["A", "c"]*
      metabolite["B", "c"]*rateconst["E1", True]*rateconst["E3", True]*
      rateconst["E4", True]*rateconst["E5", True] + 
     Keq["E1"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["B", "c"]*
      metabolite["Q", "c"]*rateconst["E2", True]*rateconst["E3", True]*
      rateconst["E4", True]*rateconst["E5", True]))/
   (Keq["E2"]*Keq["E4"]*Keq["E5"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E4", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E4"]*Keq["E5"]*metabolite["A", "c"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True] + Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*
     Keq["E5"]*metabolite["A", "c"]*metabolite["B", "c"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True] + Keq["E4"]*Keq["E5"]*metabolite["Q", "c"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True] + Keq["E5"]*metabolite["P", "c"]*
     metabolite["Q", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E4", True] + 
    Keq["E2"]*Keq["E4"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E4"]*metabolite["A", "c"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*metabolite["A", "c"]*
     metabolite["B", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["A", "c"]*
     metabolite["B", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E4"]*metabolite["Q", "c"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["A", "c"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E3"]*Keq["E4"]*Keq["E5"]*
     metabolite["Q", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E3"]*metabolite["P", "c"]*metabolite["Q", "c"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E3"]*Keq["E5"]*metabolite["P", "c"]*metabolite["Q", "c"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*
     Keq["E5"]*metabolite["A", "c"]*metabolite["B", "c"]*
     rateconst["E1", True]*rateconst["E3", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E2"]*metabolite["P", "c"]*
     rateconst["E1", True]*rateconst["E3", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E1"]*Keq["E2"]*metabolite["A", "c"]*
     metabolite["P", "c"]*rateconst["E1", True]*rateconst["E3", True]*
     rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*metabolite["A", "c"]*metabolite["B", "c"]*
     metabolite["P", "c"]*rateconst["E1", True]*rateconst["E3", True]*
     rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E5"]*metabolite["A", "c"]*
     metabolite["B", "c"]*metabolite["P", "c"]*rateconst["E1", True]*
     rateconst["E3", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["B", "c"]*
     rateconst["E2", True]*rateconst["E3", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E1"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*
     metabolite["B", "c"]*metabolite["Q", "c"]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*metabolite["P", "c"]*metabolite["Q", "c"]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E3"]*metabolite["B", "c"]*metabolite["P", "c"]*
     metabolite["Q", "c"]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E3"]*Keq["E5"]*metabolite["B", "c"]*metabolite["P", "c"]*
     metabolite["Q", "c"]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True]*rateconst["E5", True]), 
 enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
     {Toolbox`Private`wrap[metabolite]["A", "c"], 
      Toolbox`Private`wrap[metabolite]["B", "c"]}, "BoundActivators" -> {}, 
    "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
    "ActivationSites" -> 0, "InhibitionSites" -> 0}] -> 
  (Keq["E3"]*parameter["E_total"]*(Keq["E1"]*Keq["E2"]*Keq["E4"]*Keq["E5"]*
      metabolite["A", "c"]*metabolite["B", "c"]*rateconst["E1", True]*
      rateconst["E2", True]*rateconst["E3", True]*rateconst["E4", True] + 
     Keq["E1"]*Keq["E2"]*Keq["E4"]*metabolite["A", "c"]*metabolite["B", "c"]*
      rateconst["E1", True]*rateconst["E2", True]*rateconst["E3", True]*
      rateconst["E5", True] + metabolite["P", "c"]*metabolite["Q", "c"]*
      rateconst["E1", True]*rateconst["E2", True]*rateconst["E4", True]*
      rateconst["E5", True] + Keq["E1"]*Keq["E2"]*metabolite["A", "c"]*
      metabolite["B", "c"]*metabolite["P", "c"]*rateconst["E1", True]*
      rateconst["E3", True]*rateconst["E4", True]*rateconst["E5", True] + 
     Keq["E1"]*metabolite["B", "c"]*metabolite["P", "c"]*metabolite["Q", "c"]*
      rateconst["E2", True]*rateconst["E3", True]*rateconst["E4", True]*
      rateconst["E5", True]))/(Keq["E2"]*Keq["E4"]*Keq["E5"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True] + Keq["E1"]*Keq["E2"]*Keq["E4"]*Keq["E5"]*
     metabolite["A", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E4", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["A", "c"]*
     metabolite["B", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E4", True] + 
    Keq["E4"]*Keq["E5"]*metabolite["Q", "c"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E3", True]*rateconst["E4", True] + 
    Keq["E5"]*metabolite["P", "c"]*metabolite["Q", "c"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E3", True]*rateconst["E4", True] + 
    Keq["E2"]*Keq["E4"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E4"]*metabolite["A", "c"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*metabolite["A", "c"]*
     metabolite["B", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["A", "c"]*
     metabolite["B", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E4"]*metabolite["Q", "c"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["A", "c"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E3"]*Keq["E4"]*Keq["E5"]*
     metabolite["Q", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E3"]*metabolite["P", "c"]*metabolite["Q", "c"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E3"]*Keq["E5"]*metabolite["P", "c"]*metabolite["Q", "c"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*
     Keq["E5"]*metabolite["A", "c"]*metabolite["B", "c"]*
     rateconst["E1", True]*rateconst["E3", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E2"]*metabolite["P", "c"]*
     rateconst["E1", True]*rateconst["E3", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E1"]*Keq["E2"]*metabolite["A", "c"]*
     metabolite["P", "c"]*rateconst["E1", True]*rateconst["E3", True]*
     rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*metabolite["A", "c"]*metabolite["B", "c"]*
     metabolite["P", "c"]*rateconst["E1", True]*rateconst["E3", True]*
     rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E5"]*metabolite["A", "c"]*
     metabolite["B", "c"]*metabolite["P", "c"]*rateconst["E1", True]*
     rateconst["E3", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["B", "c"]*
     rateconst["E2", True]*rateconst["E3", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E1"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*
     metabolite["B", "c"]*metabolite["Q", "c"]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*metabolite["P", "c"]*metabolite["Q", "c"]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E3"]*metabolite["B", "c"]*metabolite["P", "c"]*
     metabolite["Q", "c"]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E3"]*Keq["E5"]*metabolite["B", "c"]*metabolite["P", "c"]*
     metabolite["Q", "c"]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True]*rateconst["E5", True]), 
 enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
     {Toolbox`Private`wrap[metabolite]["Q", "c"], 
      Toolbox`Private`wrap[metabolite]["P", "c"]}, "BoundActivators" -> {}, 
    "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
    "ActivationSites" -> 0, "InhibitionSites" -> 0}] -> 
  (parameter["E_total"]*(Keq["E5"]*metabolite["P", "c"]*metabolite["Q", "c"]*
      rateconst["E1", True]*rateconst["E2", True]*rateconst["E3", True]*
      rateconst["E4", True] + Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*
      Keq["E5"]*metabolite["A", "c"]*metabolite["B", "c"]*
      rateconst["E1", True]*rateconst["E2", True]*rateconst["E3", True]*
      rateconst["E5", True] + Keq["E3"]*Keq["E5"]*metabolite["P", "c"]*
      metabolite["Q", "c"]*rateconst["E1", True]*rateconst["E2", True]*
      rateconst["E4", True]*rateconst["E5", True] + 
     Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E5"]*metabolite["A", "c"]*
      metabolite["B", "c"]*metabolite["P", "c"]*rateconst["E1", True]*
      rateconst["E3", True]*rateconst["E4", True]*rateconst["E5", True] + 
     Keq["E1"]*Keq["E3"]*Keq["E5"]*metabolite["B", "c"]*metabolite["P", "c"]*
      metabolite["Q", "c"]*rateconst["E2", True]*rateconst["E3", True]*
      rateconst["E4", True]*rateconst["E5", True]))/
   (Keq["E2"]*Keq["E4"]*Keq["E5"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E4", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E4"]*Keq["E5"]*metabolite["A", "c"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True] + Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*
     Keq["E5"]*metabolite["A", "c"]*metabolite["B", "c"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True] + Keq["E4"]*Keq["E5"]*metabolite["Q", "c"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True] + Keq["E5"]*metabolite["P", "c"]*
     metabolite["Q", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E4", True] + 
    Keq["E2"]*Keq["E4"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E4"]*metabolite["A", "c"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*metabolite["A", "c"]*
     metabolite["B", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["A", "c"]*
     metabolite["B", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E4"]*metabolite["Q", "c"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E3", True]*rateconst["E5", True] + 
    Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["A", "c"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E3"]*Keq["E4"]*Keq["E5"]*
     metabolite["Q", "c"]*rateconst["E1", True]*rateconst["E2", True]*
     rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E3"]*metabolite["P", "c"]*metabolite["Q", "c"]*rateconst["E1", True]*
     rateconst["E2", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E3"]*Keq["E5"]*metabolite["P", "c"]*metabolite["Q", "c"]*
     rateconst["E1", True]*rateconst["E2", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*
     Keq["E5"]*metabolite["A", "c"]*metabolite["B", "c"]*
     rateconst["E1", True]*rateconst["E3", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E2"]*metabolite["P", "c"]*
     rateconst["E1", True]*rateconst["E3", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E1"]*Keq["E2"]*metabolite["A", "c"]*
     metabolite["P", "c"]*rateconst["E1", True]*rateconst["E3", True]*
     rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*metabolite["A", "c"]*metabolite["B", "c"]*
     metabolite["P", "c"]*rateconst["E1", True]*rateconst["E3", True]*
     rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E5"]*metabolite["A", "c"]*
     metabolite["B", "c"]*metabolite["P", "c"]*rateconst["E1", True]*
     rateconst["E3", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E2"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*metabolite["B", "c"]*
     rateconst["E2", True]*rateconst["E3", True]*rateconst["E4", True]*
     rateconst["E5", True] + Keq["E1"]*Keq["E3"]*Keq["E4"]*Keq["E5"]*
     metabolite["B", "c"]*metabolite["Q", "c"]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*metabolite["P", "c"]*metabolite["Q", "c"]*rateconst["E2", True]*
     rateconst["E3", True]*rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E3"]*metabolite["B", "c"]*metabolite["P", "c"]*
     metabolite["Q", "c"]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True]*rateconst["E5", True] + 
    Keq["E1"]*Keq["E3"]*Keq["E5"]*metabolite["B", "c"]*metabolite["P", "c"]*
     metabolite["Q", "c"]*rateconst["E2", True]*rateconst["E3", True]*
     rateconst["E4", True]*rateconst["E5", True])}
