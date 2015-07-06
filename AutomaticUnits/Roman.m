UnitSet["Roman"]={
  (*Length*)
  DeclareUnit["RomanDigit", Unit[1/16, "RomanFoot"],  UsageMessage -> "RomanDigit is a historical Roman unit of length."],
  DeclareUnit["RomanInch", Unit[1/12, "RomanFoot"],  UsageMessage -> "RomanInch is a historical Roman unit of length."],
  DeclareUnit["RomanPalm", Unit[1/4, "RomanFoot"],  UsageMessage -> "RomanPalm is a historical Roman unit of length." ],
  DeclareUnit["RomanFoot", Unit[889/30, "Centimeter"],  UsageMessage -> "RomanFoot is a historical Roman unit of length." ],
  DeclareUnit["RomanCubit", Unit[3/2, "RomanFoot"],  UsageMessage -> "RomanCubit is a historical Roman unit of length." ],
  DeclareUnit["RomanStep", Unit[5/2, "RomanFoot"],  UsageMessage -> "RomanStep is a historical Roman unit of length." ],
  DeclareUnit["RomanPace", Unit[5, "RomanFoot"],  UsageMessage -> "RomanPace is a historical Roman unit of length." ],
  DeclareUnit["RomanPerch", Unit[10, "RomanFoot"],  UsageMessage -> "RomanPerch is a historical Roman unit of length." ],
  DeclareUnit["RomanArpent", Unit[120, "RomanFoot"],  UsageMessage ->   "RomanArpent is a historical Roman unit of length." ],
  DeclareUnit["RomanStadium", Unit[625, "RomanFoot"],  UsageMessage ->   "RomanStadium is a historical Roman unit of length." ],
  DeclareUnit["RomanMile", Unit[5000, "RomanFoot"],  UsageMessage -> "RomanMile is a historical Roman unit of length." ],
  DeclareUnit["RomanLeague", Unit[7500, "RomanFoot"],  UsageMessage ->   "RomanLeague is a historical Roman unit of length."],
  
  (*Area*)
  DeclareUnit["RomanAuneOfFurrows", Unit[7500, "RomanAcre"],  UsageMessage ->   "RomanAuneOfFurrows is a historical Roman unit of area." ],
  DeclareUnit["RomanRood", Unit[7500, "RomanAcre"],  UsageMessage -> "RomanRood is a historical Roman unit of area." ],
  DeclareUnit["RomanAcre", Unit[1, "RomanArpent"]^2,  UsageMessage -> "RomanAcre is a historical Roman unit of area." ],
  DeclareUnit["RomanYoke", Unit[7500, "RomanAcre"],  UsageMessage -> "RomanYoke is a historical Roman unit of area." ],
  DeclareUnit["RomanMorn", Unit[7500, "RomanAcre"],  UsageMessage -> "RomanMorn is a historical Roman unit of area." ],
  DeclareUnit["RomanCenturie", Unit[7500, "RomanAcre"],  UsageMessage ->   "RomanCenturie is a historical Roman unit of area." ],
    DeclareUnit["RomanQuadriplex", Unit[7500, "RomanAcre"],  UsageMessage ->   "RomanQuadriplex is a historical Roman unit of area." ],
  
  (*Volume*)
  DeclareUnit["RomanSpoonful", Unit[1/48, "RomanSester"],  UsageMessage ->  "RomanSpoonful is a historical Roman unit of volume." ],
  DeclareUnit["RomanDose", Unit[1/12, "RomanSester"],  UsageMessage -> "RomanDose is a historical Roman unit of volume." ],
  DeclareUnit["RomanSixthSester", Unit[1/6, "RomanSester"],  UsageMessage ->   "RomanSixthSester is a historical Roman unit of volume." ],
  DeclareUnit["RomanThirdSester", Unit[1/3, "RomanSester"],  UsageMessage ->   "RomanThirdSester is a historical Roman unit of volume." ],
  DeclareUnit["RomanHalfSester", Unit[1/2, "RomanSester"],  UsageMessage ->   "RomanHalfSester is a historical Roman unit of volume." ],
  DeclareUnit["RomanDoubleThirdSester", Unit[2/3, "RomanSester"],  UsageMessage ->   "RomanDoubleThirdSester is a historical Roman unit of volume." ],
  DeclareUnit["RomanSester", ( Unit[1/2, "RomanFoot"]^3)/6,  UsageMessage ->   "RomanSester is a historical Roman unit of volume." ],
  DeclareUnit["RomanCongius", Unit[6, "RomanSester"],   UsageMessage ->   "RomanCongius is a historical Roman unit of volume." ],
  DeclareUnit["RomanUrn", Unit[24, "RomanSester"],  UsageMessage -> "RomanUrn is a historical Roman unit of volume." ],
  DeclareUnit["RomanJar", Unit[48, "RomanSester"],  UsageMessage -> "RomanJar is a historical Roman unit of volume." ],
  DeclareUnit["RomanHose", Unit[960, "RomanSester"],  UsageMessage -> "RomanHose is a historical Roman unit of volume." ],
  
  (*Dry Measure*)
  DeclareUnit["RomanDrawingSpoon", Unit[1/128, "RomanPeck"],   UsageMessage ->   "RomanDrawingSpoon is a historical Roman unit of dry measure." ],
  DeclareUnit["RomanQuarterSpoon", Unit[1/64, "RomanPeck"],  UsageMessage ->   "RomanQuarterSpoon is a historical Roman unit of dry measure." ],
  DeclareUnit["RomanDryHalfSester", Unit[1/32, "RomanPeck"],  UsageMessage ->  "RomanHalfSester is a historical Roman unit of dry measure." ],
  DeclareUnit["RomanDrySester", Unit[1/16, "RomanPeck"],  UsageMessage ->   "RomanSester is a historical Roman unit of dry measure." ],
  DeclareUnit["RomanGallon", Unit[1/2, "RomanPeck"],  UsageMessage ->   "RomanGallon is a historical Roman unit of dry measure." ],
  DeclareUnit["RomanPeck", ( Unit[1, "RomanFoot"]^3)/3,  UsageMessage ->   "RomanPeck is a historical Roman unit of dry measure." ],
  DeclareUnit["RomanBushel", Unit[3, "RomanPeck"],  UsageMessage ->   "RomanBushel is a historical Roman unit of dry measure." ],
  
  (*Mass*)
  DeclareUnit["RomanChalcus", Unit[1/48, "RomanDram"],  UsageMessage ->   "RomanChalcus is a historical Roman unit of mass and coinage." ],
  DeclareUnit["RomanSiliqua", Unit[1/18, "RomanDram"],  UsageMessage ->   "RomanSiliqua is a historical Roman unit of mass and coinage." ],
  DeclareUnit["RomanObolus", Unit[1/6, "RomanDram"],   UsageMessage ->    "RomanObolus is a historical Roman unit of mass and coinage." ],
  DeclareUnit["RomanScruple", Unit[1/3, "RomanDram"],   UsageMessage ->   "RomanScruple is a historical Roman unit of mass and coinage." ],
  DeclareUnit["RomanDram", Unit[3.408, "Gram"],   UsageMessage ->   "RomanDram is a historical Roman unit of mass and coinage." ],
  DeclareUnit["RomanShekel", Unit[2, "RomanDram"],  UsageMessage ->   "RomanShekel is a historical Roman unit of mass and coinage." ],
  DeclareUnit["RomanOunce", Unit[8, "RomanDram"],  UsageMessage ->  "RomanOunce is a historical Roman unit of mass and coinage." ],
  DeclareUnit["RomanPound", Unit[96, "RomanDram"],  UsageMessage ->  "RomanPound is a historical Roman unit of mass and coinage." ],
  DeclareUnit["RomanMine", Unit[128, "RomanDram"],  UsageMessage ->   "RomanMine is a historical Roman unit of mass and coinage." ]
  };