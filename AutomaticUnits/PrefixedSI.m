UnitSet["PrefixedSI"]=Flatten[{UnitSet["SI"],
	(*Length, area, volume, wavenumber, veclocity*)
	{#,#^2,#^3,1/#,#/Unit["Second"]}&/@AutomaticUnits`private`SIPrefixify["Meter", "length", "m"],
	(*Mass*)
	Unit[1, "Kilogram"],
	(*Time*)
	AutomaticUnits`private`SIPrefixify["Second", "time", "s"],
	(*Frequency*)
	AutomaticUnits`private`SIPrefixify["Hertz", "frequency", "Hz"],
	(*Force*)
	AutomaticUnits`private`SIPrefixify["Newton", "force", "N"],
	(*Energy*)
	AutomaticUnits`private`SIPrefixify["Joule", "energy", "J"],
	(*Power*)
	AutomaticUnits`private`SIPrefixify["Watt", "power", "W"],
	(*Pressure, viscosity*)
	{#,#/Unit["Second"]}&/@	AutomaticUnits`private`SIPrefixify["Pascal", "pressure", "Pa"],
	(*Charge*)
	AutomaticUnits`private`SIPrefixify["Coulomb", "charge", "C"],
	(*Current, magnetic field strength, dipole moment*)
	{#,#/Unit["Meter"],# Unit["Meter"]^2}&/@AutomaticUnits`private`SIPrefixify["Ampere", "current", "A"],
	(*Voltage, field*)
	{#,#/Unit["Meter"]}&/@AutomaticUnits`private`SIPrefixify["Volt", "electric potential difference", "V"],
	(*Magnetic Flux*)
	AutomaticUnits`private`SIPrefixify["Weber", "magnetic flux", "Wb"],
	(*Magnetic induction*)
	AutomaticUnits`private`SIPrefixify["Tesla", "magnetic flux density", "T"],
	(*Resistance, resistivity*)
	{#,#/Unit["Meter"]}&/@AutomaticUnits`private`SIPrefixify["Ohm", "electric resistance", "\[CapitalOmega]"],
	(*Capacitance*)
	AutomaticUnits`private`SIPrefixify["Farad", "electric capacitance", "F"],
	(*Indcutance*)
	AutomaticUnits`private`SIPrefixify["Henry", "inductance", "H"],
	
(*Light*)
	AutomaticUnits`private`SIPrefixify["Candela", "luminous intensity", "cd"],
	AutomaticUnits`private`SIPrefixify["Lumen", "luminous flux", "lm"],
	AutomaticUnits`private`SIPrefixify["Lux", "illumination (illuminance)", "lx"],

	(*Angle*)
	Unit["Radian"],
	(*Temperature*)
	{#,Unit["Meter"]^2 #/Unit["Watt"]}&/@AutomaticUnits`private`SIPrefixify["Kelvin", "thermodynamic temperature", "K"],
	
	DeclareUnit["Bit", Unit[1, "Bit"], UsageMessage->"Bit is the fundamental unit of information.",TraditionalLabel->"bit"], 
	Unit["Byte"], 
	
	Map[DeclareUnit[#[[1]] <> "byte", Unit[#[[2]], name], 
    UsageMessage -> #[[1]] <> "byte is a prefixed SI unit of information.", TraditionalLabel -> #[[3]] <> "byte"] &,
  {{"Yotta", 10^24, "Y"},
   {"Zetta", 10^21, "Z"},
   {"Exa", 10^18, "E"},
   {"Peta", 10^15, "P"},
   {"Tera", 10^12, "T"},
   {"Giga", 10^9, "G"},
   {"Mega", 10^6, "M"},
   {"Kilo", 10^3, "k"},
   {"Hecto", 100, "h"},
   {"Deca", 10, "da"}}]}];