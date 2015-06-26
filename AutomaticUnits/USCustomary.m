UnitSet["USCustomary"]=Union[{
	(*Length*)
	DeclareUnit["Inch", Unit[254/10000, "Meter"], UsageMessage->"Inch is a unit of length.",TraditionalLabel -> "in"],
	DeclareUnit["Foot", Unit[12, "Inch"], UsageMessage->"Foot is a unit of length.",TraditionalLabel -> "ft"],
	DeclareUnit["Yard", Unit[3, "Foot"], UsageMessage->"Yard is a unit of length.",TraditionalLabel->"yd"],
	DeclareUnit["Mile", Unit[5280, "Foot"], UsageMessage->"Mile is a unit of length.",TraditionalLabel->"mi"],	
	(*Nautical*)
	DeclareUnit["Fathom", Unit[6, "Foot"], UsageMessage->"Fathom is a unit of length.",TraditionalLabel->"ftm"],
	DeclareUnit["Cable", Unit[720, "Foot"], UsageMessage->"Cable is a unit of length.",TraditionalLabel->"cb"],
	DeclareUnit["NauticalMile", Unit[1852, "Meter"], UsageMessage->"NauticalMile is a unit of length.", TraditionalLabel -> "NM"],
	
	DeclareUnit["Hand", Unit[4, "Inch"], UsageMessage->"Hand is a unit of length."],
	
	(*Area*) 
	Unit["Foot"]^2,Unit["Chain"]^2,
	DeclareUnit["Acre",4840 Unit["Yard"]^2,UsageMessage->"Acre is a unit of area."],
	(*Volume*)
	Unit["Inch"]^3,Unit["Foot"]^3,Unit["Yard"]^3,Unit["Acre"]Unit["Foot"],
	(*Liquid volume*)
	DeclareUnit["FluidOunce", Unit[1/16, "Pint"], UsageMessage->"FluidOunce is a US Customary unit of volume.",TraditionalLabel->"fl oz"]; 

	DeclareUnit["Minim", Unit[1/480, "FluidOunce"],  UsageMessage->"Minim is a unit of volume.",TraditionalLabel->"min"]; 
	DeclareUnit["FluidDram", Unit["FluidOunce"]/8, UsageMessage->"FluidDram is a unit of volume.",TraditionalLabel->"fl dr"],
	DeclareUnit["Tablespoon", Unit[4, "FluidDram"], UsageMessage->"Tablespoon is a unit of volume.",TraditionalLabel->"Tbsp"],
	DeclareUnit["Teaspoon", Unit[1/3, "Tablespoon"], UsageMessage->"Teaspoon is a unit of volume.",TraditionalLabel->"tsp"], 

	DeclareUnit["Jigger", Unit[3/2, "Shot"], UsageMessage->"Jigger is a unit of volume.",TraditionalLabel->"jig"], 
	DeclareUnit["USGill", Unit[1/4, "Pint"], UsageMessage->"USGill is a unit of volume.",TraditionalLabel->"gi"],
	DeclareUnit["Pint", Unit[473176473/10^9, "Liter"](*By 1964 definition*), UsageMessage->"Pint is a US Customary unit of volume.",TraditionalLabel->"pt"],
	DeclareUnit["USCup", Unit[1/2, "Pint"], UsageMessage->"USCup is a US Customary unit of volume.",TraditionalLabel->"cp"]; 


	DeclareUnit["Quart", Unit[2, "Pint"], UsageMessage->"Quart is a US Customary unit of volume.",TraditionalLabel->"qt"],
	DeclareUnit["Gallon", Unit[4, "Quart"], UsageMessage->"Gallon is a US volume unit.",TraditionalLabel->"gal"], 
(*	DeclareUnit["Barrel", 0.159*Unit["Meter"]^3, UsageMessage->"Barrel is a unit of volume.",TraditionalLabel -> "bbl"]
Old M7 defn looks to be wrong. It is roughly the value of OilBarrel *)
	DeclareUnit["Barrel", Unit[31+1/2,"Gallon"], UsageMessage->"Barrel is a unit of volume.",TraditionalLabel -> "bbl"],
	DeclareUnit["OilBarrel", Unit[42,"Gallon"], UsageMessage->"OilBarrel is a unit of volume.",TraditionalLabel -> "bbl"], 
	DeclareUnit["Hogshead", Unit[63, "Gallon"], UsageMessage->"Hogshead is a unit of volume."],

	DeclareUnit["DryPint",Unit[0.5506104713575,"Liter"],UsageMessage->"DryPint is a US Customary unit of volume.",TraditionalLabel -> "pt"],
	DeclareUnit["DryQuart",Unit[1.101220942715,"Liter"],UsageMessage->"DryQuart is a US Customary unit of volume.",TraditionalLabel -> "qt"],
	DeclareUnit["DryGallon",Unit[4,"DryQuart"],UsageMessage->"DryGallon is a US Customary unit of volume.",TraditionalLabel -> "gal"],
	DeclareUnit["Peck", Unit[8.81, "Liter"], UsageMessage->"Peck is a unit of volume.",TraditionalLabel -> "pk"],
	DeclareUnit["Bushel", Unit[4, "Peck"], UsageMessage->"Bushel is a unit of volume.",TraditionalLabel -> "bu"], 
	DeclareUnit["DryBarrel", 7056 Unit["Inch"]^3, UsageMessage->"DryBarrel is a unit of volume.",TraditionalLabel -> "bbl"], 

	(*Other*)
	DeclareUnit["BoardFoot", 144*Unit["Inch"]^3, UsageMessage->"BoardFoot is a unit of volume."],
	(*Energy*)
	DeclareUnit["BritishThermalUnit", Unit[1055.05585257348, "Joule"], UsageMessage->"BritishThermalUnit is a unit of energy.",TraditionalLabel->"Btu"],(*This is the ISO standard value http://www.opsi.gov.uk/si/si1995/Uksi_19951804_en_2.htm*)
	DeclareUnit["Calorie", Unit[4.1868, "Joule"], UsageMessage->"Calorie is a unit of energy."],
	(*Power*)
	DeclareUnit["Horsepower", Unit[745.7, "Watt"], UsageMessage->"Horsepower is a unit of power."],
	(*Force*)
	DeclareUnit["PoundForce", Unit[4.44822, "Newton"], UsageMessage->"PoundForce is a unit of force.",TraditionalLabel->"lbf"],
	(*Pressure*)
	DeclareUnit["PSI", Unit["PoundForce"]/Unit["Inch"]^2, UsageMessage->"PSI is a unit of pressure."],
	
	(*Time*)
	Unit[1,"Second"],
	DeclareUnit["Minute", Unit[60, "Second"], UsageMessage->"Minute is a unit of time.",TraditionalLabel -> "min"], 
	DeclareUnit["Hour", Unit[60, "Minute"], UsageMessage->"Hour is a unit of time.",TraditionalLabel->"h"], 
	DeclareUnit["Day", Unit[24, "Hour"], UsageMessage->"Day is a unit of time.",TraditionalLabel->"d"], 
	DeclareUnit["Week", Unit[7, "Day"], UsageMessage->"Week is a unit of time."],
	DeclareUnit["Year", Unit[365, "Day"], UsageMessage->"Year is a unit of time.",TraditionalLabel->"yr"],
	DeclareUnit["Month", Unit[1/12, "Year"], UsageMessage->"Month is a unit of time."],
	
	(*Velocity*)
	Unit["Mile"]/Unit["Hour"],

	(*Viscosity*)
	Unit["PSI"]/Unit["Second"],Unit["PSI"]/Unit["Minute"],Unit["PSI"]/Unit["Hour"],

	(*Angle*)
	DeclareUnit["Degree", Unit[Pi/180, "Radian"], CreateSymbol -> False],
	(*Temperature*)
	DeclareUnit["Fahrenheit", Unit[5/9, "Kelvin"], UsageMessage->"Fahrenheit is a unit of temperature."],
	(*Thermal resistance*)
	Unit["Foot"]^2 Unit["Fahrenheit"] Unit["Hour"]/Unit["BritishThermalUnit"]

},(*Mass*) UnitSet["Troy"],UnitSet["Avoirdupois"],UnitSet["Survey"]];