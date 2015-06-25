UnitSet["Alternative"]={
(*--------------- angles---------------- *)
DeclareUnit["Circle", Unit[2*Pi, "Radian"], CreateSymbol -> False], 
DeclareUnit["RightAngle", Unit[Pi/2, "Radian"], UsageMessage->"RightAngle is a unit of angle."], 
DeclareUnit["ArcMinute", Unit[Pi/10800, "Radian"], UsageMessage->"ArcMinute is a unit of angle."], 
DeclareUnit["ArcSecond", Unit[1/60, "ArcMinute"], UsageMessage->"ArcSecond is a unit of angle."], 
DeclareUnit["Quadrant", Unit[1, "RightAngle"], UsageMessage->"Quadrant is a unit of angle."], 
DeclareUnit["Grade", Unit[1/100, "RightAngle"], UsageMessage->"Grade is a unit of angle."],
DeclareUnit["RPM", Unit["Circle"]/Unit["Minute"],UsageMessage->"RPM is a unit of angular velocity."],


(* ---------------distance, length----------------- *)
DeclareUnit["Angstrom", Unit[1/10000000000, "Meter"], UsageMessage->"Angstrom is a unit of length.",TraditionalLabel->"\[Angstrom]"], 
DeclareUnit["XUnit", Unit[1.002*^-13, "Meter"], UsageMessage->"XUnit is a unit of length."], (*No short label*)
DeclareUnit["Fermi", Unit[1*^-15, "Meter"], UsageMessage->"Fermi is a unit of length.",TraditionalLabel -> "fm"], 
DeclareUnit["Micron", Unit[1/1000000, "Meter"], UsageMessage->"Micron is a unit of length.",TraditionalLabel->"\[Micro]m"], 

(*Inch related*)
DeclareUnit["Mil", Unit[1/1000, "Inch"], UsageMessage->"Mil is a unit of length."], 
DeclareUnit["Caliber", Unit[1/100, "Inch"], UsageMessage->"Caliber is a unit of length."], 
DeclareUnit["Span", Unit[9, "Inch"], CreateSymbol -> False], 
DeclareUnit["Cubit", Unit[18, "Inch"], UsageMessage->"Cubit is a unit of length."], 
DeclareUnit["Ell", Unit[45, "Inch"], UsageMessage->"Ell is a unit of length."], 
DeclareUnit["Rope", Unit[20, "Foot"], UsageMessage->"Rope is a unit of length."], 
DeclareUnit["Skein", Unit[360, "Foot"], UsageMessage->"Skein is a unit of length."], 
DeclareUnit["Stadion", Unit[622, "Foot"], UsageMessage->"Stadion is a unit of length."], 
DeclareUnit["Bolt", Unit[40, "Yard"], UsageMessage->"Bolt is a unit of length."], 
DeclareUnit["Stadium", Unit[202, "Yard"], UsageMessage->"Stadium is a unit of length."], 

	(* Didot (printing units)*)
DeclareUnit["Didot", Unit[1/2660, "Meter"], UsageMessage->"Didot is a unit of length."], 
DeclareUnit["DidotPoint", Unit[1, "Didot"], UsageMessage->"DidotPoint is a unit of length."], 
DeclareUnit["Cicero", Unit[12, "Didot"], UsageMessage->"Cicero is a unit of length."],  (*No short label*)
DeclareUnit["Point", Unit[1/72, "Inch"], CreateSymbol -> False], 
DeclareUnit["Pica", Unit[12, "Point"], UsageMessage->"Pica is a unit of length."], 
DeclareUnit["PrintersPoint",Unit[1/7227, "Inch"],UsageMessage->"PrintersPoint is a unit of length."],

(*-----------------inverse length---------------*)
DeclareUnit["Diopter", 1/Unit["Meter"],  UsageMessage->"Diopter is a unit of inverse length."], 

(*---------------Area--------------------*)
DeclareUnit["Hectare", 10000*Unit["Meter"]^2, UsageMessage->"Hectare is a unit of area.",TraditionalLabel -> "ha"], 
DeclareUnit["Are", 100 Unit["Meter"]^2, UsageMessage->"Are is a unit of area.",TraditionalLabel -> "a"], 
DeclareUnit["Barn", 1*^-28 Unit["Meter"]^2, UsageMessage->"Barn is a unit of area.",TraditionalLabel -> "b"], 

(*----------------volume-----------------*)

DeclareUnit["Drop", 3.*^-8*Unit["Meter"]^3, CreateSymbol -> False], 
DeclareUnit["Liter", Unit["Meter"]^3/1000, UsageMessage->"Liter is a unit of volume.",TraditionalLabel->"l"], 
DeclareUnit["Cord", 128*Unit["Foot"]^3, UsageMessage->"Cord is a unit of volume."], 
DeclareUnit["RegisterTon", 100*Unit["Foot"]^3, UsageMessage->"RegisterTon is a unit of volume."], 
(*DeclareUnit["WineBottle", Unit[0.7576778, "Liter"], UsageMessage->"WineBottle is a unit of volume."], *)
(*This seems to use the "Fifth" definition (used in US and deprecated in 1979 in favour of metric 75cl) rather than Standard.Should probably be exact*)
DeclareUnit["WineBottle", Unit[4/5, "Quart"], UsageMessage->"WineBottle is a unit of volume."], 

DeclareUnit["Last", Unit[2909.414, "Liter"], CreateSymbol -> False], 
DeclareUnit["Firkin", Unit[9, "ImperialGallon"], UsageMessage->"Firkin is a unit of volume."], 
DeclareUnit["Fifth", Unit[4/5, "Quart"], UsageMessage->"Fifth is a unit of volume."], 
(*DeclareUnit["Magnum", Unit[2, "Quart"], UsageMessage->"Magnum is a unit of volume."], *)
(*DeclareUnit["Jeroboam", Unit[4/5, "Gallon"], UsageMessage->"Jeroboam is a unit of volume."], *)
(*Replaced with metric definition*)
DeclareUnit["Bucket", Unit[4, "Gallon"], UsageMessage->"Bucket is a unit of volume."], 
DeclareUnit["Puncheon", Unit[84, "Gallon"], UsageMessage->"Puncheon is a unit of volume."], 
DeclareUnit["Butt", Unit[126, "Gallon"], UsageMessage->"Butt is a unit of volume."], 
DeclareUnit["Tun",Unit[2,"Butt"],UsageMessage->"Tun is a unit of volume."],
DeclareUnit["Shot", Unit["FluidOunce"], UsageMessage->"Shot is a unit of volume."], 
DeclareUnit["Pony", Unit[1/2, "Jigger"], UsageMessage->"Pony is a unit of volume."], 
DeclareUnit["Seam", Unit[8, "Bushel"], UsageMessage->"Seam is a unit of volume."], 
DeclareUnit["Bag", Unit[3, "Bushel"], UsageMessage->"Bag is a unit of volume."], 
DeclareUnit["Omer", Unit[0.45, "Peck"], UsageMessage->"Omer is a unit of volume."], 
DeclareUnit["Ephah", Unit[10, "Omer"], UsageMessage->"Ephah is a unit of volume."], 

(* ------------------mass ---------------- *)
DeclareUnit["Slug", Unit[14.5939, "Kilogram"], UsageMessage->"Slug is a unit of mass."], 
DeclareUnit["Quintal", Unit[100000, "Gram"],  UsageMessage->"Quintal is a unit of mass."], 

DeclareUnit["AssayTon", Unit[29.167, "Gram"], UsageMessage->"AssayTon is a unit of mass."], 
DeclareUnit["Carat", Unit[0.2, "Gram"], UsageMessage->"Carat is a unit of weight."], 
DeclareUnit["Shekel", Unit[14.1, "Gram"], UsageMessage->"Shekel is a unit of weight."], 
DeclareUnit["Obolos", Unit[0.71538, "Gram"], UsageMessage->"Obolos is a unit of weight."], 
DeclareUnit["Drachma", Unit[4.2923, "Gram"], UsageMessage->"Drachma is a unit of weight."], 
DeclareUnit["Libra", Unit[325.971, "Gram"], UsageMessage->"Libra is a unit of weight."], 

(*AMU*) 
DeclareUnit["AtomicMassUnit", Unit[1.66053878283*^-24, "Gram"], UsageMessage->"AtomicMassUnit is a unit of mass.",TraditionalLabel -> "u"], 
(*Change per WP*)
(*Pound*)
DeclareUnit["Pondus", Unit[0.71864, "Pound"], UsageMessage->"Pondus is a unit of weight."], 
DeclareUnit["Wey", Unit[252, "Pound"], UsageMessage->"Wey is a unit of weight."], 
DeclareUnit["Bale", Unit[500, "Pound"], UsageMessage->"Bale is a unit of weight."], 
DeclareUnit["Cental", Unit[100, "Pound"], UsageMessage->"Cental is a unit of weight."], 
DeclareUnit["NetHundredweight", Unit[100, "Pound"], UsageMessage->"NetHundredweight is a unit of weight."], 
(*Mina*)
DeclareUnit["Mina", Unit[0.9463, "Pound"], UsageMessage->"Mina is a unit of weight."], (*Reference needed*)
DeclareUnit["Talent", Unit[60, "Mina"], UsageMessage->"Talent is a unit of weight."], 
(*Slug*)
DeclareUnit["Geepound", Unit[1, "Slug"], UsageMessage->"Geepound is a unit of mass."], 

(*-------------time----------------*)
DeclareUnit["SiderealSecond", Unit[0.9972696, "Second"], UsageMessage->"SiderealSecond is a unit of time."], 
DeclareUnit["Fortnight", Unit[2, "Week"], UsageMessage->"Fortnight is a unit of time."], 
DeclareUnit["Decade", Unit[10, "Year"], UsageMessage->"Decade is a unit of time."], 
DeclareUnit["Century", Unit[100, "Year"], UsageMessage->"Century is a unit of time."], 
DeclareUnit["Millennium", Unit[1000, "Year"], UsageMessage->"Millennium is a unit of time."], 
DeclareUnit["TropicalYear", Unit[365.24218956, "Day"], UsageMessage->"TropicalYear is a unit of time."], (*New val*)
DeclareUnit["SiderealYear", Unit[365.256363004, "Day"], UsageMessage->"SiderealYear is a unit of time."], 
(*----------------speed----------------------*)
DeclareUnit["Knot", Unit["NauticalMile"]/Unit["Hour"], UsageMessage->"Knot is a unit of speed.",TraditionalLabel->"kn"], 

(* ---------------acceleration ----------------*)
DeclareUnit["Gravity", Unit[9.80665, "Meter"]/Unit["Second"]^2, UsageMessage->"Gravity is a measure of the acceleration due to gravity.",TraditionalLabel -> "g"], 

(*--------------------force-------------------*)
DeclareUnit["Poundal", Unit[0.138255, "Newton"], UsageMessage->"Poundal is a unit of force.",TraditionalLabel->"pdl"], 
DeclareUnit["TonForce", Unit[9964.02, "Newton"], UsageMessage->"TonForce is a unit of force."], 
	(* PoundForce *)
DeclareUnit["PoundWeight", Unit[1, "PoundForce"], UsageMessage->"PoundWeight is a unit of force."], 
	(* KilogramForce *)
DeclareUnit["KilogramForce", Unit[9.80665, "Newton"], UsageMessage->"KilogramForce is a unit of force."], 
DeclareUnit["KilogramWeight", Unit[1, "KilogramForce"], UsageMessage->"KilogramWeight is a unit of force."], 
DeclareUnit["GramWeight", Unit[1/1000, "KilogramWeight"], UsageMessage->"GramWeight is a unit of force."], 

(*------------------- energy ---------------*)
DeclareUnit["Therm", Unit[100000, "BTU"], UsageMessage->"Therm is a unit of energy."], 
DeclareUnit["ElectronVolt", Unit[0.1602176487*10^-18, "Joule"], UsageMessage->"ElectronVolt is a unit of energy.",TraditionalLabel -> "eV"], 
DeclareUnit["Rydberg", Unit[2.1799*^-11, "Erg"], UsageMessage->"Rydberg is a unit of energy."], 

(* -----------------power -------------------*)
DeclareUnit["ChevalVapeur", Unit[735.499, "Watt"], UsageMessage->"ChevalVapeur is a unit of power."],

(* ----------------light---------------- *)
DeclareUnit["Nit", Unit["Candela"]/Unit["Meter"]^2, UsageMessage->"Nit is a unit of luminance (photometric brightness)."], 
DeclareUnit["Hefner", Unit[0.92, "Candela"], UsageMessage->"Hefner is a unit of luminous intensity."], 
DeclareUnit["Candle", Unit["Candela"], UsageMessage->"Candle is a unit of luminous intensity."], 
DeclareUnit["Lambert", Unit[10000/Pi, "Lumen"]/Unit["Meter"]^2,  UsageMessage->"Lambert is a unit of luminance (photometric brightness)."], 
DeclareUnit["Talbot", Unit["Lumen"]*Unit["Second"],  UsageMessage->"Talbot is a unit of luminous energy (quantity of light)."], 
DeclareUnit["FootCandle", (Unit["Lux"]*Unit["Meter"]^2)/Unit["Foot"]^2, UsageMessage->"FootCandle is a unit of illumination (illuminance)."], 


(* -----------------electric--------------- *)
DeclareUnit["Amp", Unit["Ampere"], UsageMessage->"Amp is an abbreviation for Ampere.",TraditionalLabel -> "A"], 
DeclareUnit["Statampere", Unit[3.335635*^-10, "Ampere"], UsageMessage->"Statampere is a unit of electric current."], 
DeclareUnit["Gilbert", Unit[10/(4 Pi), "Ampere"], UsageMessage->"Gilbert is a unit of magnetomotive force."], 
DeclareUnit["Biot", Unit[10, "Ampere"], UsageMessage->"Biot is a unit of electric current."], 
DeclareUnit["Statvolt", Unit[299792458/10^6, "Volt"], UsageMessage->"Statvolt is a unit of electric potential difference.",TraditionalLabel -> "statV"], 
DeclareUnit["Statohm", Unit[8.987584*^11, "Ohm"], UsageMessage->"Statohm is a unit of electric resistance."], 
DeclareUnit["Mho", 1/Unit["Ohm"], UsageMessage->"Mho is a unit of electric conductance."], 
DeclareUnit["Statcoulomb", Unit[1/2997924580, "Coulomb"], UsageMessage->"Statcoulomb is a unit of electric charge.",TraditionalLabel -> "statC"], 
DeclareUnit["Statfarad", Unit[1.112646*^-12, "Farad"],UsageMessage->"Statfarad is a unit of electric capacitance."], 
DeclareUnit["Stathenry", Unit[8.987584*^11, "Henry"], UsageMessage->"Stathenry is a unit of inductance."], 

(* -------------- magnetic -----------------*)
DeclareUnit["Gamma", Unit[1/10^9, "Tesla"], CreateSymbol -> False], 
DeclareUnit["BohrMagneton", Unit[9.2740091523*^-24, "Joule"]/Unit["Tesla"], UsageMessage->"BohrMagneton is a unit of magnetic moment."], (*http://en.wikipedia.org/wiki/Bohr_magneton*)
DeclareUnit["NuclearMagneton", Unit[5.0507832413*^-27, "Joule"]/Unit["Tesla"], UsageMessage->"NuclearMagneton is a unit of magnetic moment."], (*New defn*)


(* ----------------radioactivity-------------- *)
DeclareUnit["Rutherford", 1000000/Unit["Second"],  UsageMessage->"Rutherford is a unit of radioactivity."], 
DeclareUnit["Gray", Unit["Joule"]*Unit["Kilogram"], CreateSymbol -> False], 
DeclareUnit["Becquerel", 1/Unit["Second"],UsageMessage->"Becquerel is the derived SI unit of radioactivity.",TraditionalLabel -> "Bq"], 


(* ------------------pressure---------------- *)
DeclareUnit["Atmosphere", Unit[101325, "Pascal"], UsageMessage->"Atmosphere is a unit of pressure.",TraditionalLabel->"atm"],
DeclareUnit["TechnicalAtmosphere", Unit["KilogramForce"]/Unit["Centimeter"]^2, UsageMessage->"TechnicalAtmosphere is a unit of pressure.",TraditionalLabel->"at"],
DeclareUnit["InchMercury", Unit[3386.39, "Pascal"], UsageMessage->"InchMercury is a unit of pressure."], 
DeclareUnit["Bar", Unit[100000, "Pascal"], UsageMessage->"Bar is a unit of pressure.",TraditionalLabel->"bar"], 
DeclareUnit["PoundsPerSquareInch", Unit[1, "PSI"], UsageMessage->"PoundsPerSquareInch is a unit of pressure."], 
DeclareUnit["Torr", Unit[1/760, "Atmosphere"], UsageMessage->"Torr is a unit of pressure."], 
DeclareUnit["MillimeterMercury", Unit[1, "Torr"], UsageMessage->"MillimeterMercury is a unit of pressure."],

 
(* -------------temperature-------------- *)
DeclareUnit["Centigrade", Unit[1, "Kelvin"], UsageMessage->"Centigrade is a unit of temperature."], 
DeclareUnit["Celsius", Unit[1, "Centigrade"], UsageMessage-> "Celsius is a unit of temperature."], 
DeclareUnit["Rankine", Unit[1, "Fahrenheit"], UsageMessage->"Rankine is a unit of temperature."], 

(* -------------viscosity--------------- *)
	(* Poise *)
DeclareUnit["Reyn", Unit[68947.59999999999, "Poise"], UsageMessage-> "Reyn is a unit of absolute viscosity."], 
DeclareUnit["Rhes", 1/Unit["Poise"],UsageMessage-> "Rhes is a unit of viscosity."], 
	(* Lambert *)
DeclareUnit["Apostilb", Unit[1/10000, "Lambert"], UsageMessage->"Apostilb is a unit of luminance (photometric brightness)."], 
	(* Talbot *)
DeclareUnit["Lumerg", Unit[1, "Talbot"], UsageMessage->"Lumerg is a unit of luminous energy (quantity of light)."], 
(* radioactivity *)
DeclareUnit["Rad", Unit[1/100, "GrayDose"],UsageMessage-> "Rad is a unit of absorbed dose of radiation.",TraditionalLabel->"rad"], 
DeclareUnit["Curie", Unit[37000000000, "Becquerel"], UsageMessage-> "Curie is a unit of radioactivity.",TraditionalLabel->"Ci"], 
DeclareUnit["Rontgen", Unit[0.000258, "Coulomb"]/Unit["Kilogram"],  
			UsageMessage->"Rontgen is a unit of exposure to X or gamma radiation.",TraditionalLabel->"R"], 
DeclareUnit["Roentgen", Unit[1, "Rontgen"], UsageMessage->"Roentgen is a unit of exposure to X or gamma radiation.",TraditionalLabel->"R"], 



(* ------------fineness-------------- *)
	(* Denier *)
DeclareUnit["Denier", Unit[1/9000, "Gram"]/Unit["Meter"], UsageMessage->"Denier is a unit of fineness for yarn or thread."], 


(* ------------information----------------- *)
	DeclareUnit["Byte", Unit[8, "Bit"], CreateSymbol -> False],
Map[DeclareUnit[#[[1]] <> "bit", Unit[#[[2]], name], 
    UsageMessage -> #[[1]] <> "bit is a prefixed SI unit of information.", TraditionalLabel -> #[[3]] <> "bit"] &,
  {{"Yotta", 10^24, "Y"},
   {"Zetta", 10^21, "Z"},
   {"Exa", 10^18, "E"},
   {"Peta", 10^15, "P"},
   {"Tera", 10^12, "T"},
   {"Giga", 10^9, "G"},
   {"Mega", 10^6, "M"},
   {"Kilo", 10^3, "k"},
   {"Hecto", 100, "h"},
   {"Deca", 10, "da"}}],

DeclareUnit["Nibble", Unit[4, "Bit"],UsageMessage-> "Nibble is a unit of information."], 
DeclareUnit["Baud", Unit["Bit"]/Unit["Second"],UsageMessage-> "Baud is a unit of information."]
};