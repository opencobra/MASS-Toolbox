UnitSet["Astronomical"]={
	(*Distance*)
	DeclareUnit["LightYear", Unit[9460730472580800,"Meter"], UsageMessage->"LightYear is a unit of length.",TraditionalLabel -> "ly"], 
	DeclareUnit["Parsec", Unit[30857000000000000, "Meter"], UsageMessage->"Parsec is a unit of length.",TraditionalLabel -> "pc"],
	DeclareUnit["AstronomicalUnit", Unit[1.49597870691*^11, "Meter"], UsageMessage->"AstronomicalUnit is a unit of length.",TraditionalLabel -> "AU"],
	DeclareUnit["AU", Unit[1, "AstronomicalUnit"], UsageMessage->"AU is a unit of length.",TraditionalLabel -> "AU"], 
	DeclareUnit["LunarDistance", Unit[384403000, "Meter"], UsageMessage->"LunarDistance is a unit of length."], 
	DeclareUnit["EarthRadius", Unit[6371000, "Meter"], UsageMessage->"EarthRadius is a unit of length.",TraditionalLabel -> SubscriptBox["R","\[CirclePlus]"]], 
	(*Mass*)
	DeclareUnit["SolarMass", Unit[1.998922*^33,"Gram"], UsageMessage->"SolarMass is a unit of mass."], (*http://en.wikipedia.org/wiki/Solar_Mass*)
	DeclareUnit["EarthMass", Unit[5.9742*10^24, "Kilogram"], UsageMessage->"EarthMass is a unit of mass."], 	
	DeclareUnit["JupiterMass", Unit[1.8986*10^27, "Kilogram"], UsageMessage->"JupiterMass is a unit of mass."],
	(*Time*)
	Unit["Day"],
	DeclareUnit["JulianYear",Unit[365.25,"Day"],UsageMessage->"JulianYear is a unit of time."],
	DeclareUnit["JulianCentury",Unit[100,"JulianYear"],UsageMessage->"JulianCentury is a unit of time.",TraditionalLabel -> "D"]
};