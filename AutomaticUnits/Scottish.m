
UnitSet["Scottish"]={
	DeclareUnit["ScottishEll",Unit[37,"Inch"],UsageMessage->"ScottishEll is an old Scottish unit of length.",TraditionalLabel->"Ell"],
	Unit["Foot"],Unit["Yard"],
	DeclareUnit["Fall",Unit[6,"ScottishEll"],UsageMessage->"Fall is an old Scottish unit of length."],
	DeclareUnit["ScottishMile",Unit[320,"Fall"],UsageMessage->"ScottishMile is an old Scottish unit of length.",TraditionalLabel->"mi"],
	Unit["Inch"]^2,Unit["ScottishEll"]^2,Unit["Fall"]^2,Unit["Rood"],Unit["Acre"],
	DeclareUnit["Oxgang",Unit[20,"Acre"],UsageMessage->"Oxgang is an old Scottish unit of length."],
	DeclareUnit["Ploughgate",Unit[8,"Oxgang"],UsageMessage->"Oxgang is an old Scottish unit of length."],
	DeclareUnit["Daugh",Unit[4,"Ploughgate"],UsageMessage->"Oxgang is an old Scottish unit of length."],

	DeclareUnit["ScottishPint",Unit[1.696 ,"Liter"],UsageMessage->"ScottishPint is an old Scottish unit of volume.",TraditionalLabel->"pt"],	
	DeclareUnit["Mutchkins",Unit[1/4 ,"ScottishPint"],UsageMessage->"Mutchkins is an old Scottish unit of volume."],	
	DeclareUnit["Chopin",Unit[1/2 ,"ScottishPint"],UsageMessage->"hopin is an old Scottish unit of volume."],	
	DeclareUnit["ScottishGallon",Unit[8 ,"ScottishPint"],UsageMessage->"ScottishGallon is an old Scottish unit of volume.",TraditionalLabel->"gal"],	
	
	Unit["Drop"],Unit["Ounce"],Unit["Pound"],Unit["Stone"]
	
};