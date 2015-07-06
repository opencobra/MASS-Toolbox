UnitSet["Imperial"]=Union[{
	(*Length*)
	DeclareUnit["Thou",Unit[1/12000,"Foot"],UsageMessage->"Thou is an Imperial unot of length."], 
	Unit["Inch"], Unit["Foot"],Unit["Yard"],
	DeclareUnit["Furlong", Unit[220, "Yard"], UsageMessage->"Furlong is a unit of length."],
	Unit["Mile"],Unit["League"],Unit["Fathom"],Unit["Cable"],Unit["NauticalMile"],Unit["Link"],Unit["Chain"],	
	DeclareUnit["Pole", Unit[1, "Rod"], UsageMessage->"Pole is a unit of length."], 
	DeclareUnit["Perch", Unit[1, "Rod"], UsageMessage->"Perch is a unit of length."], 
	DeclareUnit["Rood", Unit[1/4, "Acre"], UsageMessage->"Rood is a unit of area."],  (*No short label*)
	Unit["Acre"],


	DeclareUnit["ImperialFluidOunce", Unit[284130625/10^10, "Liter"], UsageMessage->"FluidOunce is a unit of volume."], 
	DeclareUnit["ImperialGallon", Unit[454609/100000, "Liter"], UsageMessage->"ImperialGallon is a unit of volume.",TraditionalLabel->"impgal"], 
	DeclareUnit["ImperialPint", Unit[20, "ImperialFluidOunce"], UsageMessage->"ImperialPint is a unit of volume.",TraditionalLabel->"ipt"], 
	DeclareUnit["ImperialQuart", Unit[40, "ImperialFluidOunce"], UsageMessage->"ImperialQuart is a unit of volume."], 
	DeclareUnit["ImperialGill", Unit[5, "ImperialFluidOunce"], UsageMessage->"ImperialGill is a unit of volume."],	
	(*Energy*)
	Unit["BritishThermalUnit"],	Unit["Calorie"],
	(*Power*)
	Unit["Horsepower"],
	(*Force*)
	Unit["PoundForce"],
	(*Pressure*)
	Unit["PSI"],	
	(*Time*)
	Unit["Second"],Unit["Minute"],Unit["Hour"],Unit["Day"],Unit["Week"],Unit["Year"],Unit["Month"],	
	(*Velocity*)
	Unit["Mile"]/Unit["Hour"],
	(*Viscosity*)
	Unit["PSI"]/Unit["Second"],Unit["PSI"]/Unit["Minute"],Unit["PSI"]/Unit["Hour"],
	(*Angle*)
	Unit["Degree"],
	(*Temperature*)
	Unit["Fahrenheit"],
	(*Thermal resistance*)
	Unit["Foot"]^2 Unit["Fahrenheit"] Unit["Hour"]/Unit["BritishThermalUnit"]	
},UnitSet["Troy"],UnitSet["BritishAvoirdupois"]];