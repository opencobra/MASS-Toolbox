(* Created by Wolfram Mathematica 8.0 : www.wolfram.com *)
MASSmodel[{"ID" -> "ID", "Stoichiometry" -> {{0, 0, 1, 0, 0, 0, 0, 0}, 
    {-1, 1, -1, 0, 0, 0, 0, 0}, {0, 1, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 1, 0}, {0, 0, 0, -1, -1, -1, -1, -1}, 
    {0, -1, 0, 0, 0, 0, 0, 0}, {1, 0, 0, 0, 0, 0, 0, 0}, 
    {1, 0, 0, 0, 0, 0, 0, 0}, {-1, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, -1, -1, 0, 0, 0, 0}, {0, 0, 0, 1, -1, 0, 0, 0}, 
    {0, 0, 0, 0, 1, -1, 0, 0}, {0, 0, 0, 0, 0, 1, -1, 0}}, 
  "Species" -> {metabolite["dhb", "c"], metabolite["dpg23", "c"], 
    metabolite["h", "c"], metabolite["hbo24", "c"], metabolite["o2", "c"], 
    metabolite["pg13", "c"], metabolite["pg3", "c"], metabolite["phos", "c"], 
    metabolite["h2o", "c"], metabolite["hb", "c"], metabolite["hbo2", "c"], 
    metabolite["hbo22", "c"], metabolite["hbo23", "c"]}, 
  "Fluxes" -> {"vdpgase", "vdpgm", "vhbdpg", "vhbo1", "vhbo2", "vhbo3", 
    "vhbo4", "vo2"}, "Constraints" -> {}, "InitialConditions" -> {}, 
  "Parameters" -> {}, "GPR" -> {}, "ReversibleColumnIndices" -> 
   {1, 2, 3, 4, 5, 6, 7, 8}, "CustomRateLaws" -> {}, "Name" -> "ID", 
  "ElementalComposition" -> {metabolite["dhb", "c"] -> 
     3*"C" + 3*"H" + "Hb" + 10*"O" + 2*"P", metabolite["dpg23", "c"] -> 
     3*"C" + 3*"H" + 10*"O" + 2*"P", metabolite["h", "c"] -> "H", 
    metabolite["h2o", "c"] -> 2*"H" + "O", metabolite["hb", "c"] -> "Hb", 
    metabolite["hbo2", "c"] -> "Hb" + 2*"O", metabolite["hbo22", "c"] -> 
     "Hb" + 4*"O", metabolite["hbo23", "c"] -> "Hb" + 6*"O", 
    metabolite["hbo24", "c"] -> "Hb" + 8*"O", metabolite["o2", "c"] -> 2*"O", 
    metabolite["pg13", "c"] -> 3*"C" + 4*"H" + 10*"O" + 2*"P", 
    metabolite["pg3", "c"] -> 3*"C" + 4*"H" + 7*"O" + "P", 
    metabolite["phos", "c"] -> "H" + 4*"O" + "P"}, "Notes" -> ""}]
