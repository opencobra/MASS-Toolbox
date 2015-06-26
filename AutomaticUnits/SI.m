UnitSet["SI"]={
	(*Length*)
	DeclareUnit["Meter", Unit[1, "Meter"],UsageMessage->"Meter is the fundamental SI unit of length.",TraditionalLabel->"m"],
	(*Area*)
	Unit[1,"Meter"]^2,
	(*Volume*)
	Unit[1,"Meter"]^3,
	(*wavenumber*)
	1/Unit["Meter"],
	(*Mass*)
	DeclareUnit["Kilogram", Unit[1, "Kilogram"],UsageMessage->"Kilogram is the fundamental SI unit of mass.",TraditionalLabel->"kg"],
	(*Time*)
	DeclareUnit["Second", Unit[1, "Second"],UsageMessage->"Second is the fundamental SI unit of time.",TraditionalLabel->"s"],
	(*Frequency*)
	DeclareUnit["Hertz", 1/Unit["Second"], UsageMessage->"Hertz is the derived SI unit of frequency.",TraditionalLabel -> "Hz"],
	(*Velocity*)
	Unit["Meter"]/Unit["Second"],
	(*Force*)
	DeclareUnit["Newton", (Unit["Kilogram"]*Unit["Meter"])/Unit["Second"]^2,UsageMessage->"Newton is the derived SI unit of force.",TraditionalLabel->"N"],
	(*Energy*)
	DeclareUnit["Joule", 
 	Unit["Meter"] Unit["Newton"], UsageMessage->"Joule is the derived SI unit of energy.",  TraditionalLabel -> "J"],
	(*Power*)
	DeclareUnit["Watt", Unit["Joule"]/Unit["Second"], UsageMessage->"Watt is the derived SI unit of power.",TraditionalLabel->"W"],
	(*Pressure*)
	DeclareUnit["Pascal", Unit["Newton"]/Unit["Meter"]^2, UsageMessage->"Pascal is the derived SI unit of pressure.",TraditionalLabel->"Pa"],
	(*Viscosity*)
	Unit["Pascal"]Unit["Second"],
	(*Charge*)
	DeclareUnit["Coulomb", Unit["Ampere"]*Unit["Second"], UsageMessage->"Coulomb is the derived SI unit of electric charge.",TraditionalLabel->"C"],
	Unit["Coulomb"]/Unit["Kilogram"],
	(*Current*)
	DeclareUnit["Ampere", Unit["Ampere"], UsageMessage->"Ampere is the fundamental SI unit of electric current.",TraditionalLabel -> "A"],
	(*Voltage*)
	DeclareUnit["Volt", Unit["Watt"]/Unit["Ampere"],  UsageMessage->"Volt is the derived SI unit of electric potential difference.",TraditionalLabel -> "V"],
	(*Field*)
	Unit["Volt"]/Unit["Meter"],
	(*Magnetic Flux*)
	DeclareUnit["Weber", Unit["Second"]*Unit["Volt"],UsageMessage->"Weber is the derived SI unit of magnetic flux.",TraditionalLabel -> "Wb"],
	(*Magnetic induction*)
	DeclareUnit["Tesla", Unit["Meter"]^2*Unit["Weber"], UsageMessage->"Tesla is the derived SI unit of magnetic flux density.",TraditionalLabel -> "T"],
	(*Magnetic field strength*)
	Unit["Ampere"]/Unit["Meter"],
	(*magentic dipole moment*)
	Unit["Ampere"] Unit["Meter"]^2,
	(*Resistance*)
	DeclareUnit["Ohm", Unit["Volt"]/Unit["Ampere"], UsageMessage->"Ohm is the derived SI unit of electric resistance.",TraditionalLabel -> "\[CapitalOmega]"],
	DeclareUnit["Siemens", Unit["Ampere"]/Unit["Volt"], UsageMessage->"Siemens is the derived SI unit of electric conductance.",TraditionalLabel -> "S"],
	(*Resistivity*)
	Unit["Ohm"] Unit["Meter"],
	(*Capacitance*)
	DeclareUnit["Farad", (Unit["Ampere"]*Unit["Second"])/Unit["Volt"], UsageMessage->"Farad is the derived SI unit of electric capacitance.",TraditionalLabel -> "F"],
	(*Indcutance*)
	DeclareUnit["Henry", Unit["Ohm"]*Unit["Second"], UsageMessage->"Henry is the derived SI unit of inductance.",TraditionalLabel -> "H"],
	(*Angle*)
	DeclareUnit["Radian", Unit[1, "Radian"],UsageMessage-> "Radian is a dimensionless measure of plane angle."],
	DeclareUnit["Steradian", Unit["Radian"]^2, UsageMessage->"Steradian is a dimensionless measure of solid angle."], 
	(*Temperature*)
	DeclareUnit["Kelvin",Unit[1,"Kelvin"],UsageMessage->"Kelvin is the fundamental SI unit of thermodynamic temperature.", TraditionalLabel->"K"],
	(*Thermal resistance*)
	Unit["Meter"]^2Unit["Kelvin"]/Unit["Watt"],
	(*Information*)
	Unit["Bit"],
	(*LIght*)
	DeclareUnit["Candela",Unit[1,"Candela"],UsageMessage->"Candela is the fundamental SI unit of luminous intensity.",TraditionalLabel -> "cd"],
	DeclareUnit["Lumen", Unit["Candela"]*Unit["Steradian"],  UsageMessage->"Lumen is the derived SI unit of luminous flux.",TraditionalLabel -> "lm"], 
	DeclareUnit["Lux", Unit["Lumen"]/Unit["Meter"]^2, UsageMessage->"Lux is the derived SI unit of illumination (illuminance).",TraditionalLabel -> "lx"],
	DeclareUnit["GrayDose",Unit["Joule"]/Unit["Kilogram"],UsageMessage->"GrayDose is the derived SI unit of absorbed dose of radiation.",TraditionalLabel -> "Gy"],
	Unit["Joule"]/Unit["Tesla"],
	1/(Unit["Pascal"]Unit["Second"])
	};
