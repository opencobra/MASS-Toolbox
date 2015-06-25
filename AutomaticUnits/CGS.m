UnitSet["CGS"]={
	(*Length*)
	Unit["Centimeter"],
	(*Mass*)
	DeclareUnit["Gram", Unit[1/1000, "Kilogram"], UsageMessage->"Gram is the fundamental CGS unit of mass.",TraditionalLabel -> "g"],
	(*Time*)
	Unit["Second"],
	(*Velocity*)
	Unit["Centimeter"]/Unit["Second"],
	(*Force*)
	DeclareUnit["Dyne", Unit[1/100000, "Newton"], UsageMessage->"Dyne is the derived CGS unit of force.",TraditionalLabel->"dyn"],
	(*Energy*)
	DeclareUnit["Erg", Unit[1*^-7, "Joule"], UsageMessage->"Erg is the derived CGS unit of energy.",TraditionalLabel -> "erg"],
	(*Power*)
	Unit["Erg"]/Unit["Second"],
	(*Pressure*)
	DeclareUnit["Barye", Unit[1/10, "Pascal"], UsageMessage->"Barye is the derived CGS unit of pressure."],
	(*Viscosity*)
	DeclareUnit["Poise", Unit["Second"]*Unit[0.1, "Pascal"], UsageMessage-> "Poise is the derived CGS unit of absolute viscosity.",TraditionalLabel->"P"],
	(*wavenumber*)
	DeclareUnit["Kayser", 100/Unit["Meter"], UsageMessage->"Kayser is a unit of inverse length."],
	(*Area*)
	Unit[1,"Centimeter"]^2,
	(*Volume*)
	Unit[1,"Centimeter"]^3,
	(*EMU CGS units*)
	(*Charge*)
	DeclareUnit["Abcoulomb", Unit[10, "Coulomb"], UsageMessage->"Abcoulomb is a unit of electric charge in the CGS system.",TraditionalLabel -> "abC"],
	(*Current*)
	DeclareUnit["Abampere", Unit[10, "Ampere"], UsageMessage->"Abampere is a unit of electric current in the CGS system."],
	(*Voltage*)
	DeclareUnit["Abvolt", Unit[1/100000000, "Volt"], UsageMessage->"Abvolt is a unit of electric potential difference in the CGS system.",TraditionalLabel -> "abV"],
	(*Flux*)
	DeclareUnit["Maxwell", Unit[1/100000000, "Weber"], UsageMessage->"Maxwell is the derived CGS unit of magnetic flux.",TraditionalLabel -> "Mx"],
	(*Field*)
	Unit["Abvolt"]/Unit["Centimeter"],
	(*Magnetic induction*)
	DeclareUnit["Gauss", Unit[1/10000, "Tesla"], UsageMessage->"Gauss is the derived CGS unit of magnetic flux density.",TraditionalLabel->"G"],
	(*Magnetic field strength*)
	DeclareUnit["Oersted", Unit[250/Pi, "Ampere"]/Unit["Meter"], UsageMessage->"Oersted is the derived CGS unit of magnetic intensity.",TraditionalLabel -> "Oe"],
	(*magentic dipole moment*)
	Unit["Abampere"]/Unit["Centimetet"]^2,
	(*Resistance*)
	DeclareUnit["Abohm", Unit[1/1000000000, "Ohm"], UsageMessage->"Abohm is a unit of electric resistance in the CGS system.",TraditionalLabel -> "ab\[CapitalOmega]"],
	(*Resistivity*)
	Unit["Abohm"] Unit["Centimeter"],
	(*Capacitance*)
	DeclareUnit["Abfarad", Unit[1000000000, "Farad"], UsageMessage->"Abfarad is a unit of electric capacitance in the CGS system.",TraditionalLabel -> "abF"],
	(*Indcutance*)
	DeclareUnit["Abhenry", Unit[1/1000000000, "Henry"], UsageMessage->"Abhenry is a unit of inductance in the CGS system.",TraditionalLabel -> "abH"],
		(*Angle*)
	Unit["Radian"],
	DeclareUnit["Gal", Unit[1/100, "Meter"]/Unit["Second"]^2, UsageMessage->"Gal is the derived CGS measure of acceleration due to gravity.",TraditionalLabel -> "gal"], 
	DeclareUnit["Stilb", Unit[10000, "Candela"]/Unit["Meter"]^2, UsageMessage->"Stilb is the derived CGS unit of luminance (photometric brightness).",TraditionalLabel -> "sb"], 
	DeclareUnit["Phot", Unit[10000, "Lux"],UsageMessage->"Phot is the derived CGS unit of illumination (illuminance).",TraditionalLabel->"ph"], 
	DeclareUnit["Abmho", Unit[10^9, "Mho"], UsageMessage->"Abmho is a unit of electric conductance in the CGS system."],
	DeclareUnit["Stokes", Unit["Meter"]^2/(10000*Unit["Second"]), UsageMessage->"Stokes is the derived CGS unit of kinematic viscosity.",TraditionalLabel -> "St"],
	
	Unit["Kelvin"],
	Unit["Candela"] 
};