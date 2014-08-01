(* Created by Wolfram Mathematica 9.0 : www.wolfram.com *)
{enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> {}, 
    "BoundActivators" -> {}, "BoundInhibitors" -> {}, 
    "CatalyticSites" -> Infinity, "ActivationSites" -> 0, 
    "InhibitionSites" -> 0}] -> 
  0 == 
   -((-(enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
            {Toolbox`Private`wrap[metabolite]["A", "c"]}, 
           "BoundActivators" -> {}, "BoundInhibitors" -> {}, 
           "CatalyticSites" -> Infinity, "ActivationSites" -> 0, 
           "InhibitionSites" -> 0}]/Keq["E1"]) + 
       enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> {}, 
          "BoundActivators" -> {}, "BoundInhibitors" -> {}, 
          "CatalyticSites" -> Infinity, "ActivationSites" -> 0, 
          "InhibitionSites" -> 0}]*metabolite["A", "c"])*
      parameter["Volume", "c"]*rateconst["E1", True]) + 
    (enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
         {Toolbox`Private`wrap[metabolite]["Q", "c"]}, "BoundActivators" -> 
         {}, "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
        "ActivationSites" -> 0, "InhibitionSites" -> 0}] - 
      (enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> {}, 
          "BoundActivators" -> {}, "BoundInhibitors" -> {}, 
          "CatalyticSites" -> Infinity, "ActivationSites" -> 0, 
          "InhibitionSites" -> 0}]*metabolite["Q", "c"])/Keq["E2"])*
     parameter["Volume", "c"]*rateconst["E2", True], 
 enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
     {Toolbox`Private`wrap[metabolite]["A", "c"]}, "BoundActivators" -> {}, 
    "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
    "ActivationSites" -> 0, "InhibitionSites" -> 0}] -> 
  0 == (-(enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
           {Toolbox`Private`wrap[metabolite]["A", "c"]}, "BoundActivators" -> 
           {}, "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
          "ActivationSites" -> 0, "InhibitionSites" -> 0}]/Keq["E1"]) + 
      enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> {}, 
         "BoundActivators" -> {}, "BoundInhibitors" -> {}, 
         "CatalyticSites" -> Infinity, "ActivationSites" -> 0, 
         "InhibitionSites" -> 0}]*metabolite["A", "c"])*
     parameter["Volume", "c"]*rateconst["E1", True] - 
    (-(enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
           {Toolbox`Private`wrap[metabolite]["A", "c"], 
            Toolbox`Private`wrap[metabolite]["B", "c"]}, "BoundActivators" -> 
           {}, "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
          "ActivationSites" -> 0, "InhibitionSites" -> 0}]/Keq["E3"]) + 
      enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
          {Toolbox`Private`wrap[metabolite]["A", "c"]}, "BoundActivators" -> 
          {}, "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
         "ActivationSites" -> 0, "InhibitionSites" -> 0}]*
       metabolite["B", "c"])*parameter["Volume", "c"]*rateconst["E3", True], 
 enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
     {Toolbox`Private`wrap[metabolite]["Q", "c"]}, "BoundActivators" -> {}, 
    "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
    "ActivationSites" -> 0, "InhibitionSites" -> 0}] -> 
  0 == -((enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
          {Toolbox`Private`wrap[metabolite]["Q", "c"]}, "BoundActivators" -> 
          {}, "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
         "ActivationSites" -> 0, "InhibitionSites" -> 0}] - 
       (enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> {}, 
           "BoundActivators" -> {}, "BoundInhibitors" -> {}, 
           "CatalyticSites" -> Infinity, "ActivationSites" -> 0, 
           "InhibitionSites" -> 0}]*metabolite["Q", "c"])/Keq["E2"])*
      parameter["Volume", "c"]*rateconst["E2", True]) + 
    (enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
         {Toolbox`Private`wrap[metabolite]["Q", "c"], 
          Toolbox`Private`wrap[metabolite]["P", "c"]}, "BoundActivators" -> 
         {}, "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
        "ActivationSites" -> 0, "InhibitionSites" -> 0}] - 
      (enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
           {Toolbox`Private`wrap[metabolite]["Q", "c"]}, "BoundActivators" -> 
           {}, "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
          "ActivationSites" -> 0, "InhibitionSites" -> 0}]*
        metabolite["P", "c"])/Keq["E4"])*parameter["Volume", "c"]*
     rateconst["E4", True], 
 enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
     {Toolbox`Private`wrap[metabolite]["A", "c"], 
      Toolbox`Private`wrap[metabolite]["B", "c"]}, "BoundActivators" -> {}, 
    "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
    "ActivationSites" -> 0, "InhibitionSites" -> 0}] -> 
  0 == (-(enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
           {Toolbox`Private`wrap[metabolite]["A", "c"], 
            Toolbox`Private`wrap[metabolite]["B", "c"]}, "BoundActivators" -> 
           {}, "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
          "ActivationSites" -> 0, "InhibitionSites" -> 0}]/Keq["E3"]) + 
      enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
          {Toolbox`Private`wrap[metabolite]["A", "c"]}, "BoundActivators" -> 
          {}, "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
         "ActivationSites" -> 0, "InhibitionSites" -> 0}]*
       metabolite["B", "c"])*parameter["Volume", "c"]*rateconst["E3", True] - 
    (enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
         {Toolbox`Private`wrap[metabolite]["A", "c"], 
          Toolbox`Private`wrap[metabolite]["B", "c"]}, "BoundActivators" -> 
         {}, "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
        "ActivationSites" -> 0, "InhibitionSites" -> 0}] - 
      enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
          {Toolbox`Private`wrap[metabolite]["Q", "c"], 
           Toolbox`Private`wrap[metabolite]["P", "c"]}, "BoundActivators" -> 
          {}, "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
         "ActivationSites" -> 0, "InhibitionSites" -> 0}]/Keq["E5"])*
     parameter["Volume", "c"]*rateconst["E5", True], 
 enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
     {Toolbox`Private`wrap[metabolite]["Q", "c"], 
      Toolbox`Private`wrap[metabolite]["P", "c"]}, "BoundActivators" -> {}, 
    "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
    "ActivationSites" -> 0, "InhibitionSites" -> 0}] -> 
  0 == -((enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
          {Toolbox`Private`wrap[metabolite]["Q", "c"], 
           Toolbox`Private`wrap[metabolite]["P", "c"]}, "BoundActivators" -> 
          {}, "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
         "ActivationSites" -> 0, "InhibitionSites" -> 0}] - 
       (enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
            {Toolbox`Private`wrap[metabolite]["Q", "c"]}, 
           "BoundActivators" -> {}, "BoundInhibitors" -> {}, 
           "CatalyticSites" -> Infinity, "ActivationSites" -> 0, 
           "InhibitionSites" -> 0}]*metabolite["P", "c"])/Keq["E4"])*
      parameter["Volume", "c"]*rateconst["E4", True]) + 
    (enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
         {Toolbox`Private`wrap[metabolite]["A", "c"], 
          Toolbox`Private`wrap[metabolite]["B", "c"]}, "BoundActivators" -> 
         {}, "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
        "ActivationSites" -> 0, "InhibitionSites" -> 0}] - 
      enzyme[{"ID" -> "E", "Compartment" -> "c", "BoundCatalytic" -> 
          {Toolbox`Private`wrap[metabolite]["Q", "c"], 
           Toolbox`Private`wrap[metabolite]["P", "c"]}, "BoundActivators" -> 
          {}, "BoundInhibitors" -> {}, "CatalyticSites" -> Infinity, 
         "ActivationSites" -> 0, "InhibitionSites" -> 0}]/Keq["E5"])*
     parameter["Volume", "c"]*rateconst["E5", True]}
