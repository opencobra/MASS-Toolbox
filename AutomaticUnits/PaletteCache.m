AvailableDimensions["All"] = {"Length", "Area", "Volume", 
     "Wavenumber", "Mass", "Time", "Frequency", "Velocity", "Force", 
     "Energy", "Power", "Pressure", "Viscosity", "Charge", "Current", 
     "Voltage", "Magnetic Induction", "Resistance", "Capacitance", 
     "Inductance", "Data", "Angle"}
 
AvailableDimensions["Alternative"] = 
    {"Length", "Area", "Volume", "Wavenumber", "Mass", "Time", "Frequency", 
     "Velocity", "Force", "Energy", "Power", "Pressure", "Viscosity", 
     "Charge", "Current", "Voltage", "Magnetic Induction", "Resistance", 
     "Capacitance", "Inductance", "Data", "Angle"}
 
AvailableDimensions["AlternativeNames"] = 
    {"Length", "Volume", "Mass", "Energy", "Charge", "Magnetic Induction", 
     "Data", "Angle"}
 
AvailableDimensions["Anthropic"] = {"Length", "Area"}
 
AvailableDimensions["Arabic"] = {"Length", "Volume", "Mass"}
 
AvailableDimensions["Astronomical"] = {"Length", "Mass", "Time"}
 
AvailableDimensions["Atomic"] = {"Length", "Mass", "Time", 
     "Velocity", "Force", "Energy", "Pressure", "Charge"}
 
AvailableDimensions["Avoirdupois"] = {"Mass"}
 
AvailableDimensions["BritishAvoirdupois"] = {"Mass"}
 
AvailableDimensions["CGS"] = {"Length", "Area", "Volume", 
     "Wavenumber", "Mass", "Time", "Velocity", "Force", "Energy", "Power", 
     "Pressure", "Viscosity", "Charge", "Current", "Voltage", 
     "Magnetic Field Strength", "Magnetic Induction", 
     "Magnetic Field Strength", "Resistance", "Resistivity", "Capacitance", 
     "Inductance", "Angle"}
 
AvailableDimensions["Champagne"] = {"Volume"}
 
AvailableDimensions["IEC"] = {"Data"}
 
AvailableDimensions["Imperial"] = {"Length", "Area", "Volume", 
     "Mass", "Time", "Velocity", "Force", "Energy", "Power", "Pressure", 
     "Angle"}
 
AvailableDimensions["InteractiveChoices"] = 
    {"Length", "Area", "Volume", "Wavenumber", "Mass", "Time", "Frequency", 
     "Velocity", "Force", "Energy", "Power", "Pressure", "Viscosity", 
     "Charge", "Current", "Voltage", "Magnetic Field Strength", 
     "Magnetic Induction", "Magnetic Field Strength", 
     "Magnetic Dipole Moment", "Resistance", "Resistivity", "Capacitance", 
     "Inductance", "Data", "Angle"}
 
AvailableDimensions["Japanese"] = {"Length", "Area", "Volume", 
     "Mass"}
 
AvailableDimensions["Malay"] = {"Volume", "Mass"}
 
AvailableDimensions["Maltese"] = {"Length", "Area", "Volume", 
     "Mass"}
 
AvailableDimensions["MeterTonneSecond"] = 
    {"Length", "Volume", "Mass", "Time", "Force", "Energy", "Power", 
     "Pressure"}
 
AvailableDimensions["MKS"] = {"Length", "Area", "Volume", 
     "Wavenumber", "Mass", "Time", "Frequency", "Velocity", "Force", 
     "Energy", "Power", "Pressure", "Viscosity", "Charge", "Current", 
     "Voltage", "Magnetic Field Strength", "Magnetic Induction", 
     "Magnetic Field Strength", "Magnetic Dipole Moment", "Resistance", 
     "Resistivity", "Capacitance", "Inductance", "Data", "Angle"}
 
AvailableDimensions["Norwegian"] = {"Length", "Area", "Volume", 
     "Mass"}
 
AvailableDimensions["Planck"] = {"Length", "Area", "Volume", 
     "Mass", "Time", "Frequency", "Force", "Energy", "Power", "Pressure", 
     "Charge", "Current", "Voltage", "Resistance"}
 
AvailableDimensions["PrefixedSI"] = 
    {"Length", "Area", "Volume", "Wavenumber", "Mass", "Time", "Frequency", 
     "Velocity", "Force", "Energy", "Power", "Pressure", "Viscosity", 
     "Charge", "Current", "Voltage", "Magnetic Field Strength", 
     "Magnetic Induction", "Magnetic Field Strength", 
     "Magnetic Dipole Moment", "Resistance", "Resistivity", "Capacitance", 
     "Inductance", "Data", "Angle"}
 
AvailableDimensions["Roman"] = {"Length", "Area", "Volume", 
     "Mass"}
 
AvailableDimensions["Russian"] = {"Length", "Area", "Volume", 
     "Mass"}
 
AvailableDimensions["Scottish"] = {"Length", "Area", "Volume", 
     "Mass"}
 
AvailableDimensions["SI"] = {"Length", "Area", "Volume", 
     "Wavenumber", "Mass", "Time", "Frequency", "Velocity", "Force", 
     "Energy", "Power", "Pressure", "Viscosity", "Charge", "Current", 
     "Voltage", "Magnetic Field Strength", "Magnetic Induction", 
     "Magnetic Field Strength", "Magnetic Dipole Moment", "Resistance", 
     "Resistivity", "Capacitance", "Inductance", "Data", "Angle"}
 
AvailableDimensions["Spanish"] = {"Length"}
 
AvailableDimensions["Survey"] = {"Length", "Area"}
 
AvailableDimensions["Swedish"] = {"Length", "Area", "Volume", 
     "Mass"}
 
AvailableDimensions["Taiwanese"] = {"Length", "Area", "Volume", 
     "Mass"}
 
AvailableDimensions["Troy"] = {"Mass"}
 
AvailableDimensions["USCustomary"] = 
    {"Length", "Area", "Volume", "Mass", "Time", "Velocity", "Force", 
     "Energy", "Power", "Pressure", "Angle"}
 
AvailableDimensions[set_] := 
    AvailableDimensions[set] = 
     Select[$Dimensions, 
      Length[DimensionSelect[set, #1]] > 0 & ]
 
$Dimensions = {"Length", "Area", "Volume", "Wavenumber", 
     "Mass", "Time", "Frequency", "Velocity", "Force", "Energy", "Power", 
     "Pressure", "Viscosity", "Charge", "Current", "Voltage", 
     "Magnetic Field Strength", "Magnetic Induction", 
     "Magnetic Field Strength", "Magnetic Dipole Moment", "Resistance", 
     "Resistivity", "Capacitance", "Inductance", "Data", "Angle"}
 
DimensionSelect["All", "Angle"] = {Unit[1, "Radian"], 
     Unit[1, "Steradian"], Unit[1, "ArcSecond"], Unit[1, "ArcMinute"], 
     Unit[1, "Grade"], Unit[1, "Degree"], Unit[1, "DegreeAngle"], 
     Unit[1, "Quadrant"], Unit[1, "RightAngle"], Unit[1, "Circle"], 
     Unit[1, "CircleAngle"]}
 
DimensionSelect["All", "Area"] = {Unit[1, "PlanckArea"], 
     Unit[1, "Barn"], Unit[1, "Kvadratmil"], Unit[1, "PulzierKwadru"], 
     Unit[1, "FitelKwadru"], Unit[1, "ShakuArea"], Unit[1, "XiberKwadru"], 
     Unit[1, "GoArea"], Unit[1, "JoArea"], Unit[1, "Lumin"], 
     Unit[1, "BuArea"], Unit[1, "Tsubo"], Unit[1, "Pyeong"], 
     Unit[1, "Pheng"], Unit[1, "QasbaKwadru"], Unit[1, "KvadratRode"], 
     Unit[1, "Mal"], Unit[1, "Kejla"], Unit[1, "KejlaVolume"], 
     Unit[1, "Tonneland"], Unit[1, "Kannaland"], Unit[1, "Se"], 
     Unit[1, "Bo"], Unit[1, "Are"], Unit[1, "SieghVolume"], 
     Unit[1, "Kappland"], Unit[1, "Ghabara"], Unit[1, "Siegh"], 
     Unit[1, "TanArea"], Unit[1, "Rood"], Unit[1, "Tomna"], 
     Unit[1, "RomanAcre"], Unit[1, "Le"], Unit[1, "Spannland"], 
     Unit[1, "Acre"], Unit[1, "AnthropicAcre"], Unit[1, "SurveyAcre"], 
     Unit[1, "Wejba"], Unit[1, "Kah"], Unit[1, "ChoArea"], 
     Unit[1, "Hectare"], Unit[1, "OfficialDesiatina"], Unit[1, "Modd"], 
     Unit[1, "ModdVolume"], Unit[1, "Oxgang"], 
     Unit[1, "PropriatorsDesiatina"], Unit[1, "Ploughgate"], 
     Unit[1, "Daugh"], Unit[1, "Section"], Unit[1, "Tunnland"], 
     Unit[1, "RomanAuneOfFurrows"], Unit[1, "RomanCenturie"], 
     Unit[1, "RomanMorn"], Unit[1, "RomanQuadriplex"], Unit[1, "RomanRood"], 
     Unit[1, "RomanYoke"], Unit[1, "Township"]}
 
DimensionSelect["All", "Capacitance"] = 
    {Unit[1, "Yoctofarad"], Unit[1, "Zeptofarad"], Unit[1, "Attofarad"], 
     Unit[1, "Femtofarad"], Unit[1, "Picofarad"], Unit[1, "Statfarad"], 
     Unit[1, "Nanofarad"], Unit[1, "Microfarad"], Unit[1, "Millifarad"], 
     Unit[1, "Centifarad"], Unit[1, "Decifarad"], Unit[1, "Farad"], 
     Unit[1, "Decafarad"], Unit[1, "Hectofarad"], Unit[1, "Kilofarad"], 
     Unit[1, "Megafarad"], Unit[1, "Abfarad"], Unit[1, "Gigafarad"], 
     Unit[1, "Terafarad"], Unit[1, "Petafarad"], Unit[1, "Exafarad"], 
     Unit[1, "Zettafarad"], Unit[1, "Yottafarad"]}
 
DimensionSelect["All", "Charge"] = {Unit[1, "Yoctocoulomb"], 
     Unit[1, "Zeptocoulomb"], Unit[1, "ElementaryCharge"], 
     Unit[1, "Attocoulomb"], Unit[1, "PlanckCharge"], 
     Unit[1, "Femtocoulomb"], Unit[1, "Picocoulomb"], Unit[1, "Franklin"], 
     Unit[1, "Statcoulomb"], Unit[1, "Nanocoulomb"], Unit[1, "Microcoulomb"], 
     Unit[1, "Millicoulomb"], Unit[1, "Centicoulomb"], 
     Unit[1, "Decicoulomb"], Unit[1, "Coulomb"], Unit[1, "Abcoulomb"], 
     Unit[1, "Decacoulomb"], Unit[1, "Hectocoulomb"], Unit[1, "Kilocoulomb"], 
     Unit[1, "Megacoulomb"], Unit[1, "Gigacoulomb"], Unit[1, "Teracoulomb"], 
     Unit[1, "Petacoulomb"], Unit[1, "Exacoulomb"], Unit[1, "Zettacoulomb"], 
     Unit[1, "Yottacoulomb"]}
 
DimensionSelect["All", "Current"] = {Unit[1, "Yoctoampere"], 
     Unit[1, "Zeptoampere"], Unit[1, "Attoampere"], Unit[1, "Femtoampere"], 
     Unit[1, "Picoampere"], Unit[1, "Statampere"], Unit[1, "Nanoampere"], 
     Unit[1, "Microampere"], Unit[1, "Milliampere"], Unit[1, "Centiampere"], 
     Unit[1, "Deciampere"], Unit[1, "Amp"], Unit[1, "Ampere"], 
     Unit[1, "Abampere"], Unit[1, "Biot"], Unit[1, "Decaampere"], 
     Unit[1, "Hectoampere"], Unit[1, "Kiloampere"], Unit[1, "Megaampere"], 
     Unit[1, "Gigaampere"], Unit[1, "Teraampere"], Unit[1, "Petaampere"], 
     Unit[1, "Exaampere"], Unit[1, "Zettaampere"], Unit[1, "Yottaampere"], 
     Unit[1, "PlanckCurrent"], Unit[1, "Gilbert"]}
 
DimensionSelect["All", "Data"] = {Unit[1, "Bit"], 
     Unit[1, "Nibble"], Unit[1, "Byte"], Unit[1, "ByteUnit"], 
     Unit[1, "Kibibit"], Unit[1, "Kibibyte"], Unit[1, "Mebibit"], 
     Unit[1, "Mebibyte"], Unit[1, "Gibibit"], Unit[1, "Gibibyte"], 
     Unit[1, "Tebibit"], Unit[1, "Tebibyte"], Unit[1, "Pebibit"], 
     Unit[1, "Pebibyte"], Unit[1, "Exbibit"], Unit[1, "Exbibyte"], 
     Unit[1, "Zebibit"], Unit[1, "Zebibyte"], Unit[1, "Yobibit"], 
     Unit[1, "Yobibyte"]}
 
DimensionSelect["All", "Energy"] = {Unit[1, "Yoctojoule"], 
     Unit[1, "Zeptojoule"], Unit[1, "ElectronVolt"], Unit[1, "Attojoule"], 
     Unit[1, "Rydberg"], Unit[1, "HartreeEnergy"], Unit[1, "Femtojoule"], 
     Unit[1, "Picojoule"], Unit[1, "Nanojoule"], Unit[1, "Erg"], 
     Unit[1, "Microjoule"], Unit[1, "Millijoule"], Unit[1, "Centijoule"], 
     Unit[1, "Decijoule"], Unit[1, "Joule"], Unit[1, "Calorie"], 
     Unit[1, "Decajoule"], Unit[1, "Hectojoule"], Unit[1, "Kilojoule"], 
     Unit[1, "BritishThermalUnit"], Unit[1, "BTU"], Unit[1, "Megajoule"], 
     Unit[1, "Therm"], Unit[1, "Gigajoule"], Unit[1, "PlanckEnergy"], 
     Unit[1, "Terajoule"], Unit[1, "Petajoule"], Unit[1, "Exajoule"], 
     Unit[1, "Zettajoule"], Unit[1, "Yottajoule"]}
 
DimensionSelect["All", "Force"] = {Unit[1, "Yoctonewton"], 
     Unit[1, "Zeptonewton"], Unit[1, "Attonewton"], Unit[1, "Femtonewton"], 
     Unit[1, "Piconewton"], Unit[1, "Nanonewton"], Unit[1, "Micronewton"], 
     Unit[1, "Dyne"], Unit[1, "Millinewton"], Unit[1, "GramWeight"], 
     Unit[1, "Centinewton"], Unit[1, "Decinewton"], Unit[1, "Poundal"], 
     Unit[1, "Newton"], Unit[1, "PoundForce"], Unit[1, "PoundWeight"], 
     Unit[1, "KilogramForce"], Unit[1, "KilogramWeight"], 
     Unit[1, "Decanewton"], Unit[1, "Hectonewton"], Unit[1, "Kilonewton"], 
     Unit[1, "Sthene"], Unit[1, "TonForce"], Unit[1, "Meganewton"], 
     Unit[1, "Giganewton"], Unit[1, "Teranewton"], Unit[1, "Petanewton"], 
     Unit[1, "Exanewton"], Unit[1, "Zettanewton"], Unit[1, "Yottanewton"], 
     Unit[1, "PlanckForce"]}
 
DimensionSelect["All", "Frequency"] = 
    {Unit[1, "Yoctohertz"], Unit[1, "Zeptohertz"], Unit[1, "Attohertz"], 
     Unit[1, "Femtohertz"], Unit[1, "Picohertz"], Unit[1, "Nanohertz"], 
     Unit[1, "Microhertz"], Unit[1, "Millihertz"], Unit[1, "Centihertz"], 
     Unit[1, "Decihertz"], Unit[1, "Becquerel"], Unit[1, "Hertz"], 
     Unit[1, "Decahertz"], Unit[1, "Hectohertz"], Unit[1, "Kilohertz"], 
     Unit[1, "Megahertz"], Unit[1, "Rutherford"], Unit[1, "Gigahertz"], 
     Unit[1, "Curie"], Unit[1, "Terahertz"], Unit[1, "Petahertz"], 
     Unit[1, "Exahertz"], Unit[1, "Zettahertz"], Unit[1, "Yottahertz"], 
     Unit[1, "PlanckAngularFrequency"]}
 
DimensionSelect["All", "Inductance"] = 
    {Unit[1, "Yoctohenry"], Unit[1, "Zeptohenry"], Unit[1, "Attohenry"], 
     Unit[1, "Femtohenry"], Unit[1, "Picohenry"], Unit[1, "Abhenry"], 
     Unit[1, "Nanohenry"], Unit[1, "Microhenry"], Unit[1, "Millihenry"], 
     Unit[1, "Centihenry"], Unit[1, "Decihenry"], Unit[1, "Henry"], 
     Unit[1, "Decahenry"], Unit[1, "Hectohenry"], Unit[1, "Kilohenry"], 
     Unit[1, "Megahenry"], Unit[1, "Gigahenry"], Unit[1, "Stathenry"], 
     Unit[1, "Terahenry"], Unit[1, "Petahenry"], Unit[1, "Exahenry"], 
     Unit[1, "Zettahenry"], Unit[1, "Yottahenry"]}
 
DimensionSelect["All", "Length"] = {Unit[1, "PlanckLength"], 
     Unit[1, "Yoctometer"], Unit[1, "Zeptometer"], Unit[1, "Attometer"], 
     Unit[1, "Femtometer"], Unit[1, "Fermi"], Unit[1, "XUnit"], 
     Unit[1, "Picometer"], Unit[1, "BohrRadius"], Unit[1, "Angstrom"], 
     Unit[1, "Nanometer"], Unit[1, "Micrometer"], Unit[1, "Micron"], 
     Unit[1, "Mo"], Unit[1, "PrintersPoint"], Unit[1, "Fjardingsvag"], 
     Unit[1, "Mil"], Unit[1, "Thou"], Unit[1, "Rin"], Unit[1, "Punto"], 
     Unit[1, "Skrupel"], Unit[1, "Caliber"], Unit[1, "Tochka"], 
     Unit[1, "Bu"], Unit[1, "Point"], Unit[1, "PointLength"], 
     Unit[1, "Didot"], Unit[1, "DidotPoint"], Unit[1, "Millimeter"], 
     Unit[1, "Linea"], Unit[1, "NorwegianLinje"], Unit[1, "Liniya"], 
     Unit[1, "SwedishLinje"], Unit[1, "Sun"], Unit[1, "Pica"], 
     Unit[1, "Cicero"], Unit[1, "Centimeter"], Unit[1, "RomanDigit"], 
     Unit[1, "AnthropicDigit"], Unit[1, "Assba"], Unit[1, "Pulzier"], 
     Unit[1, "Pulgada"], Unit[1, "RomanInch"], Unit[1, "AnthropicInch"], 
     Unit[1, "Diuym"], Unit[1, "Inch"], Unit[1, "Tomme"], Unit[1, "Tum"], 
     Unit[1, "Chhun"], Unit[1, "Shaku"], Unit[1, "Vershok"], 
     Unit[1, "RomanPalm"], Unit[1, "Palm"], Unit[1, "Cabda"], 
     Unit[1, "Decimeter"], Unit[1, "Hand"], Unit[1, "Handbreadth"], 
     Unit[1, "Coto"], Unit[1, "Fitel"], Unit[1, "SwedishKvarter"], 
     Unit[1, "Shaftment"], Unit[1, "NorwegianKvarter"], Unit[1, "Piad"], 
     Unit[1, "Hiro"], Unit[1, "Ken"], Unit[1, "Link"], Unit[1, "Palmo"], 
     Unit[1, "Span"], Unit[1, "SpanLength"], Unit[1, "Xiber"], 
     Unit[1, "SwedishFot"], Unit[1, "Pie"], Unit[1, "RomanFoot"], 
     Unit[1, "Chhioh"], Unit[1, "JoLength"], Unit[1, "Ja"], 
     Unit[1, "AnthropicFoot"], Unit[1, "Feet"], Unit[1, "Foot"], 
     Unit[1, "Fut"], Unit[1, "SurveyFoot"], Unit[1, "NorwegianFot"], 
     Unit[1, "ArabicFoot"], Unit[1, "Tvarhand"], Unit[1, "RomanCubit"], 
     Unit[1, "Cubit"], Unit[1, "Arsh"], Unit[1, "Aln"], Unit[1, "Alen"], 
     Unit[1, "FlemmishEll"], Unit[1, "Arshin"], Unit[1, "RomanStep"], 
     Unit[1, "PolishEll"], Unit[1, "Vara"], Unit[1, "AnthropicYard"], 
     Unit[1, "Yard"], Unit[1, "ScottishEll"], Unit[1, "Meter"], 
     Unit[1, "Ell"], Unit[1, "Paso"], Unit[1, "Pace"], Unit[1, "RomanPace"], 
     Unit[1, "Famn"], Unit[1, "Fathom"], Unit[1, "Favn"], Unit[1, "Orgye"], 
     Unit[1, "Qasba"], Unit[1, "Sazhen"], Unit[1, "RomanPerch"], 
     Unit[1, "NorwegianStang"], Unit[1, "Qasab"], Unit[1, "SwedishStang"], 
     Unit[1, "Perch"], Unit[1, "Pole"], Unit[1, "Rod"], Unit[1, "Fall"], 
     Unit[1, "Rope"], Unit[1, "Decameter"], Unit[1, "ChoLength"], 
     Unit[1, "Chain"], Unit[1, "Ref"], Unit[1, "Las"], 
     Unit[1, "RomanArpent"], Unit[1, "Bolt"], Unit[1, "Stenkast"], 
     Unit[1, "Hectometer"], Unit[1, "Skein"], Unit[1, "Stadium"], 
     Unit[1, "Kabellangd"], Unit[1, "RomanStadium"], Unit[1, "Kabellengde"], 
     Unit[1, "Stadion"], Unit[1, "Seir"], Unit[1, "Furlong"], 
     Unit[1, "Cable"], Unit[1, "Ghalva"], Unit[1, "ReLength"], 
     Unit[1, "Kilometer"], Unit[1, "Versta"], Unit[1, "AnthropicMile"], 
     Unit[1, "RomanMile"], Unit[1, "Mile"], Unit[1, "StatuteMile"], 
     Unit[1, "SurveyMile"], Unit[1, "ScottishMile"], Unit[1, "NauticalMile"], 
     Unit[1, "SwedishKvartmil"], Unit[1, "NorwegianKvartmil"], 
     Unit[1, "RomanLeague"], Unit[1, "Fjerdingsvei"], Unit[1, "Legua"], 
     Unit[1, "AnthropicLeague"], Unit[1, "League"], 
     Unit[1, "ArgentinianLeague"], Unit[1, "BrazillianLeague"], 
     Unit[1, "Skogsmil"], Unit[1, "Farasakh"], Unit[1, "SwedishSjomil"], 
     Unit[1, "Geografiskmil"], Unit[1, "NorwegianSjomil"], Unit[1, "Milia"], 
     Unit[1, "Nymil"], Unit[1, "SwedishMil"], Unit[1, "NorwegianMil"], 
     Unit[1, "Kyndemil"], Unit[1, "Barid"], Unit[1, "Marhala"], 
     Unit[1, "Labor"], Unit[1, "Megameter"], Unit[1, "EarthRadius"], 
     Unit[1, "LunarDistance"], Unit[1, "Gigameter"], 
     Unit[1, "AstronomicalUnit"], Unit[1, "AU"], Unit[1, "Terameter"], 
     Unit[1, "Petameter"], Unit[1, "LightYear"], Unit[1, "Parsec"], 
     Unit[1, "Exameter"], Unit[1, "Zettameter"], Unit[1, "Yottameter"]}
 
DimensionSelect["All", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["All", "Magnetic Field Strength"] = {}
 
DimensionSelect["All", "Magnetic Induction"] = 
    {Unit[1, "Yoctotesla"], Unit[1, "Zeptotesla"], Unit[1, "Attotesla"], 
     Unit[1, "Femtotesla"], Unit[1, "Picotesla"], Unit[1, "Gamma"], 
     Unit[1, "GammaMagnetism"], Unit[1, "Nanotesla"], Unit[1, "Microtesla"], 
     Unit[1, "Gauss"], Unit[1, "Millitesla"], Unit[1, "Centitesla"], 
     Unit[1, "Decitesla"], Unit[1, "Tesla"], Unit[1, "Decatesla"], 
     Unit[1, "Hectotesla"], Unit[1, "Kilotesla"], Unit[1, "Megatesla"], 
     Unit[1, "Gigatesla"], Unit[1, "Teratesla"], Unit[1, "Petatesla"], 
     Unit[1, "Exatesla"], Unit[1, "Zettatesla"], Unit[1, "Yottatesla"]}
 
DimensionSelect["All", "Mass"] = {Unit[1, "ElectronRestMass"], 
     Unit[1, "AMU"], Unit[1, "AtomicMassUnit"], Unit[1, "Dalton"], 
     Unit[1, "PlanckMass"], Unit[1, "Cash"], Unit[1, "Dolia"], 
     Unit[1, "Grain"], Unit[1, "RomanChalcus"], Unit[1, "RomanSiliqua"], 
     Unit[1, "Carat"], Unit[1, "Candareen"], Unit[1, "Fun"], 
     Unit[1, "RomanObolus"], Unit[1, "Obolos"], Unit[1, "NorwegianOrt"], 
     Unit[1, "Gram"], Unit[1, "RomanScruple"], Unit[1, "Pennyweight"], 
     Unit[1, "Dram"], Unit[1, "RomanDram"], Unit[1, "Mace"], 
     Unit[1, "Momme"], Unit[1, "SwedishOrt"], Unit[1, "Zolotnik"], 
     Unit[1, "Drachma"], Unit[1, "RomanShekel"], Unit[1, "Lot"], 
     Unit[1, "Shekel"], Unit[1, "Uqija"], Unit[1, "MaltaAwqiyyah"], 
     Unit[1, "RomanOunce"], Unit[1, "AvoirdupoisOunce"], Unit[1, "Ounce"], 
     Unit[1, "AssayTon"], Unit[1, "TroyOunce"], Unit[1, "EgyptianAwqiyyah"], 
     Unit[1, "Tael"], Unit[1, "Kwart"], Unit[1, "Mark"], 
     Unit[1, "BeirutAwqiyyah"], Unit[1, "JerusalemAwqiyyah"], 
     Unit[1, "Merke"], Unit[1, "Aleppowqiyyah"], Unit[1, "Pondus"], 
     Unit[1, "Libra"], Unit[1, "RomanPound"], Unit[1, "TroyPound"], 
     Unit[1, "Hyakume"], Unit[1, "Funt"], Unit[1, "Skalpund"], 
     Unit[1, "Mina"], Unit[1, "RomanMine"], Unit[1, "AvoirdupoisPound"], 
     Unit[1, "Pound"], Unit[1, "Pund"], Unit[1, "Catty"], Unit[1, "Kin"], 
     Unit[1, "Kati"], Unit[1, "Ratal"], Unit[1, "Qsima"], 
     Unit[1, "Kilogram"], Unit[1, "Kan"], Unit[1, "Kanme"], Unit[1, "Wizna"], 
     Unit[1, "SwedishBismerpund"], Unit[1, "Stone"], 
     Unit[1, "NorwegianBismerpund"], Unit[1, "Lispund"], Unit[1, "Geepound"], 
     Unit[1, "Slug"], Unit[1, "Pood"], Unit[1, "Laup"], Unit[1, "Spann"], 
     Unit[1, "Vag"], Unit[1, "Talent"], Unit[1, "Cental"], 
     Unit[1, "NetHundredweight"], Unit[1, "ShortHundredweight"], 
     Unit[1, "GrossHundredweight"], Unit[1, "Hundredweight"], 
     Unit[1, "Picul"], Unit[1, "Pikul"], Unit[1, "Qantar"], 
     Unit[1, "Quintal"], Unit[1, "Wey"], Unit[1, "Skippund"], 
     Unit[1, "Berkovets"], Unit[1, "Skeppspund"], Unit[1, "Bale"], 
     Unit[1, "Pezata"], Unit[1, "ShortTon"], Unit[1, "Ton"], 
     Unit[1, "MetricTon"], Unit[1, "Tonne"], Unit[1, "LongTon"], 
     Unit[1, "EarthMass"], Unit[1, "JupiterMass"], Unit[1, "SolarMass"]}
 
DimensionSelect["All", "Power"] = {Unit[1, "Yoctowatt"], 
     Unit[1, "Zeptowatt"], Unit[1, "Attowatt"], Unit[1, "Femtowatt"], 
     Unit[1, "Picowatt"], Unit[1, "Nanowatt"], Unit[1, "Microwatt"], 
     Unit[1, "Milliwatt"], Unit[1, "Centiwatt"], Unit[1, "Deciwatt"], 
     Unit[1, "Watt"], Unit[1, "Decawatt"], Unit[1, "Hectowatt"], 
     Unit[1, "ChevalVapeur"], Unit[1, "Horsepower"], Unit[1, "Kilowatt"], 
     Unit[1, "Megawatt"], Unit[1, "Gigawatt"], Unit[1, "Terawatt"], 
     Unit[1, "Petawatt"], Unit[1, "Exawatt"], Unit[1, "Zettawatt"], 
     Unit[1, "Yottawatt"], Unit[1, "PlanckPower"]}
 
DimensionSelect["All", "Pressure"] = 
    {Unit[1, "Yoctopascal"], Unit[1, "Zeptopascal"], Unit[1, "Attopascal"], 
     Unit[1, "Femtopascal"], Unit[1, "Picopascal"], Unit[1, "Nanopascal"], 
     Unit[1, "Micropascal"], Unit[1, "Millipascal"], Unit[1, "Centipascal"], 
     Unit[1, "Barye"], Unit[1, "Decipascal"], Unit[1, "Pascal"], 
     Unit[1, "Decapascal"], Unit[1, "Hectopascal"], 
     Unit[1, "MillimeterMercury"], Unit[1, "Torr"], Unit[1, "Kilopascal"], 
     Unit[1, "Pieze"], Unit[1, "InchMercury"], 
     Unit[1, "PoundsPerSquareInch"], Unit[1, "PSI"], 
     Unit[1, "TechnicalAtmosphere"], Unit[1, "Bar"], Unit[1, "Atmosphere"], 
     Unit[1, "Megapascal"], Unit[1, "Gigapascal"], Unit[1, "Terapascal"], 
     Unit[1, "Petapascal"], Unit[1, "Exapascal"], Unit[1, "Zettapascal"], 
     Unit[1, "Yottapascal"], Unit[1, "PlanckPressure"]}
 
DimensionSelect["All", "Resistance"] = 
    {Unit[1, "Yoctoohm"], Unit[1, "Zeptoohm"], Unit[1, "Attoohm"], 
     Unit[1, "Femtoohm"], Unit[1, "Picoohm"], Unit[1, "Abohm"], 
     Unit[1, "Nanoohm"], Unit[1, "Microohm"], Unit[1, "Milliohm"], 
     Unit[1, "Centiohm"], Unit[1, "Deciohm"], Unit[1, "Ohm"], 
     Unit[1, "Decaohm"], Unit[1, "PlanckImpedence"], Unit[1, "Hectoohm"], 
     Unit[1, "Kiloohm"], Unit[1, "Megaohm"], Unit[1, "Gigaohm"], 
     Unit[1, "Statohm"], Unit[1, "Teraohm"], Unit[1, "Petaohm"], 
     Unit[1, "Exaohm"], Unit[1, "Zettaohm"], Unit[1, "Yottaohm"]}
 
DimensionSelect["All", "Resistivity"] = {}
 
DimensionSelect["All", "Time"] = {Unit[1, "PlanckTime"], 
     Unit[1, "Yoctosecond"], Unit[1, "Zeptosecond"], Unit[1, "Attosecond"], 
     Unit[1, "Femtosecond"], Unit[1, "Picosecond"], Unit[1, "Nanosecond"], 
     Unit[1, "Microsecond"], Unit[1, "Millisecond"], Unit[1, "Centisecond"], 
     Unit[1, "Decisecond"], Unit[1, "SiderealSecond"], Unit[1, "Second"], 
     Unit[1, "Decasecond"], Unit[1, "Minute"], Unit[1, "Hectosecond"], 
     Unit[1, "Kilosecond"], Unit[1, "Hour"], Unit[1, "Day"], Unit[1, "Week"], 
     Unit[1, "Megasecond"], Unit[1, "Fortnight"], Unit[1, "Month"], 
     Unit[1, "Year"], Unit[1, "TropicalYear"], Unit[1, "JulianYear"], 
     Unit[1, "SiderealYear"], Unit[1, "Decade"], Unit[1, "Gigasecond"], 
     Unit[1, "Century"], Unit[1, "JulianCentury"], Unit[1, "Millennium"], 
     Unit[1, "Terasecond"], Unit[1, "Petasecond"], Unit[1, "Exasecond"], 
     Unit[1, "Zettasecond"], Unit[1, "Yottasecond"]}
 
DimensionSelect["All", "Velocity"] = {Unit[1, "Knot"]}
 
DimensionSelect["All", "Viscosity"] = 
    {Unit[1, "Poise"], Unit[1, "Reyn"]}
 
DimensionSelect["All", "Voltage"] = {Unit[1, "Yoctovolt"], 
     Unit[1, "Zeptovolt"], Unit[1, "Attovolt"], Unit[1, "Femtovolt"], 
     Unit[1, "Picovolt"], Unit[1, "Nanovolt"], Unit[1, "Abvolt"], 
     Unit[1, "Microvolt"], Unit[1, "Millivolt"], Unit[1, "Centivolt"], 
     Unit[1, "Decivolt"], Unit[1, "Volt"], Unit[1, "Decavolt"], 
     Unit[1, "Hectovolt"], Unit[1, "Statvolt"], Unit[1, "Kilovolt"], 
     Unit[1, "Megavolt"], Unit[1, "Gigavolt"], Unit[1, "Teravolt"], 
     Unit[1, "Petavolt"], Unit[1, "Exavolt"], Unit[1, "Zettavolt"], 
     Unit[1, "Yottavolt"], Unit[1, "PlanckVoltage"]}
 
DimensionSelect["All", "Volume"] = {Unit[1, "PlanckVolume"], 
     Unit[1, "Drop"], Unit[1, "DropVolume"], Unit[1, "Minim"], 
     Unit[1, "Sai"], Unit[1, "FluidDram"], Unit[1, "Teaspoon"], 
     Unit[1, "PulzierKubu"], Unit[1, "RomanSpoonful"], Unit[1, "Tablespoon"], 
     Unit[1, "ShakuVolume"], Unit[1, "Pony"], Unit[1, "ImperialFluidOunce"], 
     Unit[1, "FluidOunce"], Unit[1, "Shot"], Unit[1, "Kwartin"], 
     Unit[1, "Jigger"], Unit[1, "RomanDose"], Unit[1, "Shkalik"], 
     Unit[1, "RomanDrawingSpoon"], Unit[1, "RomanSixthSester"], 
     Unit[1, "Chast"], Unit[1, "Gill"], Unit[1, "Noggin"], Unit[1, "USGill"], 
     Unit[1, "Charka"], Unit[1, "KejlaMilk"], Unit[1, "RomanQuarterSpoon"], 
     Unit[1, "ImperialGill"], Unit[1, "Pinta"], Unit[1, "GoVolume"], 
     Unit[1, "RomanThirdSester"], Unit[1, "Cup"], Unit[1, "USCup"], 
     Unit[1, "RomanDryHalfSester"], Unit[1, "RomanHalfSester"], 
     Unit[1, "Chentong"], Unit[1, "Terz"], Unit[1, "TerzMilk"], 
     Unit[1, "RomanDoubleThirdSester"], Unit[1, "Mutchkins"], 
     Unit[1, "Pint"], Unit[1, "RomanDrySester"], Unit[1, "RomanSester"], 
     Unit[1, "DryPint"], Unit[1, "UKPint"], Unit[1, "ImperialPint"], 
     Unit[1, "Leng"], Unit[1, "Nofs"], Unit[1, "ButylkaVodochnaya"], 
     Unit[1, "NofsMilk"], Unit[1, "MetricWineBottle"], Unit[1, "Fifth"], 
     Unit[1, "WineBottle"], Unit[1, "ButylkaVinnaya"], Unit[1, "Chopin"], 
     Unit[1, "Quart"], Unit[1, "Pot"], Unit[1, "Liter"], Unit[1, "DryQuart"], 
     Unit[1, "Chupak"], Unit[1, "ImperialQuart"], Unit[1, "Kartocc"], 
     Unit[1, "LiquidKruzhka"], Unit[1, "KartoccMilk"], Unit[1, "DryKruzhka"], 
     Unit[1, "LiquidChetvert"], Unit[1, "ScottishPint"], Unit[1, "Sho"], 
     Unit[1, "FitelKubu"], Unit[1, "BoardFoot"], Unit[1, "RomanCongius"], 
     Unit[1, "Garnets"], Unit[1, "Gallon"], Unit[1, "Skjeppe"], 
     Unit[1, "Omer"], Unit[1, "RomanGallon"], Unit[1, "DryGallon"], 
     Unit[1, "Gantang"], Unit[1, "ImperialGallon"], Unit[1, "UKGallon"], 
     Unit[1, "KwartaMilk"], Unit[1, "Kwarta"], Unit[1, "Qafiz"], 
     Unit[1, "RomanPeck"], Unit[1, "Peck"], Unit[1, "Garra"], 
     Unit[1, "LiquidVedro"], Unit[1, "RomanUrn"], Unit[1, "DryVedro"], 
     Unit[1, "ScottishGallon"], Unit[1, "Bucket"], Unit[1, "Cafiso"], 
     Unit[1, "XibeKubu"], Unit[1, "To"], Unit[1, "TomnaVolume"], 
     Unit[1, "MalteseQafiz"], Unit[1, "RomanBushel"], Unit[1, "RomanJar"], 
     Unit[1, "Chetverik"], Unit[1, "NorwegianTonne"], Unit[1, "Bushel"], 
     Unit[1, "Ankare"], Unit[1, "Ephah"], Unit[1, "Firkin"], 
     Unit[1, "Barmil"], Unit[1, "Osmina"], Unit[1, "Bag"], 
     Unit[1, "DryBarrel"], Unit[1, "Barrel"], Unit[1, "SwedishOhm"], 
     Unit[1, "OilBarrel"], Unit[1, "Koku"], Unit[1, "DryChetvert"], 
     Unit[1, "Hogshead"], Unit[1, "Seam"], Unit[1, "Puncheon"], 
     Unit[1, "Butt"], Unit[1, "Bochka"], Unit[1, "RomanHose"], 
     Unit[1, "Tun"], Unit[1, "Stere"], Unit[1, "FavnVolume"], 
     Unit[1, "RegisterTon"], Unit[1, "Last"], Unit[1, "LastVolume"], 
     Unit[1, "Cord"], Unit[1, "Storfavn"], Unit[1, "Kubikkfavn"], 
     Unit[1, "QasbaKubu"]}
 
DimensionSelect["All", "Wavenumber"] = 
    {Unit[1, "Diopter"], Unit[1, "Kayser"]}
 
DimensionSelect["Alternative", "Angle"] = 
    {Unit[1, "Steradian"], Unit[1, "ArcSecond"], Unit[1, "ArcMinute"], 
     Unit[1, "Grade"], Unit[1, "Quadrant"], Unit[1, "RightAngle"], 
     Unit[1, "Circle"]}
 
DimensionSelect["Alternative", "Area"] = 
    {Unit[1, "Barn"], Unit[1, "Are"], Unit[1, "Hectare"]}
 
DimensionSelect["Alternative", "Capacitance"] = 
    {Unit[1, "Statfarad"]}
 
DimensionSelect["Alternative", "Charge"] = 
    {Unit[1, "Statcoulomb"]}
 
DimensionSelect["Alternative", "Current"] = 
    {Unit[1, "Statampere"], Unit[1, "Amp"], Unit[1, "Biot"], 
     Unit[1, "Gilbert"]}
 
DimensionSelect["Alternative", "Data"] = 
    {Unit[1, "Nibble"], Unit[1, "Byte"]}
 
DimensionSelect["Alternative", "Energy"] = 
    {Unit[1, "ElectronVolt"], Unit[1, "Rydberg"], Unit[1, "Therm"]}
 
DimensionSelect["Alternative", "Force"] = 
    {Unit[1, "GramWeight"], Unit[1, "Poundal"], Unit[1, "PoundWeight"], 
     Unit[1, "KilogramForce"], Unit[1, "KilogramWeight"], Unit[1, "TonForce"]}
 
DimensionSelect["Alternative", "Frequency"] = 
    {Unit[1, "Becquerel"], Unit[1, "Rutherford"], Unit[1, "Curie"]}
 
DimensionSelect["Alternative", "Inductance"] = 
    {Unit[1, "Stathenry"]}
 
DimensionSelect["Alternative", "Length"] = 
    {Unit[1, "Fermi"], Unit[1, "XUnit"], Unit[1, "Angstrom"], 
     Unit[1, "Micron"], Unit[1, "PrintersPoint"], Unit[1, "Mil"], 
     Unit[1, "Caliber"], Unit[1, "Point"], Unit[1, "Didot"], 
     Unit[1, "DidotPoint"], Unit[1, "Pica"], Unit[1, "Cicero"], 
     Unit[1, "Span"], Unit[1, "Cubit"], Unit[1, "Ell"], Unit[1, "Rope"], 
     Unit[1, "Bolt"], Unit[1, "Skein"], Unit[1, "Stadium"], 
     Unit[1, "Stadion"]}
 
DimensionSelect["Alternative", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Alternative", "Magnetic Field Strength"] = {}
 
DimensionSelect["Alternative", "Magnetic Induction"] = 
    {Unit[1, "Gamma"]}
 
DimensionSelect["Alternative", "Mass"] = 
    {Unit[1, "AtomicMassUnit"], Unit[1, "Carat"], Unit[1, "Obolos"], 
     Unit[1, "Drachma"], Unit[1, "Shekel"], Unit[1, "AssayTon"], 
     Unit[1, "Pondus"], Unit[1, "Libra"], Unit[1, "Mina"], 
     Unit[1, "Geepound"], Unit[1, "Slug"], Unit[1, "Talent"], 
     Unit[1, "Cental"], Unit[1, "NetHundredweight"], Unit[1, "Quintal"], 
     Unit[1, "Wey"], Unit[1, "Bale"]}
 
DimensionSelect["Alternative", "Power"] = 
    {Unit[1, "ChevalVapeur"]}
 
DimensionSelect["Alternative", "Pressure"] = 
    {Unit[1, "MillimeterMercury"], Unit[1, "Torr"], Unit[1, "InchMercury"], 
     Unit[1, "PoundsPerSquareInch"], Unit[1, "TechnicalAtmosphere"], 
     Unit[1, "Bar"], Unit[1, "Atmosphere"]}
 
DimensionSelect["Alternative", "Resistance"] = 
    {Unit[1, "Statohm"]}
 
DimensionSelect["Alternative", "Resistivity"] = {}
 
DimensionSelect["Alternative", "Time"] = 
    {Unit[1, "SiderealSecond"], Unit[1, "Fortnight"], 
     Unit[1, "TropicalYear"], Unit[1, "SiderealYear"], Unit[1, "Decade"], 
     Unit[1, "Century"], Unit[1, "Millennium"]}
 
DimensionSelect["Alternative", "Velocity"] = {Unit[1, "Knot"]}
 
DimensionSelect["Alternative", "Viscosity"] = {Unit[1, "Reyn"]}
 
DimensionSelect["Alternative", "Voltage"] = 
    {Unit[1, "Statvolt"]}
 
DimensionSelect["Alternative", "Volume"] = 
    {Unit[1, "Drop"], Unit[1, "Pony"], Unit[1, "Shot"], Unit[1, "Fifth"], 
     Unit[1, "WineBottle"], Unit[1, "Liter"], Unit[1, "Omer"], 
     Unit[1, "Bucket"], Unit[1, "Ephah"], Unit[1, "Firkin"], Unit[1, "Bag"], 
     Unit[1, "Seam"], Unit[1, "Puncheon"], Unit[1, "Butt"], Unit[1, "Tun"], 
     Unit[1, "RegisterTon"], Unit[1, "Last"], Unit[1, "Cord"]}
 
DimensionSelect["Alternative", "Wavenumber"] = 
    {Unit[1, "Diopter"]}
 
DimensionSelect["AlternativeNames", "Angle"] = 
    {Unit[1, "DegreeAngle"], Unit[1, "CircleAngle"]}
 
DimensionSelect["AlternativeNames", "Area"] = {}
 
DimensionSelect["AlternativeNames", "Capacitance"] = {}
 
DimensionSelect["AlternativeNames", "Charge"] = 
    {Unit[1, "Franklin"]}
 
DimensionSelect["AlternativeNames", "Current"] = {}
 
DimensionSelect["AlternativeNames", "Data"] = 
    {Unit[1, "ByteUnit"]}
 
DimensionSelect["AlternativeNames", "Energy"] = {Unit[1, "BTU"]}
 
DimensionSelect["AlternativeNames", "Force"] = {}
 
DimensionSelect["AlternativeNames", "Frequency"] = {}
 
DimensionSelect["AlternativeNames", "Inductance"] = {}
 
DimensionSelect["AlternativeNames", "Length"] = 
    {Unit[1, "PointLength"], Unit[1, "SpanLength"], Unit[1, "Feet"], 
     Unit[1, "StatuteMile"]}
 
DimensionSelect["AlternativeNames", "Magnetic Dipole Moment"] = 
    {}
 
DimensionSelect["AlternativeNames", 
     "Magnetic Field Strength"] = {}
 
DimensionSelect["AlternativeNames", "Magnetic Induction"] = 
    {Unit[1, "GammaMagnetism"]}
 
DimensionSelect["AlternativeNames", "Mass"] = 
    {Unit[1, "AMU"], Unit[1, "Dalton"], Unit[1, "AvoirdupoisOunce"], 
     Unit[1, "AvoirdupoisPound"], Unit[1, "GrossHundredweight"], 
     Unit[1, "Ton"]}
 
DimensionSelect["AlternativeNames", "Power"] = {}
 
DimensionSelect["AlternativeNames", "Pressure"] = {}
 
DimensionSelect["AlternativeNames", "Resistance"] = {}
 
DimensionSelect["AlternativeNames", "Resistivity"] = {}
 
DimensionSelect["AlternativeNames", "Time"] = {}
 
DimensionSelect["AlternativeNames", "Velocity"] = {}
 
DimensionSelect["AlternativeNames", "Viscosity"] = {}
 
DimensionSelect["AlternativeNames", "Voltage"] = {}
 
DimensionSelect["AlternativeNames", "Volume"] = 
    {Unit[1, "DropVolume"], Unit[1, "Gill"], Unit[1, "Noggin"], 
     Unit[1, "Cup"], Unit[1, "UKPint"], Unit[1, "UKGallon"], 
     Unit[1, "LastVolume"]}
 
DimensionSelect["AlternativeNames", "Wavenumber"] = {}
 
DimensionSelect["Anthropic", "Angle"] = {}
 
DimensionSelect["Anthropic", "Area"] = 
    {Unit[1, "AnthropicAcre"]}
 
DimensionSelect["Anthropic", "Capacitance"] = {}
 
DimensionSelect["Anthropic", "Charge"] = {}
 
DimensionSelect["Anthropic", "Current"] = {}
 
DimensionSelect["Anthropic", "Data"] = {}
 
DimensionSelect["Anthropic", "Energy"] = {}
 
DimensionSelect["Anthropic", "Force"] = {}
 
DimensionSelect["Anthropic", "Frequency"] = {}
 
DimensionSelect["Anthropic", "Inductance"] = {}
 
DimensionSelect["Anthropic", "Length"] = 
    {Unit[1, "AnthropicDigit"], Unit[1, "AnthropicInch"], Unit[1, "Palm"], 
     Unit[1, "Hand"], Unit[1, "Handbreadth"], Unit[1, "Shaftment"], 
     Unit[1, "Span"], Unit[1, "AnthropicFoot"], Unit[1, "Cubit"], 
     Unit[1, "AnthropicYard"], Unit[1, "Ell"], Unit[1, "Pace"], 
     Unit[1, "Fathom"], Unit[1, "Rod"], Unit[1, "Furlong"], 
     Unit[1, "AnthropicMile"], Unit[1, "AnthropicLeague"]}
 
DimensionSelect["Anthropic", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Anthropic", "Magnetic Field Strength"] = {}
 
DimensionSelect["Anthropic", "Magnetic Induction"] = {}
 
DimensionSelect["Anthropic", "Mass"] = {}
 
DimensionSelect["Anthropic", "Power"] = {}
 
DimensionSelect["Anthropic", "Pressure"] = {}
 
DimensionSelect["Anthropic", "Resistance"] = {}
 
DimensionSelect["Anthropic", "Resistivity"] = {}
 
DimensionSelect["Anthropic", "Time"] = {}
 
DimensionSelect["Anthropic", "Velocity"] = {}
 
DimensionSelect["Anthropic", "Viscosity"] = {}
 
DimensionSelect["Anthropic", "Voltage"] = {}
 
DimensionSelect["Anthropic", "Volume"] = {}
 
DimensionSelect["Anthropic", "Wavenumber"] = {}
 
DimensionSelect["Arabic", "Angle"] = {}
 
DimensionSelect["Arabic", "Area"] = {}
 
DimensionSelect["Arabic", "Capacitance"] = {}
 
DimensionSelect["Arabic", "Charge"] = {}
 
DimensionSelect["Arabic", "Current"] = {}
 
DimensionSelect["Arabic", "Data"] = {}
 
DimensionSelect["Arabic", "Energy"] = {}
 
DimensionSelect["Arabic", "Force"] = {}
 
DimensionSelect["Arabic", "Frequency"] = {}
 
DimensionSelect["Arabic", "Inductance"] = {}
 
DimensionSelect["Arabic", "Length"] = 
    {Unit[1, "Assba"], Unit[1, "Cabda"], Unit[1, "ArabicFoot"], 
     Unit[1, "Arsh"], Unit[1, "Orgye"], Unit[1, "Qasab"], Unit[1, "Seir"], 
     Unit[1, "Ghalva"], Unit[1, "Farasakh"], Unit[1, "Barid"], 
     Unit[1, "Marhala"]}
 
DimensionSelect["Arabic", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Arabic", "Magnetic Field Strength"] = {}
 
DimensionSelect["Arabic", "Magnetic Induction"] = {}
 
DimensionSelect["Arabic", "Mass"] = {Unit[1, "MaltaAwqiyyah"], 
     Unit[1, "EgyptianAwqiyyah"], Unit[1, "BeirutAwqiyyah"], 
     Unit[1, "JerusalemAwqiyyah"], Unit[1, "Aleppowqiyyah"]}
 
DimensionSelect["Arabic", "Power"] = {}
 
DimensionSelect["Arabic", "Pressure"] = {}
 
DimensionSelect["Arabic", "Resistance"] = {}
 
DimensionSelect["Arabic", "Resistivity"] = {}
 
DimensionSelect["Arabic", "Time"] = {}
 
DimensionSelect["Arabic", "Velocity"] = {}
 
DimensionSelect["Arabic", "Viscosity"] = {}
 
DimensionSelect["Arabic", "Voltage"] = {}
 
DimensionSelect["Arabic", "Volume"] = 
    {Unit[1, "Qafiz"], Unit[1, "Cafiso"]}
 
DimensionSelect["Arabic", "Wavenumber"] = {}
 
DimensionSelect["Astronomical", "Angle"] = {}
 
DimensionSelect["Astronomical", "Area"] = {}
 
DimensionSelect["Astronomical", "Capacitance"] = {}
 
DimensionSelect["Astronomical", "Charge"] = {}
 
DimensionSelect["Astronomical", "Current"] = {}
 
DimensionSelect["Astronomical", "Data"] = {}
 
DimensionSelect["Astronomical", "Energy"] = {}
 
DimensionSelect["Astronomical", "Force"] = {}
 
DimensionSelect["Astronomical", "Frequency"] = {}
 
DimensionSelect["Astronomical", "Inductance"] = {}
 
DimensionSelect["Astronomical", "Length"] = 
    {Unit[1, "EarthRadius"], Unit[1, "LunarDistance"], 
     Unit[1, "AstronomicalUnit"], Unit[1, "AU"], Unit[1, "LightYear"], 
     Unit[1, "Parsec"]}
 
DimensionSelect["Astronomical", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Astronomical", "Magnetic Field Strength"] = {}
 
DimensionSelect["Astronomical", "Magnetic Induction"] = {}
 
DimensionSelect["Astronomical", "Mass"] = 
    {Unit[1, "EarthMass"], Unit[1, "JupiterMass"], Unit[1, "SolarMass"]}
 
DimensionSelect["Astronomical", "Power"] = {}
 
DimensionSelect["Astronomical", "Pressure"] = {}
 
DimensionSelect["Astronomical", "Resistance"] = {}
 
DimensionSelect["Astronomical", "Resistivity"] = {}
 
DimensionSelect["Astronomical", "Time"] = 
    {Unit[1, "Day"], Unit[1, "JulianYear"], Unit[1, "JulianCentury"]}
 
DimensionSelect["Astronomical", "Velocity"] = {}
 
DimensionSelect["Astronomical", "Viscosity"] = {}
 
DimensionSelect["Astronomical", "Voltage"] = {}
 
DimensionSelect["Astronomical", "Volume"] = {}
 
DimensionSelect["Astronomical", "Wavenumber"] = {}
 
DimensionSelect["Atomic", "Angle"] = {}
 
DimensionSelect["Atomic", "Area"] = {}
 
DimensionSelect["Atomic", "Capacitance"] = {}
 
DimensionSelect["Atomic", "Charge"] = 
    {Unit[1, "ElementaryCharge"]}
 
DimensionSelect["Atomic", "Current"] = {}
 
DimensionSelect["Atomic", "Data"] = {}
 
DimensionSelect["Atomic", "Energy"] = {Unit[1, "HartreeEnergy"]}
 
DimensionSelect["Atomic", "Force"] = 
    {Unit[1, "HartreeEnergy"/"BohrRadius"]}
 
DimensionSelect["Atomic", "Frequency"] = {}
 
DimensionSelect["Atomic", "Inductance"] = {}
 
DimensionSelect["Atomic", "Length"] = {Unit[1, "BohrRadius"]}
 
DimensionSelect["Atomic", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Atomic", "Magnetic Field Strength"] = {}
 
DimensionSelect["Atomic", "Magnetic Induction"] = {}
 
DimensionSelect["Atomic", "Mass"] = 
    {Unit[1, "ElectronRestMass"]}
 
DimensionSelect["Atomic", "Power"] = {}
 
DimensionSelect["Atomic", "Pressure"] = 
    {Unit[1, "HartreeEnergy"/"BohrRadius"^3]}
 
DimensionSelect["Atomic", "Resistance"] = {}
 
DimensionSelect["Atomic", "Resistivity"] = {}
 
DimensionSelect["Atomic", "Time"] = 
    {Unit[1, "ReducedPlanckConstant"/"HartreeEnergy"]}
 
DimensionSelect["Atomic", "Velocity"] = 
    {Unit[1, ("BohrRadius"*"HartreeEnergy")/"ReducedPlanckConstant"]}
 
DimensionSelect["Atomic", "Viscosity"] = {}
 
DimensionSelect["Atomic", "Voltage"] = {}
 
DimensionSelect["Atomic", "Volume"] = {}
 
DimensionSelect["Atomic", "Wavenumber"] = {}
 
DimensionSelect["Avoirdupois", "Angle"] = {}
 
DimensionSelect["Avoirdupois", "Area"] = {}
 
DimensionSelect["Avoirdupois", "Capacitance"] = {}
 
DimensionSelect["Avoirdupois", "Charge"] = {}
 
DimensionSelect["Avoirdupois", "Current"] = {}
 
DimensionSelect["Avoirdupois", "Data"] = {}
 
DimensionSelect["Avoirdupois", "Energy"] = {}
 
DimensionSelect["Avoirdupois", "Force"] = {}
 
DimensionSelect["Avoirdupois", "Frequency"] = {}
 
DimensionSelect["Avoirdupois", "Inductance"] = {}
 
DimensionSelect["Avoirdupois", "Length"] = {}
 
DimensionSelect["Avoirdupois", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Avoirdupois", "Magnetic Field Strength"] = {}
 
DimensionSelect["Avoirdupois", "Magnetic Induction"] = {}
 
DimensionSelect["Avoirdupois", "Mass"] = 
    {Unit[1, "Grain"], Unit[1, "Dram"], Unit[1, "Ounce"], Unit[1, "Pound"], 
     Unit[1, "ShortHundredweight"], Unit[1, "ShortTon"]}
 
DimensionSelect["Avoirdupois", "Power"] = {}
 
DimensionSelect["Avoirdupois", "Pressure"] = {}
 
DimensionSelect["Avoirdupois", "Resistance"] = {}
 
DimensionSelect["Avoirdupois", "Resistivity"] = {}
 
DimensionSelect["Avoirdupois", "Time"] = {}
 
DimensionSelect["Avoirdupois", "Velocity"] = {}
 
DimensionSelect["Avoirdupois", "Viscosity"] = {}
 
DimensionSelect["Avoirdupois", "Voltage"] = {}
 
DimensionSelect["Avoirdupois", "Volume"] = {}
 
DimensionSelect["Avoirdupois", "Wavenumber"] = {}
 
DimensionSelect["BritishAvoirdupois", "Angle"] = {}
 
DimensionSelect["BritishAvoirdupois", "Area"] = {}
 
DimensionSelect["BritishAvoirdupois", "Capacitance"] = {}
 
DimensionSelect["BritishAvoirdupois", "Charge"] = {}
 
DimensionSelect["BritishAvoirdupois", "Current"] = {}
 
DimensionSelect["BritishAvoirdupois", "Data"] = {}
 
DimensionSelect["BritishAvoirdupois", "Energy"] = {}
 
DimensionSelect["BritishAvoirdupois", "Force"] = {}
 
DimensionSelect["BritishAvoirdupois", "Frequency"] = {}
 
DimensionSelect["BritishAvoirdupois", "Inductance"] = {}
 
DimensionSelect["BritishAvoirdupois", "Length"] = {}
 
DimensionSelect["BritishAvoirdupois", 
     "Magnetic Dipole Moment"] = {}
 
DimensionSelect["BritishAvoirdupois", 
     "Magnetic Field Strength"] = {}
 
DimensionSelect["BritishAvoirdupois", "Magnetic Induction"] = {}
 
DimensionSelect["BritishAvoirdupois", "Mass"] = 
    {Unit[1, "Grain"], Unit[1, "Dram"], Unit[1, "Ounce"], Unit[1, "Pound"], 
     Unit[1, "Stone"], Unit[1, "Hundredweight"], Unit[1, "LongTon"]}
 
DimensionSelect["BritishAvoirdupois", "Power"] = {}
 
DimensionSelect["BritishAvoirdupois", "Pressure"] = {}
 
DimensionSelect["BritishAvoirdupois", "Resistance"] = {}
 
DimensionSelect["BritishAvoirdupois", "Resistivity"] = {}
 
DimensionSelect["BritishAvoirdupois", "Time"] = {}
 
DimensionSelect["BritishAvoirdupois", "Velocity"] = {}
 
DimensionSelect["BritishAvoirdupois", "Viscosity"] = {}
 
DimensionSelect["BritishAvoirdupois", "Voltage"] = {}
 
DimensionSelect["BritishAvoirdupois", "Volume"] = {}
 
DimensionSelect["BritishAvoirdupois", "Wavenumber"] = {}
 
DimensionSelect["CGS", "Angle"] = {Unit[1, "Radian"]}
 
DimensionSelect["CGS", "Area"] = {Unit[1, "Centimeter"^2]}
 
DimensionSelect["CGS", "Capacitance"] = {Unit[1, "Abfarad"]}
 
DimensionSelect["CGS", "Charge"] = {Unit[1, "Abcoulomb"]}
 
DimensionSelect["CGS", "Current"] = {Unit[1, "Abampere"]}
 
DimensionSelect["CGS", "Data"] = {}
 
DimensionSelect["CGS", "Energy"] = {Unit[1, "Erg"]}
 
DimensionSelect["CGS", "Force"] = {Unit[1, "Dyne"]}
 
DimensionSelect["CGS", "Frequency"] = {}
 
DimensionSelect["CGS", "Inductance"] = {Unit[1, "Abhenry"]}
 
DimensionSelect["CGS", "Length"] = {Unit[1, "Centimeter"]}
 
DimensionSelect["CGS", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["CGS", "Magnetic Field Strength"] = 
    {Unit[1, "Abvolt"/"Centimeter"]}
 
DimensionSelect["CGS", "Magnetic Induction"] = 
    {Unit[1, "Gauss"]}
 
DimensionSelect["CGS", "Mass"] = {Unit[1, "Gram"]}
 
DimensionSelect["CGS", "Power"] = {Unit[1, "Erg"/"Second"]}
 
DimensionSelect["CGS", "Pressure"] = {Unit[1, "Barye"]}
 
DimensionSelect["CGS", "Resistance"] = {Unit[1, "Abohm"]}
 
DimensionSelect["CGS", "Resistivity"] = 
    {Unit[1, "Abohm"*"Centimeter"]}
 
DimensionSelect["CGS", "Time"] = {Unit[1, "Second"]}
 
DimensionSelect["CGS", "Velocity"] = 
    {Unit[1, "Centimeter"/"Second"]}
 
DimensionSelect["CGS", "Viscosity"] = {Unit[1, "Poise"]}
 
DimensionSelect["CGS", "Voltage"] = {Unit[1, "Abvolt"]}
 
DimensionSelect["CGS", "Volume"] = {Unit[1, "Centimeter"^3]}
 
DimensionSelect["CGS", "Wavenumber"] = {Unit[1, "Kayser"]}
 
DimensionSelect["Champagne", "Angle"] = {}
 
DimensionSelect["Champagne", "Area"] = {}
 
DimensionSelect["Champagne", "Capacitance"] = {}
 
DimensionSelect["Champagne", "Charge"] = {}
 
DimensionSelect["Champagne", "Current"] = {}
 
DimensionSelect["Champagne", "Data"] = {}
 
DimensionSelect["Champagne", "Energy"] = {}
 
DimensionSelect["Champagne", "Force"] = {}
 
DimensionSelect["Champagne", "Frequency"] = {}
 
DimensionSelect["Champagne", "Inductance"] = {}
 
DimensionSelect["Champagne", "Length"] = {}
 
DimensionSelect["Champagne", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Champagne", "Magnetic Field Strength"] = {}
 
DimensionSelect["Champagne", "Magnetic Induction"] = {}
 
DimensionSelect["Champagne", "Mass"] = {}
 
DimensionSelect["Champagne", "Power"] = {}
 
DimensionSelect["Champagne", "Pressure"] = {}
 
DimensionSelect["Champagne", "Resistance"] = {}
 
DimensionSelect["Champagne", "Resistivity"] = {}
 
DimensionSelect["Champagne", "Time"] = {}
 
DimensionSelect["Champagne", "Velocity"] = {}
 
DimensionSelect["Champagne", "Viscosity"] = {}
 
DimensionSelect["Champagne", "Voltage"] = {}
 
DimensionSelect["Champagne", "Volume"] = 
    {Unit[1, "MetricWineBottle"], Unit[1, "Piccolo"], Unit[1, "Magnum"], Unit[1, "Demi"], Unit[1, "DoubleMagnum"], Unit[1, "Rehoboam"], Unit[1, "Methuselah"], 
 Unit[1, "Mordechai"], Unit[1, "Salmanazar"], Unit[1, "Balthazar"], Unit[1, "Nebuchadnezzar"], Unit[1, "Melchior"], Unit[1, "Primat"], Unit[1, "Melchizedek"], 
 Unit[1, "Sovereign"], Unit[1, "Solomon"], Unit[1, "Jeroboam"]}
 
DimensionSelect["Champagne", "Wavenumber"] = {}
 
DimensionSelect["IEC", "Angle"] = {}
 
DimensionSelect["IEC", "Area"] = {}
 
DimensionSelect["IEC", "Capacitance"] = {}
 
DimensionSelect["IEC", "Charge"] = {}
 
DimensionSelect["IEC", "Current"] = {}
 
DimensionSelect["IEC", "Data"] = {Unit[1, "Kibibit"], 
     Unit[1, "Kibibyte"], Unit[1, "Mebibit"], Unit[1, "Mebibyte"], 
     Unit[1, "Gibibit"], Unit[1, "Gibibyte"], Unit[1, "Tebibit"], 
     Unit[1, "Tebibyte"], Unit[1, "Pebibit"], Unit[1, "Pebibyte"], 
     Unit[1, "Exbibit"], Unit[1, "Exbibyte"], Unit[1, "Zebibit"], 
     Unit[1, "Zebibyte"], Unit[1, "Yobibit"], Unit[1, "Yobibyte"]}
 
DimensionSelect["IEC", "Energy"] = {}
 
DimensionSelect["IEC", "Force"] = {}
 
DimensionSelect["IEC", "Frequency"] = {}
 
DimensionSelect["IEC", "Inductance"] = {}
 
DimensionSelect["IEC", "Length"] = {}
 
DimensionSelect["IEC", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["IEC", "Magnetic Field Strength"] = {}
 
DimensionSelect["IEC", "Magnetic Induction"] = {}
 
DimensionSelect["IEC", "Mass"] = {}
 
DimensionSelect["IEC", "Power"] = {}
 
DimensionSelect["IEC", "Pressure"] = {}
 
DimensionSelect["IEC", "Resistance"] = {}
 
DimensionSelect["IEC", "Resistivity"] = {}
 
DimensionSelect["IEC", "Time"] = {}
 
DimensionSelect["IEC", "Velocity"] = {}
 
DimensionSelect["IEC", "Viscosity"] = {}
 
DimensionSelect["IEC", "Voltage"] = {}
 
DimensionSelect["IEC", "Volume"] = {}
 
DimensionSelect["IEC", "Wavenumber"] = {}
 
DimensionSelect["Imperial", "Angle"] = {Unit[1, "Degree"]}
 
DimensionSelect["Imperial", "Area"] = 
    {Unit[1, "Rood"], Unit[1, "Acre"]}
 
DimensionSelect["Imperial", "Capacitance"] = {}
 
DimensionSelect["Imperial", "Charge"] = {}
 
DimensionSelect["Imperial", "Current"] = {}
 
DimensionSelect["Imperial", "Data"] = {}
 
DimensionSelect["Imperial", "Energy"] = 
    {Unit[1, "Calorie"], Unit[1, "BritishThermalUnit"]}
 
DimensionSelect["Imperial", "Force"] = {Unit[1, "PoundForce"]}
 
DimensionSelect["Imperial", "Frequency"] = {}
 
DimensionSelect["Imperial", "Inductance"] = {}
 
DimensionSelect["Imperial", "Length"] = 
    {Unit[1, "Thou"], Unit[1, "Inch"], Unit[1, "Link"], Unit[1, "Foot"], 
     Unit[1, "Yard"], Unit[1, "Fathom"], Unit[1, "Perch"], Unit[1, "Pole"], 
     Unit[1, "Chain"], Unit[1, "Furlong"], Unit[1, "Cable"], Unit[1, "Mile"], 
     Unit[1, "NauticalMile"], Unit[1, "League"]}
 
DimensionSelect["Imperial", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Imperial", "Magnetic Field Strength"] = {}
 
DimensionSelect["Imperial", "Magnetic Induction"] = {}
 
DimensionSelect["Imperial", "Mass"] = 
    {Unit[1, "Grain"], Unit[1, "Pennyweight"], Unit[1, "Dram"], 
     Unit[1, "Ounce"], Unit[1, "TroyOunce"], Unit[1, "TroyPound"], 
     Unit[1, "Pound"], Unit[1, "Stone"], Unit[1, "Hundredweight"], 
     Unit[1, "LongTon"]}
 
DimensionSelect["Imperial", "Power"] = {Unit[1, "Horsepower"]}
 
DimensionSelect["Imperial", "Pressure"] = {Unit[1, "PSI"]}
 
DimensionSelect["Imperial", "Resistance"] = {}
 
DimensionSelect["Imperial", "Resistivity"] = {}
 
DimensionSelect["Imperial", "Time"] = 
    {Unit[1, "Second"], Unit[1, "Minute"], Unit[1, "Hour"], Unit[1, "Day"], 
     Unit[1, "Week"], Unit[1, "Month"], Unit[1, "Year"]}
 
DimensionSelect["Imperial", "Velocity"] = 
    {Unit[1, "Mile"/"Hour"]}
 
DimensionSelect["Imperial", "Viscosity"] = {}
 
DimensionSelect["Imperial", "Voltage"] = {}
 
DimensionSelect["Imperial", "Volume"] = 
    {Unit[1, "ImperialFluidOunce"], Unit[1, "ImperialGill"], 
     Unit[1, "ImperialPint"], Unit[1, "ImperialQuart"], 
     Unit[1, "ImperialGallon"]}
 
DimensionSelect["Imperial", "Wavenumber"] = {}
 
DimensionSelect["InteractiveChoices", "Angle"] = 
    {Unit[1, "Radian"], Unit[1, "Degree"]}
 
DimensionSelect["InteractiveChoices", "Area"] = 
    {Unit[1, "Foot"^2], Unit[1, "Meter"^2], Unit[1, "Chain"^2], 
     Unit[1, "Rood"], Unit[1, "Acre"], Unit[1, "SurveyAcre"], 
     Unit[1, "Section"], Unit[1, "Township"]}
 
DimensionSelect["InteractiveChoices", "Capacitance"] = 
    {Unit[1, "Farad"]}
 
DimensionSelect["InteractiveChoices", "Charge"] = 
    {Unit[1, "Coulomb"]}
 
DimensionSelect["InteractiveChoices", "Current"] = 
    {Unit[1, "Ampere"]}
 
DimensionSelect["InteractiveChoices", "Data"] = {Unit[1, "Bit"]}
 
DimensionSelect["InteractiveChoices", "Energy"] = 
    {Unit[1, "Joule"], Unit[1, "Calorie"], Unit[1, "BritishThermalUnit"]}
 
DimensionSelect["InteractiveChoices", "Force"] = 
    {Unit[1, "Newton"], Unit[1, "PoundForce"]}
 
DimensionSelect["InteractiveChoices", "Frequency"] = 
    {Unit[1, "Hertz"]}
 
DimensionSelect["InteractiveChoices", "Inductance"] = 
    {Unit[1, "Henry"]}
 
DimensionSelect["InteractiveChoices", "Length"] = 
    {Unit[1, "Thou"], Unit[1, "Inch"], Unit[1, "Hand"], Unit[1, "Link"], 
     Unit[1, "Foot"], Unit[1, "SurveyFoot"], Unit[1, "Yard"], 
     Unit[1, "Meter"], Unit[1, "Fathom"], Unit[1, "Perch"], Unit[1, "Pole"], 
     Unit[1, "Rod"], Unit[1, "Chain"], Unit[1, "Furlong"], Unit[1, "Cable"], 
     Unit[1, "Mile"], Unit[1, "SurveyMile"], Unit[1, "NauticalMile"], 
     Unit[1, "League"]}
 
DimensionSelect["InteractiveChoices", 
     "Magnetic Dipole Moment"] = {Unit[1, "Ampere"*"Meter"^2]}
 
DimensionSelect["InteractiveChoices", 
     "Magnetic Field Strength"] = {Unit[1, "Volt"/"Meter"]}
 
DimensionSelect["InteractiveChoices", "Magnetic Induction"] = 
    {Unit[1, "Tesla"]}
 
DimensionSelect["InteractiveChoices", "Mass"] = 
    {Unit[1, "Grain"], Unit[1, "Pennyweight"], Unit[1, "Dram"], 
     Unit[1, "Ounce"], Unit[1, "TroyOunce"], Unit[1, "TroyPound"], 
     Unit[1, "Pound"], Unit[1, "Kilogram"], Unit[1, "Stone"], 
     Unit[1, "ShortHundredweight"], Unit[1, "Hundredweight"], 
     Unit[1, "ShortTon"], Unit[1, "LongTon"]}
 
DimensionSelect["InteractiveChoices", "Power"] = 
    {Unit[1, "Watt"], Unit[1, "Horsepower"]}
 
DimensionSelect["InteractiveChoices", "Pressure"] = 
    {Unit[1, "Pascal"], Unit[1, "PSI"]}
 
DimensionSelect["InteractiveChoices", "Resistance"] = 
    {Unit[1, "Ohm"]}
 
DimensionSelect["InteractiveChoices", "Resistivity"] = 
    {Unit[1, "Meter"*"Ohm"]}
 
DimensionSelect["InteractiveChoices", "Time"] = 
    {Unit[1, "Second"], Unit[1, "Minute"], Unit[1, "Hour"], Unit[1, "Day"], 
     Unit[1, "Week"], Unit[1, "Month"], Unit[1, "Year"]}
 
DimensionSelect["InteractiveChoices", "Velocity"] = 
    {Unit[1, "Mile"/"Hour"], Unit[1, "Meter"/"Second"]}
 
DimensionSelect["InteractiveChoices", "Viscosity"] = 
    {Unit[1, "Pascal"*"Second"]}
 
DimensionSelect["InteractiveChoices", "Voltage"] = 
    {Unit[1, "Volt"]}
 
DimensionSelect["InteractiveChoices", "Volume"] = 
    {Unit[1, "FluidDram"], Unit[1, "Teaspoon"], Unit[1, "Tablespoon"], 
     Unit[1, "Inch"^3], Unit[1, "ImperialFluidOunce"], Unit[1, "Jigger"], 
     Unit[1, "USGill"], Unit[1, "ImperialGill"], Unit[1, "Pint"], 
     Unit[1, "DryPint"], Unit[1, "ImperialPint"], Unit[1, "Quart"], 
     Unit[1, "DryQuart"], Unit[1, "ImperialQuart"], Unit[1, "BoardFoot"], 
     Unit[1, "Gallon"], Unit[1, "DryGallon"], Unit[1, "ImperialGallon"], 
     Unit[1, "Peck"], Unit[1, "Foot"^3], Unit[1, "Bushel"], 
     Unit[1, "DryBarrel"], Unit[1, "Barrel"], Unit[1, "OilBarrel"], 
     Unit[1, "Hogshead"], Unit[1, "Yard"^3], Unit[1, "Meter"^3], 
     Unit[1, "Acre"*"Foot"]}
 
DimensionSelect["InteractiveChoices", "Wavenumber"] = 
    {Unit[1, "Meter"^(-1)]}
 
DimensionSelect["Japanese", "Angle"] = {}
 
DimensionSelect["Japanese", "Area"] = 
    {Unit[1, "ShakuArea"], Unit[1, "GoArea"], Unit[1, "JoArea"], 
     Unit[1, "BuArea"], Unit[1, "Tsubo"], Unit[1, "Se"], Unit[1, "TanArea"], 
     Unit[1, "ChoArea"]}
 
DimensionSelect["Japanese", "Capacitance"] = {}
 
DimensionSelect["Japanese", "Charge"] = {}
 
DimensionSelect["Japanese", "Current"] = {}
 
DimensionSelect["Japanese", "Data"] = {}
 
DimensionSelect["Japanese", "Energy"] = {}
 
DimensionSelect["Japanese", "Force"] = {}
 
DimensionSelect["Japanese", "Frequency"] = {}
 
DimensionSelect["Japanese", "Inductance"] = {}
 
DimensionSelect["Japanese", "Length"] = 
    {Unit[1, "Mo"], Unit[1, "Rin"], Unit[1, "Bu"], Unit[1, "Sun"], 
     Unit[1, "Shaku"], Unit[1, "Hiro"], Unit[1, "Ken"], Unit[1, "JoLength"], 
     Unit[1, "ChoLength"], Unit[1, "ReLength"]}
 
DimensionSelect["Japanese", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Japanese", "Magnetic Field Strength"] = {}
 
DimensionSelect["Japanese", "Magnetic Induction"] = {}
 
DimensionSelect["Japanese", "Mass"] = 
    {Unit[1, "Fun"], Unit[1, "Momme"], Unit[1, "Hyakume"], Unit[1, "Kin"], 
     Unit[1, "Kan"], Unit[1, "Kanme"]}
 
DimensionSelect["Japanese", "Power"] = {}
 
DimensionSelect["Japanese", "Pressure"] = {}
 
DimensionSelect["Japanese", "Resistance"] = {}
 
DimensionSelect["Japanese", "Resistivity"] = {}
 
DimensionSelect["Japanese", "Time"] = {}
 
DimensionSelect["Japanese", "Velocity"] = {}
 
DimensionSelect["Japanese", "Viscosity"] = {}
 
DimensionSelect["Japanese", "Voltage"] = {}
 
DimensionSelect["Japanese", "Volume"] = 
    {Unit[1, "Sai"], Unit[1, "ShakuVolume"], Unit[1, "GoVolume"], 
     Unit[1, "Sho"], Unit[1, "To"], Unit[1, "Koku"]}
 
DimensionSelect["Japanese", "Wavenumber"] = {}
 
DimensionSelect["Malay", "Angle"] = {}
 
DimensionSelect["Malay", "Area"] = {}
 
DimensionSelect["Malay", "Capacitance"] = {}
 
DimensionSelect["Malay", "Charge"] = {}
 
DimensionSelect["Malay", "Current"] = {}
 
DimensionSelect["Malay", "Data"] = {}
 
DimensionSelect["Malay", "Energy"] = {}
 
DimensionSelect["Malay", "Force"] = {}
 
DimensionSelect["Malay", "Frequency"] = {}
 
DimensionSelect["Malay", "Inductance"] = {}
 
DimensionSelect["Malay", "Length"] = {}
 
DimensionSelect["Malay", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Malay", "Magnetic Field Strength"] = {}
 
DimensionSelect["Malay", "Magnetic Induction"] = {}
 
DimensionSelect["Malay", "Mass"] = 
    {Unit[1, "Kati"], Unit[1, "Pikul"]}
 
DimensionSelect["Malay", "Power"] = {}
 
DimensionSelect["Malay", "Pressure"] = {}
 
DimensionSelect["Malay", "Resistance"] = {}
 
DimensionSelect["Malay", "Resistivity"] = {}
 
DimensionSelect["Malay", "Time"] = {}
 
DimensionSelect["Malay", "Velocity"] = {}
 
DimensionSelect["Malay", "Viscosity"] = {}
 
DimensionSelect["Malay", "Voltage"] = {}
 
DimensionSelect["Malay", "Volume"] = 
    {Unit[1, "Chentong"], Unit[1, "Leng"], Unit[1, "Chupak"], 
     Unit[1, "Gantang"]}
 
DimensionSelect["Malay", "Wavenumber"] = {}
 
DimensionSelect["Maltese", "Angle"] = {}
 
DimensionSelect["Maltese", "Area"] = 
    {Unit[1, "PulzierKwadru"], Unit[1, "FitelKwadru"], 
     Unit[1, "XiberKwadru"], Unit[1, "Lumin"], Unit[1, "QasbaKwadru"], 
     Unit[1, "Kejla"], Unit[1, "KejlaVolume"], Unit[1, "SieghVolume"], 
     Unit[1, "Ghabara"], Unit[1, "Siegh"], Unit[1, "Tomna"], 
     Unit[1, "Wejba"], Unit[1, "Modd"], Unit[1, "ModdVolume"]}
 
DimensionSelect["Maltese", "Capacitance"] = {}
 
DimensionSelect["Maltese", "Charge"] = {}
 
DimensionSelect["Maltese", "Current"] = {}
 
DimensionSelect["Maltese", "Data"] = {}
 
DimensionSelect["Maltese", "Energy"] = {}
 
DimensionSelect["Maltese", "Force"] = {}
 
DimensionSelect["Maltese", "Frequency"] = {}
 
DimensionSelect["Maltese", "Inductance"] = {}
 
DimensionSelect["Maltese", "Length"] = 
    {Unit[1, "Pulzier"], Unit[1, "Fitel"], Unit[1, "Xiber"], Unit[1, "Qasba"]}
 
DimensionSelect["Maltese", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Maltese", "Magnetic Field Strength"] = {}
 
DimensionSelect["Maltese", "Magnetic Induction"] = {}
 
DimensionSelect["Maltese", "Mass"] = 
    {Unit[1, "Uqija"], Unit[1, "Kwart"], Unit[1, "Ratal"], Unit[1, "Qsima"], 
     Unit[1, "Wizna"], Unit[1, "Qantar"], Unit[1, "Pezata"]}
 
DimensionSelect["Maltese", "Power"] = {}
 
DimensionSelect["Maltese", "Pressure"] = {}
 
DimensionSelect["Maltese", "Resistance"] = {}
 
DimensionSelect["Maltese", "Resistivity"] = {}
 
DimensionSelect["Maltese", "Time"] = {}
 
DimensionSelect["Maltese", "Velocity"] = {}
 
DimensionSelect["Maltese", "Viscosity"] = {}
 
DimensionSelect["Maltese", "Voltage"] = {}
 
DimensionSelect["Maltese", "Volume"] = 
    {Unit[1, "PulzierKubu"], Unit[1, "Kwartin"], Unit[1, "KejlaMilk"], 
     Unit[1, "Pinta"], Unit[1, "Terz"], Unit[1, "TerzMilk"], Unit[1, "Nofs"], 
     Unit[1, "NofsMilk"], Unit[1, "Kartocc"], Unit[1, "KartoccMilk"], 
     Unit[1, "FitelKubu"], Unit[1, "KwartaMilk"], Unit[1, "Kwarta"], 
     Unit[1, "Garra"], Unit[1, "XibeKubu"], Unit[1, "TomnaVolume"], 
     Unit[1, "MalteseQafiz"], Unit[1, "Barmil"], Unit[1, "QasbaKubu"]}
 
DimensionSelect["Maltese", "Wavenumber"] = {}
 
DimensionSelect["MeterTonneSecond", "Angle"] = {}
 
DimensionSelect["MeterTonneSecond", "Area"] = {}
 
DimensionSelect["MeterTonneSecond", "Capacitance"] = {}
 
DimensionSelect["MeterTonneSecond", "Charge"] = {}
 
DimensionSelect["MeterTonneSecond", "Current"] = {}
 
DimensionSelect["MeterTonneSecond", "Data"] = {}
 
DimensionSelect["MeterTonneSecond", "Energy"] = 
    {Unit[1, "Meter"*"Sthene"]}
 
DimensionSelect["MeterTonneSecond", "Force"] = 
    {Unit[1, "Sthene"]}
 
DimensionSelect["MeterTonneSecond", "Frequency"] = {}
 
DimensionSelect["MeterTonneSecond", "Inductance"] = {}
 
DimensionSelect["MeterTonneSecond", "Length"] = 
    {Unit[1, "Meter"]}
 
DimensionSelect["MeterTonneSecond", "Magnetic Dipole Moment"] = 
    {}
 
DimensionSelect["MeterTonneSecond", 
     "Magnetic Field Strength"] = {}
 
DimensionSelect["MeterTonneSecond", "Magnetic Induction"] = {}
 
DimensionSelect["MeterTonneSecond", "Mass"] = 
    {Unit[1, "MetricTon"], Unit[1, "Tonne"]}
 
DimensionSelect["MeterTonneSecond", "Power"] = 
    {Unit[1, ("Meter"*"Sthene")/"Second"]}
 
DimensionSelect["MeterTonneSecond", "Pressure"] = 
    {Unit[1, "Pieze"]}
 
DimensionSelect["MeterTonneSecond", "Resistance"] = {}
 
DimensionSelect["MeterTonneSecond", "Resistivity"] = {}
 
DimensionSelect["MeterTonneSecond", "Time"] = 
    {Unit[1, "Second"]}
 
DimensionSelect["MeterTonneSecond", "Velocity"] = {}
 
DimensionSelect["MeterTonneSecond", "Viscosity"] = {}
 
DimensionSelect["MeterTonneSecond", "Voltage"] = {}
 
DimensionSelect["MeterTonneSecond", "Volume"] = 
    {Unit[1, "Stere"]}
 
DimensionSelect["MeterTonneSecond", "Wavenumber"] = {}
 
DimensionSelect["MKS", "Angle"] = {Unit[1, "Radian"]}
 
DimensionSelect["MKS", "Area"] = {Unit[1, "Meter"^2]}
 
DimensionSelect["MKS", "Capacitance"] = 
    {Unit[1, ("Ampere"^2*"Second"^4)/("Kilogram"*"Meter"^2)]}
 
DimensionSelect["MKS", "Charge"] = {Unit[1, "Ampere"*"Second"]}
 
DimensionSelect["MKS", "Current"] = {Unit[1, "Ampere"]}
 
DimensionSelect["MKS", "Data"] = {Unit[1, "Bit"]}
 
DimensionSelect["MKS", "Energy"] = 
    {Unit[1, ("Kilogram"*"Meter"^2)/"Second"^2]}
 
DimensionSelect["MKS", "Force"] = 
    {Unit[1, ("Kilogram"*"Meter")/"Second"^2]}
 
DimensionSelect["MKS", "Frequency"] = {Unit[1, "Second"^(-1)]}
 
DimensionSelect["MKS", "Inductance"] = 
    {Unit[1, ("Kilogram"*"Meter"^2)/("Ampere"^2*"Second"^2)]}
 
DimensionSelect["MKS", "Length"] = {Unit[1, "Meter"]}
 
DimensionSelect["MKS", "Magnetic Dipole Moment"] = 
    {Unit[1, "Ampere"*"Meter"^2]}
 
DimensionSelect["MKS", "Magnetic Field Strength"] = 
    {Unit[1, ("Kilogram"*"Meter")/("Ampere"*"Second"^3)]}
 
DimensionSelect["MKS", "Magnetic Induction"] = 
    {Unit[1, ("Kilogram"*"Meter"^4)/("Ampere"*"Second"^2)]}
 
DimensionSelect["MKS", "Mass"] = {Unit[1, "Kilogram"]}
 
DimensionSelect["MKS", "Power"] = 
    {Unit[1, ("Kilogram"*"Meter"^2)/"Second"^3]}
 
DimensionSelect["MKS", "Pressure"] = 
    {Unit[1, "Kilogram"/("Meter"*"Second"^2)]}
 
DimensionSelect["MKS", "Resistance"] = 
    {Unit[1, ("Kilogram"*"Meter"^2)/("Ampere"^2*"Second"^3)]}
 
DimensionSelect["MKS", "Resistivity"] = 
    {Unit[1, ("Kilogram"*"Meter"^3)/("Ampere"^2*"Second"^3)]}
 
DimensionSelect["MKS", "Time"] = {Unit[1, "Second"]}
 
DimensionSelect["MKS", "Velocity"] = {Unit[1, "Meter"/"Second"]}
 
DimensionSelect["MKS", "Viscosity"] = 
    {Unit[1, "Kilogram"/("Meter"*"Second")]}
 
DimensionSelect["MKS", "Voltage"] = 
    {Unit[1, ("Kilogram"*"Meter"^2)/("Ampere"*"Second"^3)]}
 
DimensionSelect["MKS", "Volume"] = {Unit[1, "Meter"^3]}
 
DimensionSelect["MKS", "Wavenumber"] = {Unit[1, "Meter"^(-1)]}
 
DimensionSelect["Norwegian", "Angle"] = {}
 
DimensionSelect["Norwegian", "Area"] = 
    {Unit[1, "KvadratRode"], Unit[1, "Mal"], Unit[1, "Tonneland"]}
 
DimensionSelect["Norwegian", "Capacitance"] = {}
 
DimensionSelect["Norwegian", "Charge"] = {}
 
DimensionSelect["Norwegian", "Current"] = {}
 
DimensionSelect["Norwegian", "Data"] = {}
 
DimensionSelect["Norwegian", "Energy"] = {}
 
DimensionSelect["Norwegian", "Force"] = {}
 
DimensionSelect["Norwegian", "Frequency"] = {}
 
DimensionSelect["Norwegian", "Inductance"] = {}
 
DimensionSelect["Norwegian", "Length"] = 
    {Unit[1, "Skrupel"], Unit[1, "NorwegianLinje"], Unit[1, "Tomme"], 
     Unit[1, "NorwegianKvarter"], Unit[1, "NorwegianFot"], Unit[1, "Alen"], 
     Unit[1, "Favn"], Unit[1, "NorwegianStang"], Unit[1, "Las"], 
     Unit[1, "Kabellengde"], Unit[1, "NorwegianKvartmil"], 
     Unit[1, "Fjerdingsvei"], Unit[1, "Geografiskmil"], 
     Unit[1, "NorwegianSjomil"], Unit[1, "NorwegianMil"]}
 
DimensionSelect["Norwegian", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Norwegian", "Magnetic Field Strength"] = {}
 
DimensionSelect["Norwegian", "Magnetic Induction"] = {}
 
DimensionSelect["Norwegian", "Mass"] = 
    {Unit[1, "NorwegianOrt"], Unit[1, "Merke"], Unit[1, "Pund"], 
     Unit[1, "NorwegianBismerpund"], Unit[1, "Laup"], Unit[1, "Spann"], 
     Unit[1, "Vag"], Unit[1, "Skippund"]}
 
DimensionSelect["Norwegian", "Power"] = {}
 
DimensionSelect["Norwegian", "Pressure"] = {}
 
DimensionSelect["Norwegian", "Resistance"] = {}
 
DimensionSelect["Norwegian", "Resistivity"] = {}
 
DimensionSelect["Norwegian", "Time"] = {}
 
DimensionSelect["Norwegian", "Velocity"] = {}
 
DimensionSelect["Norwegian", "Viscosity"] = {}
 
DimensionSelect["Norwegian", "Voltage"] = {}
 
DimensionSelect["Norwegian", "Volume"] = 
    {Unit[1, "Skjeppe"], Unit[1, "NorwegianTonne"], Unit[1, "FavnVolume"]}
 
DimensionSelect["Norwegian", "Wavenumber"] = {}
 
DimensionSelect["Planck", "Angle"] = {}
 
DimensionSelect["Planck", "Area"] = {Unit[1, "PlanckArea"]}
 
DimensionSelect["Planck", "Capacitance"] = {}
 
DimensionSelect["Planck", "Charge"] = {Unit[1, "PlanckCharge"]}
 
DimensionSelect["Planck", "Current"] = 
    {Unit[1, "PlanckCurrent"]}
 
DimensionSelect["Planck", "Data"] = {}
 
DimensionSelect["Planck", "Energy"] = {Unit[1, "PlanckEnergy"]}
 
DimensionSelect["Planck", "Force"] = {Unit[1, "PlanckForce"]}
 
DimensionSelect["Planck", "Frequency"] = 
    {Unit[1, "PlanckAngularFrequency"]}
 
DimensionSelect["Planck", "Inductance"] = {}
 
DimensionSelect["Planck", "Length"] = 
    {Unit[1, "PlanckLength"]}
 
DimensionSelect["Planck", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Planck", "Magnetic Field Strength"] = {}
 
DimensionSelect["Planck", "Magnetic Induction"] = {}
 
DimensionSelect["Planck", "Mass"] = {Unit[1, "PlanckMass"]}
 
DimensionSelect["Planck", "Power"] = {Unit[1, "PlanckPower"]}
 
DimensionSelect["Planck", "Pressure"] = 
    {Unit[1, "PlanckPressure"]}
 
DimensionSelect["Planck", "Resistance"] = 
    {Unit[1, "PlanckImpedence"]}
 
DimensionSelect["Planck", "Resistivity"] = {}
 
DimensionSelect["Planck", "Time"] = {Unit[1, "PlanckTime"]}
 
DimensionSelect["Planck", "Velocity"] = {}
 
DimensionSelect["Planck", "Viscosity"] = {}
 
DimensionSelect["Planck", "Voltage"] = 
    {Unit[1, "PlanckVoltage"]}
 
DimensionSelect["Planck", "Volume"] = {Unit[1, "PlanckVolume"]}
 
DimensionSelect["Planck", "Wavenumber"] = {}
 
DimensionSelect["PrefixedSI", "Angle"] = 
    {Unit[1, "Radian"], Unit[1, "Radian"]}
 
DimensionSelect["PrefixedSI", "Area"] = 
    {Unit[1, "Yoctometer"^2], Unit[1, "Zeptometer"^2], 
     Unit[1, "Attometer"^2], Unit[1, "Femtometer"^2], Unit[1, "Picometer"^2], 
     Unit[1, "Nanometer"^2], Unit[1, "Micrometer"^2], 
     Unit[1, "Millimeter"^2], Unit[1, "Centimeter"^2], 
     Unit[1, "Decimeter"^2], Unit[1, "Meter"^2], Unit[1, "Decameter"^2], 
     Unit[1, "Hectometer"^2], Unit[1, "Kilometer"^2], Unit[1, "Megameter"^2], 
     Unit[1, "Gigameter"^2], Unit[1, "Terameter"^2], Unit[1, "Petameter"^2], 
     Unit[1, "Exameter"^2], Unit[1, "Zettameter"^2], Unit[1, "Yottameter"^2]}
 
DimensionSelect["PrefixedSI", "Capacitance"] = 
    {Unit[1, "Yoctofarad"], Unit[1, "Zeptofarad"], Unit[1, "Attofarad"], 
     Unit[1, "Femtofarad"], Unit[1, "Picofarad"], Unit[1, "Nanofarad"], 
     Unit[1, "Microfarad"], Unit[1, "Millifarad"], Unit[1, "Centifarad"], 
     Unit[1, "Decifarad"], Unit[1, "Farad"], Unit[1, "Decafarad"], 
     Unit[1, "Hectofarad"], Unit[1, "Kilofarad"], Unit[1, "Megafarad"], 
     Unit[1, "Gigafarad"], Unit[1, "Terafarad"], Unit[1, "Petafarad"], 
     Unit[1, "Exafarad"], Unit[1, "Zettafarad"], Unit[1, "Yottafarad"]}
 
DimensionSelect["PrefixedSI", "Charge"] = 
    {Unit[1, "Yoctocoulomb"], Unit[1, "Zeptocoulomb"], 
     Unit[1, "Attocoulomb"], Unit[1, "Femtocoulomb"], Unit[1, "Picocoulomb"], 
     Unit[1, "Nanocoulomb"], Unit[1, "Microcoulomb"], 
     Unit[1, "Millicoulomb"], Unit[1, "Centicoulomb"], 
     Unit[1, "Decicoulomb"], Unit[1, "Coulomb"], Unit[1, "Decacoulomb"], 
     Unit[1, "Hectocoulomb"], Unit[1, "Kilocoulomb"], Unit[1, "Megacoulomb"], 
     Unit[1, "Gigacoulomb"], Unit[1, "Teracoulomb"], Unit[1, "Petacoulomb"], 
     Unit[1, "Exacoulomb"], Unit[1, "Zettacoulomb"], Unit[1, "Yottacoulomb"]}
 
DimensionSelect["PrefixedSI", "Current"] = 
    {Unit[1, "Yoctoampere"], Unit[1, "Zeptoampere"], Unit[1, "Attoampere"], 
     Unit[1, "Femtoampere"], Unit[1, "Picoampere"], Unit[1, "Nanoampere"], 
     Unit[1, "Microampere"], Unit[1, "Milliampere"], Unit[1, "Centiampere"], 
     Unit[1, "Deciampere"], Unit[1, "Ampere"], Unit[1, "Decaampere"], 
     Unit[1, "Hectoampere"], Unit[1, "Kiloampere"], Unit[1, "Megaampere"], 
     Unit[1, "Gigaampere"], Unit[1, "Teraampere"], Unit[1, "Petaampere"], 
     Unit[1, "Exaampere"], Unit[1, "Zettaampere"], Unit[1, "Yottaampere"]}
 
DimensionSelect["PrefixedSI", "Data"] = 
    {Unit[1, "Bit"], Unit[1, "Bit"], Unit[1, "Byte"]}
 
DimensionSelect["PrefixedSI", "Energy"] = 
    {Unit[1, "Yoctojoule"], Unit[1, "Zeptojoule"], Unit[1, "Attojoule"], 
     Unit[1, "Femtojoule"], Unit[1, "Picojoule"], Unit[1, "Nanojoule"], 
     Unit[1, "Microjoule"], Unit[1, "Millijoule"], Unit[1, "Centijoule"], 
     Unit[1, "Decijoule"], Unit[1, "Joule"], Unit[1, "Decajoule"], 
     Unit[1, "Hectojoule"], Unit[1, "Kilojoule"], Unit[1, "Megajoule"], 
     Unit[1, "Gigajoule"], Unit[1, "Terajoule"], Unit[1, "Petajoule"], 
     Unit[1, "Exajoule"], Unit[1, "Zettajoule"], Unit[1, "Yottajoule"]}
 
DimensionSelect["PrefixedSI", "Force"] = 
    {Unit[1, "Yoctonewton"], Unit[1, "Zeptonewton"], Unit[1, "Attonewton"], 
     Unit[1, "Femtonewton"], Unit[1, "Piconewton"], Unit[1, "Nanonewton"], 
     Unit[1, "Micronewton"], Unit[1, "Millinewton"], Unit[1, "Centinewton"], 
     Unit[1, "Decinewton"], Unit[1, "Newton"], Unit[1, "Decanewton"], 
     Unit[1, "Hectonewton"], Unit[1, "Kilonewton"], Unit[1, "Meganewton"], 
     Unit[1, "Giganewton"], Unit[1, "Teranewton"], Unit[1, "Petanewton"], 
     Unit[1, "Exanewton"], Unit[1, "Zettanewton"], Unit[1, "Yottanewton"]}
 
DimensionSelect["PrefixedSI", "Frequency"] = 
    {Unit[1, "Yoctohertz"], Unit[1, "Zeptohertz"], Unit[1, "Attohertz"], 
     Unit[1, "Femtohertz"], Unit[1, "Picohertz"], Unit[1, "Nanohertz"], 
     Unit[1, "Microhertz"], Unit[1, "Millihertz"], Unit[1, "Centihertz"], 
     Unit[1, "Decihertz"], Unit[1, "Hertz"], Unit[1, "Decahertz"], 
     Unit[1, "Hectohertz"], Unit[1, "Kilohertz"], Unit[1, "Megahertz"], 
     Unit[1, "Gigahertz"], Unit[1, "Terahertz"], Unit[1, "Petahertz"], 
     Unit[1, "Exahertz"], Unit[1, "Zettahertz"], Unit[1, "Yottahertz"]}
 
DimensionSelect["PrefixedSI", "Inductance"] = 
    {Unit[1, "Yoctohenry"], Unit[1, "Zeptohenry"], Unit[1, "Attohenry"], 
     Unit[1, "Femtohenry"], Unit[1, "Picohenry"], Unit[1, "Nanohenry"], 
     Unit[1, "Microhenry"], Unit[1, "Millihenry"], Unit[1, "Centihenry"], 
     Unit[1, "Decihenry"], Unit[1, "Henry"], Unit[1, "Decahenry"], 
     Unit[1, "Hectohenry"], Unit[1, "Kilohenry"], Unit[1, "Megahenry"], 
     Unit[1, "Gigahenry"], Unit[1, "Terahenry"], Unit[1, "Petahenry"], 
     Unit[1, "Exahenry"], Unit[1, "Zettahenry"], Unit[1, "Yottahenry"]}
 
DimensionSelect["PrefixedSI", "Length"] = 
    {Unit[1, "Yoctometer"], Unit[1, "Zeptometer"], Unit[1, "Attometer"], 
     Unit[1, "Femtometer"], Unit[1, "Picometer"], Unit[1, "Nanometer"], 
     Unit[1, "Micrometer"], Unit[1, "Millimeter"], Unit[1, "Centimeter"], 
     Unit[1, "Decimeter"], Unit[1, "Meter"], Unit[1, "Decameter"], 
     Unit[1, "Hectometer"], Unit[1, "Kilometer"], Unit[1, "Megameter"], 
     Unit[1, "Gigameter"], Unit[1, "Terameter"], Unit[1, "Petameter"], 
     Unit[1, "Exameter"], Unit[1, "Zettameter"], Unit[1, "Yottameter"]}
 
DimensionSelect["PrefixedSI", "Magnetic Dipole Moment"] = 
    {Unit[1, "Meter"^2*"Yoctoampere"], Unit[1, "Meter"^2*"Zeptoampere"], 
     Unit[1, "Attoampere"*"Meter"^2], Unit[1, "Femtoampere"*"Meter"^2], 
     Unit[1, "Meter"^2*"Picoampere"], Unit[1, "Meter"^2*"Nanoampere"], 
     Unit[1, "Meter"^2*"Microampere"], Unit[1, "Meter"^2*"Milliampere"], 
     Unit[1, "Centiampere"*"Meter"^2], Unit[1, "Deciampere"*"Meter"^2], 
     Unit[1, "Ampere"*"Meter"^2], Unit[1, "Decaampere"*"Meter"^2], 
     Unit[1, "Hectoampere"*"Meter"^2], Unit[1, "Kiloampere"*"Meter"^2], 
     Unit[1, "Megaampere"*"Meter"^2], Unit[1, "Gigaampere"*"Meter"^2], 
     Unit[1, "Meter"^2*"Teraampere"], Unit[1, "Meter"^2*"Petaampere"], 
     Unit[1, "Exaampere"*"Meter"^2], Unit[1, "Meter"^2*"Zettaampere"], 
     Unit[1, "Meter"^2*"Yottaampere"]}
 
DimensionSelect["PrefixedSI", "Magnetic Field Strength"] = 
    {Unit[1, "Yoctovolt"/"Meter"], Unit[1, "Zeptovolt"/"Meter"], 
     Unit[1, "Attovolt"/"Meter"], Unit[1, "Femtovolt"/"Meter"], 
     Unit[1, "Picovolt"/"Meter"], Unit[1, "Nanovolt"/"Meter"], 
     Unit[1, "Microvolt"/"Meter"], Unit[1, "Millivolt"/"Meter"], 
     Unit[1, "Centivolt"/"Meter"], Unit[1, "Decivolt"/"Meter"], 
     Unit[1, "Volt"/"Meter"], Unit[1, "Decavolt"/"Meter"], 
     Unit[1, "Hectovolt"/"Meter"], Unit[1, "Kilovolt"/"Meter"], 
     Unit[1, "Megavolt"/"Meter"], Unit[1, "Gigavolt"/"Meter"], 
     Unit[1, "Teravolt"/"Meter"], Unit[1, "Petavolt"/"Meter"], 
     Unit[1, "Exavolt"/"Meter"], Unit[1, "Zettavolt"/"Meter"], 
     Unit[1, "Yottavolt"/"Meter"]}
 
DimensionSelect["PrefixedSI", "Magnetic Induction"] = 
    {Unit[1, "Yoctotesla"], Unit[1, "Zeptotesla"], Unit[1, "Attotesla"], 
     Unit[1, "Femtotesla"], Unit[1, "Picotesla"], Unit[1, "Nanotesla"], 
     Unit[1, "Microtesla"], Unit[1, "Millitesla"], Unit[1, "Centitesla"], 
     Unit[1, "Decitesla"], Unit[1, "Tesla"], Unit[1, "Decatesla"], 
     Unit[1, "Hectotesla"], Unit[1, "Kilotesla"], Unit[1, "Megatesla"], 
     Unit[1, "Gigatesla"], Unit[1, "Teratesla"], Unit[1, "Petatesla"], 
     Unit[1, "Exatesla"], Unit[1, "Zettatesla"], Unit[1, "Yottatesla"]}
 
DimensionSelect["PrefixedSI", "Mass"] = 
    {Unit[1, "Kilogram"], Unit[1, "Kilogram"]}
 
DimensionSelect["PrefixedSI", "Power"] = 
    {Unit[1, "Yoctowatt"], Unit[1, "Zeptowatt"], Unit[1, "Attowatt"], 
     Unit[1, "Femtowatt"], Unit[1, "Picowatt"], Unit[1, "Nanowatt"], 
     Unit[1, "Microwatt"], Unit[1, "Milliwatt"], Unit[1, "Centiwatt"], 
     Unit[1, "Deciwatt"], Unit[1, "Watt"], Unit[1, "Decawatt"], 
     Unit[1, "Hectowatt"], Unit[1, "Kilowatt"], Unit[1, "Megawatt"], 
     Unit[1, "Gigawatt"], Unit[1, "Terawatt"], Unit[1, "Petawatt"], 
     Unit[1, "Exawatt"], Unit[1, "Zettawatt"], Unit[1, "Yottawatt"]}
 
DimensionSelect["PrefixedSI", "Pressure"] = 
    {Unit[1, "Yoctopascal"], Unit[1, "Zeptopascal"], Unit[1, "Attopascal"], 
     Unit[1, "Femtopascal"], Unit[1, "Picopascal"], Unit[1, "Nanopascal"], 
     Unit[1, "Micropascal"], Unit[1, "Millipascal"], Unit[1, "Centipascal"], 
     Unit[1, "Decipascal"], Unit[1, "Pascal"], Unit[1, "Decapascal"], 
     Unit[1, "Hectopascal"], Unit[1, "Kilopascal"], Unit[1, "Megapascal"], 
     Unit[1, "Gigapascal"], Unit[1, "Terapascal"], Unit[1, "Petapascal"], 
     Unit[1, "Exapascal"], Unit[1, "Zettapascal"], Unit[1, "Yottapascal"]}
 
DimensionSelect["PrefixedSI", "Resistance"] = 
    {Unit[1, "Yoctoohm"], Unit[1, "Zeptoohm"], Unit[1, "Attoohm"], 
     Unit[1, "Femtoohm"], Unit[1, "Picoohm"], Unit[1, "Nanoohm"], 
     Unit[1, "Microohm"], Unit[1, "Milliohm"], Unit[1, "Centiohm"], 
     Unit[1, "Deciohm"], Unit[1, "Ohm"], Unit[1, "Decaohm"], 
     Unit[1, "Hectoohm"], Unit[1, "Kiloohm"], Unit[1, "Megaohm"], 
     Unit[1, "Gigaohm"], Unit[1, "Teraohm"], Unit[1, "Petaohm"], 
     Unit[1, "Exaohm"], Unit[1, "Zettaohm"], Unit[1, "Yottaohm"]}
 
DimensionSelect["PrefixedSI", "Resistivity"] = 
    {Unit[1, "Meter"*"Ohm"]}
 
DimensionSelect["PrefixedSI", "Time"] = 
    {Unit[1, "Yoctosecond"], Unit[1, "Zeptosecond"], Unit[1, "Attosecond"], 
     Unit[1, "Femtosecond"], Unit[1, "Picosecond"], Unit[1, "Nanosecond"], 
     Unit[1, "Microsecond"], Unit[1, "Millisecond"], Unit[1, "Centisecond"], 
     Unit[1, "Decisecond"], Unit[1, "Second"], Unit[1, "Decasecond"], 
     Unit[1, "Hectosecond"], Unit[1, "Kilosecond"], Unit[1, "Megasecond"], 
     Unit[1, "Gigasecond"], Unit[1, "Terasecond"], Unit[1, "Petasecond"], 
     Unit[1, "Exasecond"], Unit[1, "Zettasecond"], Unit[1, "Yottasecond"]}
 
DimensionSelect["PrefixedSI", "Velocity"] = 
    {Unit[1, "Yoctometer"/"Second"], Unit[1, "Zeptometer"/"Second"], 
     Unit[1, "Attometer"/"Second"], Unit[1, "Femtometer"/"Second"], 
     Unit[1, "Picometer"/"Second"], Unit[1, "Nanometer"/"Second"], 
     Unit[1, "Micrometer"/"Second"], Unit[1, "Millimeter"/"Second"], 
     Unit[1, "Centimeter"/"Second"], Unit[1, "Decimeter"/"Second"], 
     Unit[1, "Meter"/"Second"], Unit[1, "Decameter"/"Second"], 
     Unit[1, "Hectometer"/"Second"], Unit[1, "Kilometer"/"Second"], 
     Unit[1, "Megameter"/"Second"], Unit[1, "Gigameter"/"Second"], 
     Unit[1, "Terameter"/"Second"], Unit[1, "Petameter"/"Second"], 
     Unit[1, "Exameter"/"Second"], Unit[1, "Zettameter"/"Second"], 
     Unit[1, "Yottameter"/"Second"]}
 
DimensionSelect["PrefixedSI", "Viscosity"] = 
    {Unit[1, "Pascal"*"Second"]}
 
DimensionSelect["PrefixedSI", "Voltage"] = 
    {Unit[1, "Yoctovolt"], Unit[1, "Zeptovolt"], Unit[1, "Attovolt"], 
     Unit[1, "Femtovolt"], Unit[1, "Picovolt"], Unit[1, "Nanovolt"], 
     Unit[1, "Microvolt"], Unit[1, "Millivolt"], Unit[1, "Centivolt"], 
     Unit[1, "Decivolt"], Unit[1, "Volt"], Unit[1, "Decavolt"], 
     Unit[1, "Hectovolt"], Unit[1, "Kilovolt"], Unit[1, "Megavolt"], 
     Unit[1, "Gigavolt"], Unit[1, "Teravolt"], Unit[1, "Petavolt"], 
     Unit[1, "Exavolt"], Unit[1, "Zettavolt"], Unit[1, "Yottavolt"]}
 
DimensionSelect["PrefixedSI", "Volume"] = 
    {Unit[1, "Yoctometer"^3], Unit[1, "Zeptometer"^3], 
     Unit[1, "Attometer"^3], Unit[1, "Femtometer"^3], Unit[1, "Picometer"^3], 
     Unit[1, "Nanometer"^3], Unit[1, "Micrometer"^3], 
     Unit[1, "Millimeter"^3], Unit[1, "Centimeter"^3], 
     Unit[1, "Decimeter"^3], Unit[1, "Meter"^3], Unit[1, "Decameter"^3], 
     Unit[1, "Hectometer"^3], Unit[1, "Kilometer"^3], Unit[1, "Megameter"^3], 
     Unit[1, "Gigameter"^3], Unit[1, "Terameter"^3], Unit[1, "Petameter"^3], 
     Unit[1, "Exameter"^3], Unit[1, "Zettameter"^3], Unit[1, "Yottameter"^3]}
 
DimensionSelect["PrefixedSI", "Wavenumber"] = 
    {Unit[1, "Yottameter"^(-1)], Unit[1, "Zettameter"^(-1)], 
     Unit[1, "Exameter"^(-1)], Unit[1, "Petameter"^(-1)], 
     Unit[1, "Terameter"^(-1)], Unit[1, "Gigameter"^(-1)], 
     Unit[1, "Megameter"^(-1)], Unit[1, "Kilometer"^(-1)], 
     Unit[1, "Hectometer"^(-1)], Unit[1, "Decameter"^(-1)], 
     Unit[1, "Meter"^(-1)], Unit[1, "Decimeter"^(-1)], 
     Unit[1, "Centimeter"^(-1)], Unit[1, "Millimeter"^(-1)], 
     Unit[1, "Micrometer"^(-1)], Unit[1, "Nanometer"^(-1)], 
     Unit[1, "Picometer"^(-1)], Unit[1, "Femtometer"^(-1)], 
     Unit[1, "Attometer"^(-1)], Unit[1, "Zeptometer"^(-1)], 
     Unit[1, "Yoctometer"^(-1)]}
 
DimensionSelect["Roman", "Angle"] = {}
 
DimensionSelect["Roman", "Area"] = {Unit[1, "RomanAcre"], 
     Unit[1, "RomanAuneOfFurrows"], Unit[1, "RomanCenturie"], 
     Unit[1, "RomanMorn"], Unit[1, "RomanQuadriplex"], Unit[1, "RomanRood"], 
     Unit[1, "RomanYoke"]}
 
DimensionSelect["Roman", "Capacitance"] = {}
 
DimensionSelect["Roman", "Charge"] = {}
 
DimensionSelect["Roman", "Current"] = {}
 
DimensionSelect["Roman", "Data"] = {}
 
DimensionSelect["Roman", "Energy"] = {}
 
DimensionSelect["Roman", "Force"] = {}
 
DimensionSelect["Roman", "Frequency"] = {}
 
DimensionSelect["Roman", "Inductance"] = {}
 
DimensionSelect["Roman", "Length"] = 
    {Unit[1, "RomanDigit"], Unit[1, "RomanInch"], Unit[1, "RomanPalm"], 
     Unit[1, "RomanFoot"], Unit[1, "RomanCubit"], Unit[1, "RomanStep"], 
     Unit[1, "RomanPace"], Unit[1, "RomanPerch"], Unit[1, "RomanArpent"], 
     Unit[1, "RomanStadium"], Unit[1, "RomanMile"], Unit[1, "RomanLeague"]}
 
DimensionSelect["Roman", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Roman", "Magnetic Field Strength"] = {}
 
DimensionSelect["Roman", "Magnetic Induction"] = {}
 
DimensionSelect["Roman", "Mass"] = {Unit[1, "RomanChalcus"], 
     Unit[1, "RomanSiliqua"], Unit[1, "RomanObolus"], 
     Unit[1, "RomanScruple"], Unit[1, "RomanDram"], Unit[1, "RomanShekel"], 
     Unit[1, "RomanOunce"], Unit[1, "RomanPound"], Unit[1, "RomanMine"]}
 
DimensionSelect["Roman", "Power"] = {}
 
DimensionSelect["Roman", "Pressure"] = {}
 
DimensionSelect["Roman", "Resistance"] = {}
 
DimensionSelect["Roman", "Resistivity"] = {}
 
DimensionSelect["Roman", "Time"] = {}
 
DimensionSelect["Roman", "Velocity"] = {}
 
DimensionSelect["Roman", "Viscosity"] = {}
 
DimensionSelect["Roman", "Voltage"] = {}
 
DimensionSelect["Roman", "Volume"] = 
    {Unit[1, "RomanSpoonful"], Unit[1, "RomanDose"], 
     Unit[1, "RomanDrawingSpoon"], Unit[1, "RomanSixthSester"], 
     Unit[1, "RomanQuarterSpoon"], Unit[1, "RomanThirdSester"], 
     Unit[1, "RomanDryHalfSester"], Unit[1, "RomanHalfSester"], 
     Unit[1, "RomanDoubleThirdSester"], Unit[1, "RomanDrySester"], 
     Unit[1, "RomanSester"], Unit[1, "RomanCongius"], Unit[1, "RomanGallon"], 
     Unit[1, "RomanPeck"], Unit[1, "RomanUrn"], Unit[1, "RomanBushel"], 
     Unit[1, "RomanJar"], Unit[1, "RomanHose"]}
 
DimensionSelect["Roman", "Wavenumber"] = {}
 
DimensionSelect["Russian", "Angle"] = {}
 
DimensionSelect["Russian", "Area"] = 
    {Unit[1, "OfficialDesiatina"], Unit[1, "PropriatorsDesiatina"]}
 
DimensionSelect["Russian", "Capacitance"] = {}
 
DimensionSelect["Russian", "Charge"] = {}
 
DimensionSelect["Russian", "Current"] = {}
 
DimensionSelect["Russian", "Data"] = {}
 
DimensionSelect["Russian", "Energy"] = {}
 
DimensionSelect["Russian", "Force"] = {}
 
DimensionSelect["Russian", "Frequency"] = {}
 
DimensionSelect["Russian", "Inductance"] = {}
 
DimensionSelect["Russian", "Length"] = 
    {Unit[1, "Tochka"], Unit[1, "Liniya"], Unit[1, "Diuym"], 
     Unit[1, "Vershok"], Unit[1, "Piad"], Unit[1, "Fut"], Unit[1, "Arshin"], 
     Unit[1, "Sazhen"], Unit[1, "Versta"], Unit[1, "Milia"]}
 
DimensionSelect["Russian", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Russian", "Magnetic Field Strength"] = {}
 
DimensionSelect["Russian", "Magnetic Induction"] = {}
 
DimensionSelect["Russian", "Mass"] = 
    {Unit[1, "Dolia"], Unit[1, "Zolotnik"], Unit[1, "Lot"], Unit[1, "Funt"], 
     Unit[1, "Pood"], Unit[1, "Berkovets"]}
 
DimensionSelect["Russian", "Power"] = {}
 
DimensionSelect["Russian", "Pressure"] = {}
 
DimensionSelect["Russian", "Resistance"] = {}
 
DimensionSelect["Russian", "Resistivity"] = {}
 
DimensionSelect["Russian", "Time"] = {}
 
DimensionSelect["Russian", "Velocity"] = {}
 
DimensionSelect["Russian", "Viscosity"] = {}
 
DimensionSelect["Russian", "Voltage"] = {}
 
DimensionSelect["Russian", "Volume"] = 
    {Unit[1, "Shkalik"], Unit[1, "Chast"], Unit[1, "Charka"], 
     Unit[1, "ButylkaVodochnaya"], Unit[1, "ButylkaVinnaya"], 
     Unit[1, "LiquidKruzhka"], Unit[1, "DryKruzhka"], 
     Unit[1, "LiquidChetvert"], Unit[1, "Garnets"], Unit[1, "LiquidVedro"], 
     Unit[1, "DryVedro"], Unit[1, "Chetverik"], Unit[1, "Osmina"], 
     Unit[1, "DryChetvert"], Unit[1, "Bochka"]}
 
DimensionSelect["Russian", "Wavenumber"] = {}
 
DimensionSelect["Scottish", "Angle"] = {}
 
DimensionSelect["Scottish", "Area"] = 
    {Unit[1, "Inch"^2], Unit[1, "ScottishEll"^2], Unit[1, "Fall"^2], 
     Unit[1, "Rood"], Unit[1, "Acre"], Unit[1, "Oxgang"], 
     Unit[1, "Ploughgate"], Unit[1, "Daugh"]}
 
DimensionSelect["Scottish", "Capacitance"] = {}
 
DimensionSelect["Scottish", "Charge"] = {}
 
DimensionSelect["Scottish", "Current"] = {}
 
DimensionSelect["Scottish", "Data"] = {}
 
DimensionSelect["Scottish", "Energy"] = {}
 
DimensionSelect["Scottish", "Force"] = {}
 
DimensionSelect["Scottish", "Frequency"] = {}
 
DimensionSelect["Scottish", "Inductance"] = {}
 
DimensionSelect["Scottish", "Length"] = 
    {Unit[1, "Foot"], Unit[1, "Yard"], Unit[1, "ScottishEll"], 
     Unit[1, "Fall"], Unit[1, "ScottishMile"]}
 
DimensionSelect["Scottish", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Scottish", "Magnetic Field Strength"] = {}
 
DimensionSelect["Scottish", "Magnetic Induction"] = {}
 
DimensionSelect["Scottish", "Mass"] = 
    {Unit[1, "Ounce"], Unit[1, "Pound"], Unit[1, "Stone"]}
 
DimensionSelect["Scottish", "Power"] = {}
 
DimensionSelect["Scottish", "Pressure"] = {}
 
DimensionSelect["Scottish", "Resistance"] = {}
 
DimensionSelect["Scottish", "Resistivity"] = {}
 
DimensionSelect["Scottish", "Time"] = {}
 
DimensionSelect["Scottish", "Velocity"] = {}
 
DimensionSelect["Scottish", "Viscosity"] = {}
 
DimensionSelect["Scottish", "Voltage"] = {}
 
DimensionSelect["Scottish", "Volume"] = 
    {Unit[1, "Drop"], Unit[1, "Mutchkins"], Unit[1, "Chopin"], 
     Unit[1, "ScottishPint"], Unit[1, "ScottishGallon"]}
 
DimensionSelect["Scottish", "Wavenumber"] = {}
 
DimensionSelect["SI", "Angle"] = {Unit[1, "Radian"]}
 
DimensionSelect["SI", "Area"] = {Unit[1, "Meter"^2]}
 
DimensionSelect["SI", "Capacitance"] = {Unit[1, "Farad"]}
 
DimensionSelect["SI", "Charge"] = {Unit[1, "Coulomb"]}
 
DimensionSelect["SI", "Current"] = {Unit[1, "Ampere"]}
 
DimensionSelect["SI", "Data"] = {Unit[1, "Bit"]}
 
DimensionSelect["SI", "Energy"] = {Unit[1, "Joule"]}
 
DimensionSelect["SI", "Force"] = {Unit[1, "Newton"]}
 
DimensionSelect["SI", "Frequency"] = {Unit[1, "Hertz"]}
 
DimensionSelect["SI", "Inductance"] = {Unit[1, "Henry"]}
 
DimensionSelect["SI", "Length"] = {Unit[1, "Meter"]}
 
DimensionSelect["SI", "Magnetic Dipole Moment"] = 
    {Unit[1, "Ampere"*"Meter"^2]}
 
DimensionSelect["SI", "Magnetic Field Strength"] = 
    {Unit[1, "Volt"/"Meter"]}
 
DimensionSelect["SI", "Magnetic Induction"] = {Unit[1, "Tesla"]}
 
DimensionSelect["SI", "Mass"] = {Unit[1, "Kilogram"]}
 
DimensionSelect["SI", "Power"] = {Unit[1, "Watt"]}
 
DimensionSelect["SI", "Pressure"] = {Unit[1, "Pascal"]}
 
DimensionSelect["SI", "Resistance"] = {Unit[1, "Ohm"]}
 
DimensionSelect["SI", "Resistivity"] = {Unit[1, "Meter"*"Ohm"]}
 
DimensionSelect["SI", "Time"] = {Unit[1, "Second"]}
 
DimensionSelect["SI", "Velocity"] = {Unit[1, "Meter"/"Second"]}
 
DimensionSelect["SI", "Viscosity"] = 
    {Unit[1, "Pascal"*"Second"]}
 
DimensionSelect["SI", "Voltage"] = {Unit[1, "Volt"]}
 
DimensionSelect["SI", "Volume"] = {Unit[1, "Meter"^3]}
 
DimensionSelect["SI", "Wavenumber"] = {Unit[1, "Meter"^(-1)]}
 
DimensionSelect["Spanish", "Angle"] = {}
 
DimensionSelect["Spanish", "Area"] = {}
 
DimensionSelect["Spanish", "Capacitance"] = {}
 
DimensionSelect["Spanish", "Charge"] = {}
 
DimensionSelect["Spanish", "Current"] = {}
 
DimensionSelect["Spanish", "Data"] = {}
 
DimensionSelect["Spanish", "Energy"] = {}
 
DimensionSelect["Spanish", "Force"] = {}
 
DimensionSelect["Spanish", "Frequency"] = {}
 
DimensionSelect["Spanish", "Inductance"] = {}
 
DimensionSelect["Spanish", "Length"] = 
    {Unit[1, "Punto"], Unit[1, "Linea"], Unit[1, "Pulgada"], Unit[1, "Coto"], 
     Unit[1, "Palmo"], Unit[1, "Pie"], Unit[1, "Vara"], Unit[1, "Paso"], 
     Unit[1, "Legua"], Unit[1, "Labor"]}
 
DimensionSelect["Spanish", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Spanish", "Magnetic Field Strength"] = {}
 
DimensionSelect["Spanish", "Magnetic Induction"] = {}
 
DimensionSelect["Spanish", "Mass"] = {}
 
DimensionSelect["Spanish", "Power"] = {}
 
DimensionSelect["Spanish", "Pressure"] = {}
 
DimensionSelect["Spanish", "Resistance"] = {}
 
DimensionSelect["Spanish", "Resistivity"] = {}
 
DimensionSelect["Spanish", "Time"] = {}
 
DimensionSelect["Spanish", "Velocity"] = {}
 
DimensionSelect["Spanish", "Viscosity"] = {}
 
DimensionSelect["Spanish", "Voltage"] = {}
 
DimensionSelect["Spanish", "Volume"] = {}
 
DimensionSelect["Spanish", "Wavenumber"] = {}
 
DimensionSelect["Survey", "Angle"] = {}
 
DimensionSelect["Survey", "Area"] = {Unit[1, "SurveyAcre"], 
     Unit[1, "Section"], Unit[1, "Township"]}
 
DimensionSelect["Survey", "Capacitance"] = {}
 
DimensionSelect["Survey", "Charge"] = {}
 
DimensionSelect["Survey", "Current"] = {}
 
DimensionSelect["Survey", "Data"] = {}
 
DimensionSelect["Survey", "Energy"] = {}
 
DimensionSelect["Survey", "Force"] = {}
 
DimensionSelect["Survey", "Frequency"] = {}
 
DimensionSelect["Survey", "Inductance"] = {}
 
DimensionSelect["Survey", "Length"] = 
    {Unit[1, "Link"], Unit[1, "SurveyFoot"], Unit[1, "Rod"], 
     Unit[1, "Chain"], Unit[1, "SurveyMile"], Unit[1, "League"]}
 
DimensionSelect["Survey", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Survey", "Magnetic Field Strength"] = {}
 
DimensionSelect["Survey", "Magnetic Induction"] = {}
 
DimensionSelect["Survey", "Mass"] = {}
 
DimensionSelect["Survey", "Power"] = {}
 
DimensionSelect["Survey", "Pressure"] = {}
 
DimensionSelect["Survey", "Resistance"] = {}
 
DimensionSelect["Survey", "Resistivity"] = {}
 
DimensionSelect["Survey", "Time"] = {}
 
DimensionSelect["Survey", "Velocity"] = {}
 
DimensionSelect["Survey", "Viscosity"] = {}
 
DimensionSelect["Survey", "Voltage"] = {}
 
DimensionSelect["Survey", "Volume"] = {}
 
DimensionSelect["Survey", "Wavenumber"] = {}
 
DimensionSelect["Swedish", "Angle"] = {}
 
DimensionSelect["Swedish", "Area"] = 
    {Unit[1, "Kvadratmil"], Unit[1, "Kannaland"], Unit[1, "Kappland"], 
     Unit[1, "Spannland"], Unit[1, "Tunnland"]}
 
DimensionSelect["Swedish", "Capacitance"] = {}
 
DimensionSelect["Swedish", "Charge"] = {}
 
DimensionSelect["Swedish", "Current"] = {}
 
DimensionSelect["Swedish", "Data"] = {}
 
DimensionSelect["Swedish", "Energy"] = {}
 
DimensionSelect["Swedish", "Force"] = {}
 
DimensionSelect["Swedish", "Frequency"] = {}
 
DimensionSelect["Swedish", "Inductance"] = {}
 
DimensionSelect["Swedish", "Length"] = 
    {Unit[1, "Fjardingsvag"], Unit[1, "SwedishLinje"], Unit[1, "Tum"], 
     Unit[1, "SwedishKvarter"], Unit[1, "SwedishFot"], Unit[1, "Tvarhand"], 
     Unit[1, "Aln"], Unit[1, "Famn"], Unit[1, "SwedishStang"], 
     Unit[1, "Ref"], Unit[1, "Stenkast"], Unit[1, "Kabellangd"], 
     Unit[1, "SwedishKvartmil"], Unit[1, "Skogsmil"], 
     Unit[1, "SwedishSjomil"], Unit[1, "Nymil"], Unit[1, "SwedishMil"], 
     Unit[1, "Kyndemil"]}
 
DimensionSelect["Swedish", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Swedish", "Magnetic Field Strength"] = {}
 
DimensionSelect["Swedish", "Magnetic Induction"] = {}
 
DimensionSelect["Swedish", "Mass"] = 
    {Unit[1, "SwedishOrt"], Unit[1, "Mark"], Unit[1, "Skalpund"], 
     Unit[1, "SwedishBismerpund"], Unit[1, "Lispund"], Unit[1, "Skeppspund"]}
 
DimensionSelect["Swedish", "Power"] = {}
 
DimensionSelect["Swedish", "Pressure"] = {}
 
DimensionSelect["Swedish", "Resistance"] = {}
 
DimensionSelect["Swedish", "Resistivity"] = {}
 
DimensionSelect["Swedish", "Time"] = {}
 
DimensionSelect["Swedish", "Velocity"] = {}
 
DimensionSelect["Swedish", "Viscosity"] = {}
 
DimensionSelect["Swedish", "Voltage"] = {}
 
DimensionSelect["Swedish", "Volume"] = 
    {Unit[1, "Pot"], Unit[1, "Ankare"], Unit[1, "SwedishOhm"], 
     Unit[1, "Storfavn"], Unit[1, "Kubikkfavn"]}
 
DimensionSelect["Swedish", "Wavenumber"] = {}
 
DimensionSelect["Taiwanese", "Angle"] = {}
 
DimensionSelect["Taiwanese", "Area"] = 
    {Unit[1, "Pheng"], Unit[1, "Bo"], Unit[1, "Le"], Unit[1, "Kah"]}
 
DimensionSelect["Taiwanese", "Capacitance"] = {}
 
DimensionSelect["Taiwanese", "Charge"] = {}
 
DimensionSelect["Taiwanese", "Current"] = {}
 
DimensionSelect["Taiwanese", "Data"] = {}
 
DimensionSelect["Taiwanese", "Energy"] = {}
 
DimensionSelect["Taiwanese", "Force"] = {}
 
DimensionSelect["Taiwanese", "Frequency"] = {}
 
DimensionSelect["Taiwanese", "Inductance"] = {}
 
DimensionSelect["Taiwanese", "Length"] = 
    {Unit[1, "Chhun"], Unit[1, "Chhioh"]}
 
DimensionSelect["Taiwanese", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Taiwanese", "Magnetic Field Strength"] = {}
 
DimensionSelect["Taiwanese", "Magnetic Induction"] = {}
 
DimensionSelect["Taiwanese", "Mass"] = 
    {Unit[1, "Cash"], Unit[1, "Candareen"], Unit[1, "Mace"], Unit[1, "Tael"], 
     Unit[1, "Catty"], Unit[1, "Picul"]}
 
DimensionSelect["Taiwanese", "Power"] = {}
 
DimensionSelect["Taiwanese", "Pressure"] = {}
 
DimensionSelect["Taiwanese", "Resistance"] = {}
 
DimensionSelect["Taiwanese", "Resistivity"] = {}
 
DimensionSelect["Taiwanese", "Time"] = {}
 
DimensionSelect["Taiwanese", "Velocity"] = {}
 
DimensionSelect["Taiwanese", "Viscosity"] = {}
 
DimensionSelect["Taiwanese", "Voltage"] = {}
 
DimensionSelect["Taiwanese", "Volume"] = {Unit[1, "Meter"^3]}
 
DimensionSelect["Taiwanese", "Wavenumber"] = {}
 
DimensionSelect["Troy", "Angle"] = {}
 
DimensionSelect["Troy", "Area"] = {}
 
DimensionSelect["Troy", "Capacitance"] = {}
 
DimensionSelect["Troy", "Charge"] = {}
 
DimensionSelect["Troy", "Current"] = {}
 
DimensionSelect["Troy", "Data"] = {}
 
DimensionSelect["Troy", "Energy"] = {}
 
DimensionSelect["Troy", "Force"] = {}
 
DimensionSelect["Troy", "Frequency"] = {}
 
DimensionSelect["Troy", "Inductance"] = {}
 
DimensionSelect["Troy", "Length"] = {}
 
DimensionSelect["Troy", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["Troy", "Magnetic Field Strength"] = {}
 
DimensionSelect["Troy", "Magnetic Induction"] = {}
 
DimensionSelect["Troy", "Mass"] = {Unit[1, "Grain"], 
     Unit[1, "Pennyweight"], Unit[1, "TroyOunce"], Unit[1, "TroyPound"]}
 
DimensionSelect["Troy", "Power"] = {}
 
DimensionSelect["Troy", "Pressure"] = {}
 
DimensionSelect["Troy", "Resistance"] = {}
 
DimensionSelect["Troy", "Resistivity"] = {}
 
DimensionSelect["Troy", "Time"] = {}
 
DimensionSelect["Troy", "Velocity"] = {}
 
DimensionSelect["Troy", "Viscosity"] = {}
 
DimensionSelect["Troy", "Voltage"] = {}
 
DimensionSelect["Troy", "Volume"] = {}
 
DimensionSelect["Troy", "Wavenumber"] = {}
 
DimensionSelect["USCustomary", "Angle"] = {Unit[1, "Degree"]}
 
DimensionSelect["USCustomary", "Area"] = 
    {Unit[1, "Foot"^2], Unit[1, "Chain"^2], Unit[1, "Acre"], 
     Unit[1, "SurveyAcre"], Unit[1, "Section"], Unit[1, "Township"]}
 
DimensionSelect["USCustomary", "Capacitance"] = {}
 
DimensionSelect["USCustomary", "Charge"] = {}
 
DimensionSelect["USCustomary", "Current"] = {}
 
DimensionSelect["USCustomary", "Data"] = {}
 
DimensionSelect["USCustomary", "Energy"] = 
    {Unit[1, "Calorie"], Unit[1, "BritishThermalUnit"]}
 
DimensionSelect["USCustomary", "Force"] = 
    {Unit[1, "PoundForce"]}
 
DimensionSelect["USCustomary", "Frequency"] = {}
 
DimensionSelect["USCustomary", "Inductance"] = {}
 
DimensionSelect["USCustomary", "Length"] = 
    {Unit[1, "Inch"], Unit[1, "Hand"], Unit[1, "Link"], Unit[1, "Foot"], 
     Unit[1, "SurveyFoot"], Unit[1, "Yard"], Unit[1, "Fathom"], 
     Unit[1, "Rod"], Unit[1, "Chain"], Unit[1, "Cable"], Unit[1, "Mile"], 
     Unit[1, "SurveyMile"], Unit[1, "NauticalMile"], Unit[1, "League"]}
 
DimensionSelect["USCustomary", "Magnetic Dipole Moment"] = {}
 
DimensionSelect["USCustomary", "Magnetic Field Strength"] = {}
 
DimensionSelect["USCustomary", "Magnetic Induction"] = {}
 
DimensionSelect["USCustomary", "Mass"] = 
    {Unit[1, "Grain"], Unit[1, "Pennyweight"], Unit[1, "Dram"], 
     Unit[1, "Ounce"], Unit[1, "TroyOunce"], Unit[1, "TroyPound"], 
     Unit[1, "Pound"], Unit[1, "ShortHundredweight"], Unit[1, "ShortTon"]}
 
DimensionSelect["USCustomary", "Power"] = 
    {Unit[1, "Horsepower"]}
 
DimensionSelect["USCustomary", "Pressure"] = {Unit[1, "PSI"]}
 
DimensionSelect["USCustomary", "Resistance"] = {}
 
DimensionSelect["USCustomary", "Resistivity"] = {}
 
DimensionSelect["USCustomary", "Time"] = 
    {Unit[1, "Second"], Unit[1, "Minute"], Unit[1, "Hour"], Unit[1, "Day"], 
     Unit[1, "Week"], Unit[1, "Month"], Unit[1, "Year"]}
 
DimensionSelect["USCustomary", "Velocity"] = 
    {Unit[1, "Mile"/"Hour"]}
 
DimensionSelect["USCustomary", "Viscosity"] = {}
 
DimensionSelect["USCustomary", "Voltage"] = {}
 
DimensionSelect["USCustomary", "Volume"] = 
    {Unit[1, "FluidDram"], Unit[1, "Teaspoon"], Unit[1, "Tablespoon"], 
     Unit[1, "Inch"^3], Unit[1, "Jigger"], Unit[1, "USGill"], 
     Unit[1, "Pint"], Unit[1, "DryPint"], Unit[1, "Quart"], 
     Unit[1, "DryQuart"], Unit[1, "BoardFoot"], Unit[1, "Gallon"], 
     Unit[1, "DryGallon"], Unit[1, "Peck"], Unit[1, "Foot"^3], 
     Unit[1, "Bushel"], Unit[1, "DryBarrel"], Unit[1, "Barrel"], 
     Unit[1, "OilBarrel"], Unit[1, "Hogshead"], Unit[1, "Yard"^3], 
     Unit[1, "Acre"*"Foot"]}
 
DimensionSelect["USCustomary", "Wavenumber"] = {}
 
DimensionSelect[set_, dim_] := 
    DimensionSelect[set, dim] = 
     CompatibleUnitsFromSet[set, 
      dim /. $DimensionRepresentatives]
 
 
CompatibleUnitsFromSet["All", Unit[1, "Ampere"]] = 
    {Unit[1, "Yoctoampere"], Unit[1, "Zeptoampere"], Unit[1, "Attoampere"], 
     Unit[1, "Femtoampere"], Unit[1, "Picoampere"], Unit[1, "Statampere"], 
     Unit[1, "Nanoampere"], Unit[1, "Microampere"], Unit[1, "Milliampere"], 
     Unit[1, "Centiampere"], Unit[1, "Deciampere"], Unit[1, "Amp"], 
     Unit[1, "Ampere"], Unit[1, "Abampere"], Unit[1, "Biot"], 
     Unit[1, "Decaampere"], Unit[1, "Hectoampere"], Unit[1, "Kiloampere"], 
     Unit[1, "Megaampere"], Unit[1, "Gigaampere"], Unit[1, "Teraampere"], 
     Unit[1, "Petaampere"], Unit[1, "Exaampere"], Unit[1, "Zettaampere"], 
     Unit[1, "Yottaampere"], Unit[1, "PlanckCurrent"], Unit[1, "Gilbert"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Byte"]] = 
    {Unit[1, "Bit"], Unit[1, "Nibble"], Unit[1, "Byte"], Unit[1, "ByteUnit"], 
     Unit[1, "Kibibit"], Unit[1, "Kibibyte"], Unit[1, "Mebibit"], 
     Unit[1, "Mebibyte"], Unit[1, "Gibibit"], Unit[1, "Gibibyte"], 
     Unit[1, "Tebibit"], Unit[1, "Tebibyte"], Unit[1, "Pebibit"], 
     Unit[1, "Pebibyte"], Unit[1, "Exbibit"], Unit[1, "Exbibyte"], 
     Unit[1, "Zebibit"], Unit[1, "Zebibyte"], Unit[1, "Yobibit"], 
     Unit[1, "Yobibyte"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Coulomb"]] = 
    {Unit[1, "Yoctocoulomb"], Unit[1, "Zeptocoulomb"], 
     Unit[1, "ElementaryCharge"], Unit[1, "Attocoulomb"], 
     Unit[1, "PlanckCharge"], Unit[1, "Femtocoulomb"], 
     Unit[1, "Picocoulomb"], Unit[1, "Franklin"], Unit[1, "Statcoulomb"], 
     Unit[1, "Nanocoulomb"], Unit[1, "Microcoulomb"], 
     Unit[1, "Millicoulomb"], Unit[1, "Centicoulomb"], 
     Unit[1, "Decicoulomb"], Unit[1, "Coulomb"], Unit[1, "Abcoulomb"], 
     Unit[1, "Decacoulomb"], Unit[1, "Hectocoulomb"], Unit[1, "Kilocoulomb"], 
     Unit[1, "Megacoulomb"], Unit[1, "Gigacoulomb"], Unit[1, "Teracoulomb"], 
     Unit[1, "Petacoulomb"], Unit[1, "Exacoulomb"], Unit[1, "Zettacoulomb"], 
     Unit[1, "Yottacoulomb"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Farad"]] = 
    {Unit[1, "Yoctofarad"], Unit[1, "Zeptofarad"], Unit[1, "Attofarad"], 
     Unit[1, "Femtofarad"], Unit[1, "Picofarad"], Unit[1, "Statfarad"], 
     Unit[1, "Nanofarad"], Unit[1, "Microfarad"], Unit[1, "Millifarad"], 
     Unit[1, "Centifarad"], Unit[1, "Decifarad"], Unit[1, "Farad"], 
     Unit[1, "Decafarad"], Unit[1, "Hectofarad"], Unit[1, "Kilofarad"], 
     Unit[1, "Megafarad"], Unit[1, "Abfarad"], Unit[1, "Gigafarad"], 
     Unit[1, "Terafarad"], Unit[1, "Petafarad"], Unit[1, "Exafarad"], 
     Unit[1, "Zettafarad"], Unit[1, "Yottafarad"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Henry"]] = 
    {Unit[1, "Yoctohenry"], Unit[1, "Zeptohenry"], Unit[1, "Attohenry"], 
     Unit[1, "Femtohenry"], Unit[1, "Picohenry"], Unit[1, "Abhenry"], 
     Unit[1, "Nanohenry"], Unit[1, "Microhenry"], Unit[1, "Millihenry"], 
     Unit[1, "Centihenry"], Unit[1, "Decihenry"], Unit[1, "Henry"], 
     Unit[1, "Decahenry"], Unit[1, "Hectohenry"], Unit[1, "Kilohenry"], 
     Unit[1, "Megahenry"], Unit[1, "Gigahenry"], Unit[1, "Stathenry"], 
     Unit[1, "Terahenry"], Unit[1, "Petahenry"], Unit[1, "Exahenry"], 
     Unit[1, "Zettahenry"], Unit[1, "Yottahenry"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Hertz"]] = 
    {Unit[1, "Yoctohertz"], Unit[1, "Zeptohertz"], Unit[1, "Attohertz"], 
     Unit[1, "Femtohertz"], Unit[1, "Picohertz"], Unit[1, "Nanohertz"], 
     Unit[1, "Microhertz"], Unit[1, "Millihertz"], Unit[1, "Centihertz"], 
     Unit[1, "Decihertz"], Unit[1, "Becquerel"], Unit[1, "Hertz"], 
     Unit[1, "Decahertz"], Unit[1, "Hectohertz"], Unit[1, "Kilohertz"], 
     Unit[1, "Megahertz"], Unit[1, "Rutherford"], Unit[1, "Gigahertz"], 
     Unit[1, "Curie"], Unit[1, "Terahertz"], Unit[1, "Petahertz"], 
     Unit[1, "Exahertz"], Unit[1, "Zettahertz"], Unit[1, "Yottahertz"], 
     Unit[1, "PlanckAngularFrequency"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Joule"]] = 
    {Unit[1, "Yoctojoule"], Unit[1, "Zeptojoule"], Unit[1, "ElectronVolt"], 
     Unit[1, "Attojoule"], Unit[1, "Rydberg"], Unit[1, "HartreeEnergy"], 
     Unit[1, "Femtojoule"], Unit[1, "Picojoule"], Unit[1, "Nanojoule"], 
     Unit[1, "Erg"], Unit[1, "Microjoule"], Unit[1, "Millijoule"], 
     Unit[1, "Centijoule"], Unit[1, "Decijoule"], Unit[1, "Joule"], 
     Unit[1, "Calorie"], Unit[1, "Decajoule"], Unit[1, "Hectojoule"], 
     Unit[1, "Kilojoule"], Unit[1, "BritishThermalUnit"], Unit[1, "BTU"], 
     Unit[1, "Megajoule"], Unit[1, "Therm"], Unit[1, "Gigajoule"], 
     Unit[1, "PlanckEnergy"], Unit[1, "Terajoule"], Unit[1, "Petajoule"], 
     Unit[1, "Exajoule"], Unit[1, "Zettajoule"], Unit[1, "Yottajoule"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Kilogram"]] = 
    {Unit[1, "ElectronRestMass"], Unit[1, "AMU"], Unit[1, "AtomicMassUnit"], 
     Unit[1, "Dalton"], Unit[1, "PlanckMass"], Unit[1, "Cash"], 
     Unit[1, "Dolia"], Unit[1, "Grain"], Unit[1, "RomanChalcus"], 
     Unit[1, "RomanSiliqua"], Unit[1, "Carat"], Unit[1, "Candareen"], 
     Unit[1, "Fun"], Unit[1, "RomanObolus"], Unit[1, "Obolos"], 
     Unit[1, "NorwegianOrt"], Unit[1, "Gram"], Unit[1, "RomanScruple"], 
     Unit[1, "Pennyweight"], Unit[1, "Dram"], Unit[1, "RomanDram"], 
     Unit[1, "Mace"], Unit[1, "Momme"], Unit[1, "SwedishOrt"], 
     Unit[1, "Zolotnik"], Unit[1, "Drachma"], Unit[1, "RomanShekel"], 
     Unit[1, "Lot"], Unit[1, "Shekel"], Unit[1, "Uqija"], 
     Unit[1, "MaltaAwqiyyah"], Unit[1, "RomanOunce"], 
     Unit[1, "AvoirdupoisOunce"], Unit[1, "Ounce"], Unit[1, "AssayTon"], 
     Unit[1, "TroyOunce"], Unit[1, "EgyptianAwqiyyah"], Unit[1, "Tael"], 
     Unit[1, "Kwart"], Unit[1, "Mark"], Unit[1, "BeirutAwqiyyah"], 
     Unit[1, "JerusalemAwqiyyah"], Unit[1, "Merke"], 
     Unit[1, "Aleppowqiyyah"], Unit[1, "Pondus"], Unit[1, "Libra"], 
     Unit[1, "RomanPound"], Unit[1, "TroyPound"], Unit[1, "Hyakume"], 
     Unit[1, "Funt"], Unit[1, "Skalpund"], Unit[1, "Mina"], 
     Unit[1, "RomanMine"], Unit[1, "AvoirdupoisPound"], Unit[1, "Pound"], 
     Unit[1, "Pund"], Unit[1, "Catty"], Unit[1, "Kin"], Unit[1, "Kati"], 
     Unit[1, "Ratal"], Unit[1, "Qsima"], Unit[1, "Kilogram"], Unit[1, "Kan"], 
     Unit[1, "Kanme"], Unit[1, "Wizna"], Unit[1, "SwedishBismerpund"], 
     Unit[1, "Stone"], Unit[1, "NorwegianBismerpund"], Unit[1, "Lispund"], 
     Unit[1, "Geepound"], Unit[1, "Slug"], Unit[1, "Pood"], Unit[1, "Laup"], 
     Unit[1, "Spann"], Unit[1, "Vag"], Unit[1, "Talent"], Unit[1, "Cental"], 
     Unit[1, "NetHundredweight"], Unit[1, "ShortHundredweight"], 
     Unit[1, "GrossHundredweight"], Unit[1, "Hundredweight"], 
     Unit[1, "Picul"], Unit[1, "Pikul"], Unit[1, "Qantar"], 
     Unit[1, "Quintal"], Unit[1, "Wey"], Unit[1, "Skippund"], 
     Unit[1, "Berkovets"], Unit[1, "Skeppspund"], Unit[1, "Bale"], 
     Unit[1, "Pezata"], Unit[1, "ShortTon"], Unit[1, "Ton"], 
     Unit[1, "MetricTon"], Unit[1, "Tonne"], Unit[1, "LongTon"], 
     Unit[1, "EarthMass"], Unit[1, "JupiterMass"], Unit[1, "SolarMass"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Meter"^(-1)]] = 
    {Unit[1, "Diopter"], Unit[1, "Kayser"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Meter"]] = 
    {Unit[1, "PlanckLength"], Unit[1, "Yoctometer"], Unit[1, "Zeptometer"], 
     Unit[1, "Attometer"], Unit[1, "Femtometer"], Unit[1, "Fermi"], 
     Unit[1, "XUnit"], Unit[1, "Picometer"], Unit[1, "BohrRadius"], 
     Unit[1, "Angstrom"], Unit[1, "Nanometer"], Unit[1, "Micrometer"], 
     Unit[1, "Micron"], Unit[1, "Mo"], Unit[1, "PrintersPoint"], 
     Unit[1, "Fjardingsvag"], Unit[1, "Mil"], Unit[1, "Thou"], 
     Unit[1, "Rin"], Unit[1, "Punto"], Unit[1, "Skrupel"], 
     Unit[1, "Caliber"], Unit[1, "Tochka"], Unit[1, "Bu"], Unit[1, "Point"], 
     Unit[1, "PointLength"], Unit[1, "Didot"], Unit[1, "DidotPoint"], 
     Unit[1, "Millimeter"], Unit[1, "Linea"], Unit[1, "NorwegianLinje"], 
     Unit[1, "Liniya"], Unit[1, "SwedishLinje"], Unit[1, "Sun"], 
     Unit[1, "Pica"], Unit[1, "Cicero"], Unit[1, "Centimeter"], 
     Unit[1, "RomanDigit"], Unit[1, "AnthropicDigit"], Unit[1, "Assba"], 
     Unit[1, "Pulzier"], Unit[1, "Pulgada"], Unit[1, "RomanInch"], 
     Unit[1, "AnthropicInch"], Unit[1, "Diuym"], Unit[1, "Inch"], 
     Unit[1, "Tomme"], Unit[1, "Tum"], Unit[1, "Chhun"], Unit[1, "Shaku"], 
     Unit[1, "Vershok"], Unit[1, "RomanPalm"], Unit[1, "Palm"], 
     Unit[1, "Cabda"], Unit[1, "Decimeter"], Unit[1, "Hand"], 
     Unit[1, "Handbreadth"], Unit[1, "Coto"], Unit[1, "Fitel"], 
     Unit[1, "SwedishKvarter"], Unit[1, "Shaftment"], 
     Unit[1, "NorwegianKvarter"], Unit[1, "Piad"], Unit[1, "Hiro"], 
     Unit[1, "Ken"], Unit[1, "Link"], Unit[1, "Palmo"], Unit[1, "Span"], 
     Unit[1, "SpanLength"], Unit[1, "Xiber"], Unit[1, "SwedishFot"], 
     Unit[1, "Pie"], Unit[1, "RomanFoot"], Unit[1, "Chhioh"], 
     Unit[1, "JoLength"], Unit[1, "Ja"], Unit[1, "AnthropicFoot"], 
     Unit[1, "Feet"], Unit[1, "Foot"], Unit[1, "Fut"], Unit[1, "SurveyFoot"], 
     Unit[1, "NorwegianFot"], Unit[1, "ArabicFoot"], Unit[1, "Tvarhand"], 
     Unit[1, "RomanCubit"], Unit[1, "Cubit"], Unit[1, "Arsh"], 
     Unit[1, "Aln"], Unit[1, "Alen"], Unit[1, "FlemmishEll"], 
     Unit[1, "Arshin"], Unit[1, "RomanStep"], Unit[1, "PolishEll"], 
     Unit[1, "Vara"], Unit[1, "AnthropicYard"], Unit[1, "Yard"], 
     Unit[1, "ScottishEll"], Unit[1, "Meter"], Unit[1, "Ell"], 
     Unit[1, "Paso"], Unit[1, "Pace"], Unit[1, "RomanPace"], Unit[1, "Famn"], 
     Unit[1, "Fathom"], Unit[1, "Favn"], Unit[1, "Orgye"], Unit[1, "Qasba"], 
     Unit[1, "Sazhen"], Unit[1, "RomanPerch"], Unit[1, "NorwegianStang"], 
     Unit[1, "Qasab"], Unit[1, "SwedishStang"], Unit[1, "Perch"], 
     Unit[1, "Pole"], Unit[1, "Rod"], Unit[1, "Fall"], Unit[1, "Rope"], 
     Unit[1, "Decameter"], Unit[1, "ChoLength"], Unit[1, "Chain"], 
     Unit[1, "Ref"], Unit[1, "Las"], Unit[1, "RomanArpent"], Unit[1, "Bolt"], 
     Unit[1, "Stenkast"], Unit[1, "Hectometer"], Unit[1, "Skein"], 
     Unit[1, "Stadium"], Unit[1, "Kabellangd"], Unit[1, "RomanStadium"], 
     Unit[1, "Kabellengde"], Unit[1, "Stadion"], Unit[1, "Seir"], 
     Unit[1, "Furlong"], Unit[1, "Cable"], Unit[1, "Ghalva"], 
     Unit[1, "ReLength"], Unit[1, "Kilometer"], Unit[1, "Versta"], 
     Unit[1, "AnthropicMile"], Unit[1, "RomanMile"], Unit[1, "Mile"], 
     Unit[1, "StatuteMile"], Unit[1, "SurveyMile"], Unit[1, "ScottishMile"], 
     Unit[1, "NauticalMile"], Unit[1, "SwedishKvartmil"], 
     Unit[1, "NorwegianKvartmil"], Unit[1, "RomanLeague"], 
     Unit[1, "Fjerdingsvei"], Unit[1, "Legua"], Unit[1, "AnthropicLeague"], 
     Unit[1, "League"], Unit[1, "ArgentinianLeague"], 
     Unit[1, "BrazillianLeague"], Unit[1, "Skogsmil"], Unit[1, "Farasakh"], 
     Unit[1, "SwedishSjomil"], Unit[1, "Geografiskmil"], 
     Unit[1, "NorwegianSjomil"], Unit[1, "Milia"], Unit[1, "Nymil"], 
     Unit[1, "SwedishMil"], Unit[1, "NorwegianMil"], Unit[1, "Kyndemil"], 
     Unit[1, "Barid"], Unit[1, "Marhala"], Unit[1, "Labor"], 
     Unit[1, "Megameter"], Unit[1, "EarthRadius"], Unit[1, "LunarDistance"], 
     Unit[1, "Gigameter"], Unit[1, "AstronomicalUnit"], Unit[1, "AU"], 
     Unit[1, "Terameter"], Unit[1, "Petameter"], Unit[1, "LightYear"], 
     Unit[1, "Parsec"], Unit[1, "Exameter"], Unit[1, "Zettameter"], 
     Unit[1, "Yottameter"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Meter"^2]] = 
    {Unit[1, "PlanckArea"], Unit[1, "Barn"], Unit[1, "Kvadratmil"], 
     Unit[1, "PulzierKwadru"], Unit[1, "FitelKwadru"], Unit[1, "ShakuArea"], 
     Unit[1, "XiberKwadru"], Unit[1, "GoArea"], Unit[1, "JoArea"], 
     Unit[1, "Lumin"], Unit[1, "BuArea"], Unit[1, "Tsubo"], 
     Unit[1, "Pyeong"], Unit[1, "Pheng"], Unit[1, "QasbaKwadru"], 
     Unit[1, "KvadratRode"], Unit[1, "Mal"], Unit[1, "Kejla"], 
     Unit[1, "KejlaVolume"], Unit[1, "Tonneland"], Unit[1, "Kannaland"], 
     Unit[1, "Se"], Unit[1, "Bo"], Unit[1, "Are"], Unit[1, "SieghVolume"], 
     Unit[1, "Kappland"], Unit[1, "Ghabara"], Unit[1, "Siegh"], 
     Unit[1, "TanArea"], Unit[1, "Rood"], Unit[1, "Tomna"], 
     Unit[1, "RomanAcre"], Unit[1, "Le"], Unit[1, "Spannland"], 
     Unit[1, "Acre"], Unit[1, "AnthropicAcre"], Unit[1, "SurveyAcre"], 
     Unit[1, "Wejba"], Unit[1, "Kah"], Unit[1, "ChoArea"], 
     Unit[1, "Hectare"], Unit[1, "OfficialDesiatina"], Unit[1, "Modd"], 
     Unit[1, "ModdVolume"], Unit[1, "Oxgang"], 
     Unit[1, "PropriatorsDesiatina"], Unit[1, "Ploughgate"], 
     Unit[1, "Daugh"], Unit[1, "Section"], Unit[1, "Tunnland"], 
     Unit[1, "RomanAuneOfFurrows"], Unit[1, "RomanCenturie"], 
     Unit[1, "RomanMorn"], Unit[1, "RomanQuadriplex"], Unit[1, "RomanRood"], 
     Unit[1, "RomanYoke"], Unit[1, "Township"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["All", Unit[1, "Meter"^3]] = 
    {Unit[1, "PlanckVolume"], Unit[1, "Drop"], Unit[1, "DropVolume"], 
     Unit[1, "Minim"], Unit[1, "Sai"], Unit[1, "FluidDram"], 
     Unit[1, "Teaspoon"], Unit[1, "PulzierKubu"], Unit[1, "RomanSpoonful"], 
     Unit[1, "Tablespoon"], Unit[1, "ShakuVolume"], Unit[1, "Pony"], 
     Unit[1, "ImperialFluidOunce"], Unit[1, "FluidOunce"], Unit[1, "Shot"], 
     Unit[1, "Kwartin"], Unit[1, "Jigger"], Unit[1, "RomanDose"], 
     Unit[1, "Shkalik"], Unit[1, "RomanDrawingSpoon"], 
     Unit[1, "RomanSixthSester"], Unit[1, "Chast"], Unit[1, "Gill"], 
     Unit[1, "Noggin"], Unit[1, "USGill"], Unit[1, "Charka"], 
     Unit[1, "KejlaMilk"], Unit[1, "RomanQuarterSpoon"], 
     Unit[1, "ImperialGill"], Unit[1, "Pinta"], Unit[1, "GoVolume"], 
     Unit[1, "RomanThirdSester"], Unit[1, "Cup"], Unit[1, "USCup"], 
     Unit[1, "RomanDryHalfSester"], Unit[1, "RomanHalfSester"], 
     Unit[1, "Chentong"], Unit[1, "Terz"], Unit[1, "TerzMilk"], 
     Unit[1, "RomanDoubleThirdSester"], Unit[1, "Mutchkins"], 
     Unit[1, "Pint"], Unit[1, "RomanDrySester"], Unit[1, "RomanSester"], 
     Unit[1, "DryPint"], Unit[1, "UKPint"], Unit[1, "ImperialPint"], 
     Unit[1, "Leng"], Unit[1, "Nofs"], Unit[1, "ButylkaVodochnaya"], 
     Unit[1, "NofsMilk"], Unit[1, "MetricWineBottle"], Unit[1, "Fifth"], 
     Unit[1, "WineBottle"], Unit[1, "ButylkaVinnaya"], Unit[1, "Chopin"], 
     Unit[1, "Quart"], Unit[1, "Pot"], Unit[1, "Liter"], Unit[1, "DryQuart"], 
     Unit[1, "Chupak"], Unit[1, "ImperialQuart"], Unit[1, "Kartocc"], 
     Unit[1, "LiquidKruzhka"], Unit[1, "KartoccMilk"], Unit[1, "DryKruzhka"], 
     Unit[1, "LiquidChetvert"], Unit[1, "ScottishPint"], Unit[1, "Sho"], 
     Unit[1, "FitelKubu"], Unit[1, "BoardFoot"], Unit[1, "RomanCongius"], 
     Unit[1, "Garnets"], Unit[1, "Gallon"], Unit[1, "Skjeppe"], 
     Unit[1, "Omer"], Unit[1, "RomanGallon"], Unit[1, "DryGallon"], 
     Unit[1, "Gantang"], Unit[1, "ImperialGallon"], Unit[1, "UKGallon"], 
     Unit[1, "KwartaMilk"], Unit[1, "Kwarta"], Unit[1, "Qafiz"], 
     Unit[1, "RomanPeck"], Unit[1, "Peck"], Unit[1, "Garra"], 
     Unit[1, "LiquidVedro"], Unit[1, "RomanUrn"], Unit[1, "DryVedro"], 
     Unit[1, "ScottishGallon"], Unit[1, "Bucket"], Unit[1, "Cafiso"], 
     Unit[1, "XibeKubu"], Unit[1, "To"], Unit[1, "TomnaVolume"], 
     Unit[1, "MalteseQafiz"], Unit[1, "RomanBushel"], Unit[1, "RomanJar"], 
     Unit[1, "Chetverik"], Unit[1, "NorwegianTonne"], Unit[1, "Bushel"], 
     Unit[1, "Ankare"], Unit[1, "Ephah"], Unit[1, "Firkin"], 
     Unit[1, "Barmil"], Unit[1, "Osmina"], Unit[1, "Bag"], 
     Unit[1, "DryBarrel"], Unit[1, "Barrel"], Unit[1, "SwedishOhm"], 
     Unit[1, "OilBarrel"], Unit[1, "Koku"], Unit[1, "DryChetvert"], 
     Unit[1, "Hogshead"], Unit[1, "Seam"], Unit[1, "Puncheon"], 
     Unit[1, "Butt"], Unit[1, "Bochka"], Unit[1, "RomanHose"], 
     Unit[1, "Tun"], Unit[1, "Stere"], Unit[1, "FavnVolume"], 
     Unit[1, "RegisterTon"], Unit[1, "Last"], Unit[1, "LastVolume"], 
     Unit[1, "Cord"], Unit[1, "Storfavn"], Unit[1, "Kubikkfavn"], 
     Unit[1, "QasbaKubu"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Newton"]] = 
    {Unit[1, "Yoctonewton"], Unit[1, "Zeptonewton"], Unit[1, "Attonewton"], 
     Unit[1, "Femtonewton"], Unit[1, "Piconewton"], Unit[1, "Nanonewton"], 
     Unit[1, "Micronewton"], Unit[1, "Dyne"], Unit[1, "Millinewton"], 
     Unit[1, "GramWeight"], Unit[1, "Centinewton"], Unit[1, "Decinewton"], 
     Unit[1, "Poundal"], Unit[1, "Newton"], Unit[1, "PoundForce"], 
     Unit[1, "PoundWeight"], Unit[1, "KilogramForce"], 
     Unit[1, "KilogramWeight"], Unit[1, "Decanewton"], 
     Unit[1, "Hectonewton"], Unit[1, "Kilonewton"], Unit[1, "Sthene"], 
     Unit[1, "TonForce"], Unit[1, "Meganewton"], Unit[1, "Giganewton"], 
     Unit[1, "Teranewton"], Unit[1, "Petanewton"], Unit[1, "Exanewton"], 
     Unit[1, "Zettanewton"], Unit[1, "Yottanewton"], Unit[1, "PlanckForce"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Ohm"]] = 
    {Unit[1, "Yoctoohm"], Unit[1, "Zeptoohm"], Unit[1, "Attoohm"], 
     Unit[1, "Femtoohm"], Unit[1, "Picoohm"], Unit[1, "Abohm"], 
     Unit[1, "Nanoohm"], Unit[1, "Microohm"], Unit[1, "Milliohm"], 
     Unit[1, "Centiohm"], Unit[1, "Deciohm"], Unit[1, "Ohm"], 
     Unit[1, "Decaohm"], Unit[1, "PlanckImpedence"], Unit[1, "Hectoohm"], 
     Unit[1, "Kiloohm"], Unit[1, "Megaohm"], Unit[1, "Gigaohm"], 
     Unit[1, "Statohm"], Unit[1, "Teraohm"], Unit[1, "Petaohm"], 
     Unit[1, "Exaohm"], Unit[1, "Zettaohm"], Unit[1, "Yottaohm"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["All", Unit[1, "Pascal"]] = 
    {Unit[1, "Yoctopascal"], Unit[1, "Zeptopascal"], Unit[1, "Attopascal"], 
     Unit[1, "Femtopascal"], Unit[1, "Picopascal"], Unit[1, "Nanopascal"], 
     Unit[1, "Micropascal"], Unit[1, "Millipascal"], Unit[1, "Centipascal"], 
     Unit[1, "Barye"], Unit[1, "Decipascal"], Unit[1, "Pascal"], 
     Unit[1, "Decapascal"], Unit[1, "Hectopascal"], 
     Unit[1, "MillimeterMercury"], Unit[1, "Torr"], Unit[1, "Kilopascal"], 
     Unit[1, "Pieze"], Unit[1, "InchMercury"], 
     Unit[1, "PoundsPerSquareInch"], Unit[1, "PSI"], 
     Unit[1, "TechnicalAtmosphere"], Unit[1, "Bar"], Unit[1, "Atmosphere"], 
     Unit[1, "Megapascal"], Unit[1, "Gigapascal"], Unit[1, "Terapascal"], 
     Unit[1, "Petapascal"], Unit[1, "Exapascal"], Unit[1, "Zettapascal"], 
     Unit[1, "Yottapascal"], Unit[1, "PlanckPressure"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Poise"]] = 
    {Unit[1, "Poise"], Unit[1, "Reyn"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Radian"]] = 
    {Unit[1, "Radian"], Unit[1, "Steradian"], Unit[1, "ArcSecond"], 
     Unit[1, "ArcMinute"], Unit[1, "Grade"], Unit[1, "Degree"], 
     Unit[1, "DegreeAngle"], Unit[1, "Quadrant"], Unit[1, "RightAngle"], 
     Unit[1, "Circle"], Unit[1, "CircleAngle"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Meter"/"Second"]] = 
    {Unit[1, "Knot"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Second"]] = 
    {Unit[1, "PlanckTime"], Unit[1, "Yoctosecond"], Unit[1, "Zeptosecond"], 
     Unit[1, "Attosecond"], Unit[1, "Femtosecond"], Unit[1, "Picosecond"], 
     Unit[1, "Nanosecond"], Unit[1, "Microsecond"], Unit[1, "Millisecond"], 
     Unit[1, "Centisecond"], Unit[1, "Decisecond"], 
     Unit[1, "SiderealSecond"], Unit[1, "Second"], Unit[1, "Decasecond"], 
     Unit[1, "Minute"], Unit[1, "Hectosecond"], Unit[1, "Kilosecond"], 
     Unit[1, "Hour"], Unit[1, "Day"], Unit[1, "Week"], Unit[1, "Megasecond"], 
     Unit[1, "Fortnight"], Unit[1, "Month"], Unit[1, "Year"], 
     Unit[1, "TropicalYear"], Unit[1, "JulianYear"], Unit[1, "SiderealYear"], 
     Unit[1, "Decade"], Unit[1, "Gigasecond"], Unit[1, "Century"], 
     Unit[1, "JulianCentury"], Unit[1, "Millennium"], Unit[1, "Terasecond"], 
     Unit[1, "Petasecond"], Unit[1, "Exasecond"], Unit[1, "Zettasecond"], 
     Unit[1, "Yottasecond"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Tesla"]] = 
    {Unit[1, "Yoctotesla"], Unit[1, "Zeptotesla"], Unit[1, "Attotesla"], 
     Unit[1, "Femtotesla"], Unit[1, "Picotesla"], Unit[1, "Gamma"], 
     Unit[1, "GammaMagnetism"], Unit[1, "Nanotesla"], Unit[1, "Microtesla"], 
     Unit[1, "Gauss"], Unit[1, "Millitesla"], Unit[1, "Centitesla"], 
     Unit[1, "Decitesla"], Unit[1, "Tesla"], Unit[1, "Decatesla"], 
     Unit[1, "Hectotesla"], Unit[1, "Kilotesla"], Unit[1, "Megatesla"], 
     Unit[1, "Gigatesla"], Unit[1, "Teratesla"], Unit[1, "Petatesla"], 
     Unit[1, "Exatesla"], Unit[1, "Zettatesla"], Unit[1, "Yottatesla"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Volt"]] = 
    {Unit[1, "Yoctovolt"], Unit[1, "Zeptovolt"], Unit[1, "Attovolt"], 
     Unit[1, "Femtovolt"], Unit[1, "Picovolt"], Unit[1, "Nanovolt"], 
     Unit[1, "Abvolt"], Unit[1, "Microvolt"], Unit[1, "Millivolt"], 
     Unit[1, "Centivolt"], Unit[1, "Decivolt"], Unit[1, "Volt"], 
     Unit[1, "Decavolt"], Unit[1, "Hectovolt"], Unit[1, "Statvolt"], 
     Unit[1, "Kilovolt"], Unit[1, "Megavolt"], Unit[1, "Gigavolt"], 
     Unit[1, "Teravolt"], Unit[1, "Petavolt"], Unit[1, "Exavolt"], 
     Unit[1, "Zettavolt"], Unit[1, "Yottavolt"], Unit[1, "PlanckVoltage"]}
 
CompatibleUnitsFromSet["All", Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["All", Unit[1, "Watt"]] = 
    {Unit[1, "Yoctowatt"], Unit[1, "Zeptowatt"], Unit[1, "Attowatt"], 
     Unit[1, "Femtowatt"], Unit[1, "Picowatt"], Unit[1, "Nanowatt"], 
     Unit[1, "Microwatt"], Unit[1, "Milliwatt"], Unit[1, "Centiwatt"], 
     Unit[1, "Deciwatt"], Unit[1, "Watt"], Unit[1, "Decawatt"], 
     Unit[1, "Hectowatt"], Unit[1, "ChevalVapeur"], Unit[1, "Horsepower"], 
     Unit[1, "Kilowatt"], Unit[1, "Megawatt"], Unit[1, "Gigawatt"], 
     Unit[1, "Terawatt"], Unit[1, "Petawatt"], Unit[1, "Exawatt"], 
     Unit[1, "Zettawatt"], Unit[1, "Yottawatt"], Unit[1, "PlanckPower"]}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Ampere"]] = 
    {Unit[1, "Statampere"], Unit[1, "Amp"], Unit[1, "Biot"], 
     Unit[1, "Gilbert"]}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Byte"]] = 
    {Unit[1, "Nibble"], Unit[1, "Byte"]}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Coulomb"]] = 
    {Unit[1, "Statcoulomb"]}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Farad"]] = 
    {Unit[1, "Statfarad"]}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Henry"]] = 
    {Unit[1, "Stathenry"]}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Hertz"]] = 
    {Unit[1, "Becquerel"], Unit[1, "Rutherford"], Unit[1, "Curie"]}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Joule"]] = 
    {Unit[1, "ElectronVolt"], Unit[1, "Rydberg"], Unit[1, "Therm"]}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Kilogram"]] = 
    {Unit[1, "AtomicMassUnit"], Unit[1, "Carat"], Unit[1, "Obolos"], 
     Unit[1, "Drachma"], Unit[1, "Shekel"], Unit[1, "AssayTon"], 
     Unit[1, "Pondus"], Unit[1, "Libra"], Unit[1, "Mina"], 
     Unit[1, "Geepound"], Unit[1, "Slug"], Unit[1, "Talent"], 
     Unit[1, "Cental"], Unit[1, "NetHundredweight"], Unit[1, "Quintal"], 
     Unit[1, "Wey"], Unit[1, "Bale"]}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Meter"^(-1)]] = 
    {Unit[1, "Diopter"]}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Meter"]] = 
    {Unit[1, "Fermi"], Unit[1, "XUnit"], Unit[1, "Angstrom"], 
     Unit[1, "Micron"], Unit[1, "PrintersPoint"], Unit[1, "Mil"], 
     Unit[1, "Caliber"], Unit[1, "Point"], Unit[1, "Didot"], 
     Unit[1, "DidotPoint"], Unit[1, "Pica"], Unit[1, "Cicero"], 
     Unit[1, "Span"], Unit[1, "Cubit"], Unit[1, "Ell"], Unit[1, "Rope"], 
     Unit[1, "Bolt"], Unit[1, "Skein"], Unit[1, "Stadium"], 
     Unit[1, "Stadion"]}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Meter"^2]] = 
    {Unit[1, "Barn"], Unit[1, "Are"], Unit[1, "Hectare"]}
 
CompatibleUnitsFromSet["Alternative", 
     Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Meter"^3]] = 
    {Unit[1, "Drop"], Unit[1, "Pony"], Unit[1, "Shot"], Unit[1, "Fifth"], 
     Unit[1, "WineBottle"], Unit[1, "Liter"], Unit[1, "Omer"], 
     Unit[1, "Bucket"], Unit[1, "Ephah"], Unit[1, "Firkin"], Unit[1, "Bag"], 
     Unit[1, "Seam"], Unit[1, "Puncheon"], Unit[1, "Butt"], Unit[1, "Tun"], 
     Unit[1, "RegisterTon"], Unit[1, "Last"], Unit[1, "Cord"]}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Newton"]] = 
    {Unit[1, "GramWeight"], Unit[1, "Poundal"], Unit[1, "PoundWeight"], 
     Unit[1, "KilogramForce"], Unit[1, "KilogramWeight"], Unit[1, "TonForce"]}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Ohm"]] = 
    {Unit[1, "Statohm"]}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Meter"*"Ohm"]] = 
    {}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Pascal"]] = 
    {Unit[1, "MillimeterMercury"], Unit[1, "Torr"], Unit[1, "InchMercury"], 
     Unit[1, "PoundsPerSquareInch"], Unit[1, "TechnicalAtmosphere"], 
     Unit[1, "Bar"], Unit[1, "Atmosphere"]}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Poise"]] = 
    {Unit[1, "Reyn"]}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Radian"]] = 
    {Unit[1, "Steradian"], Unit[1, "ArcSecond"], Unit[1, "ArcMinute"], 
     Unit[1, "Grade"], Unit[1, "Quadrant"], Unit[1, "RightAngle"], 
     Unit[1, "Circle"]}
 
CompatibleUnitsFromSet["Alternative", 
     Unit[1, "Meter"/"Second"]] = {Unit[1, "Knot"]}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Second"]] = 
    {Unit[1, "SiderealSecond"], Unit[1, "Fortnight"], 
     Unit[1, "TropicalYear"], Unit[1, "SiderealYear"], Unit[1, "Decade"], 
     Unit[1, "Century"], Unit[1, "Millennium"]}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Tesla"]] = 
    {Unit[1, "Gamma"]}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Volt"]] = 
    {Unit[1, "Statvolt"]}
 
CompatibleUnitsFromSet["Alternative", 
     Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["Alternative", Unit[1, "Watt"]] = 
    {Unit[1, "ChevalVapeur"]}
 
CompatibleUnitsFromSet["AlternativeNames", Unit[1, "Ampere"]] = 
    {}
 
CompatibleUnitsFromSet["AlternativeNames", Unit[1, "Byte"]] = 
    {Unit[1, "ByteUnit"]}
 
CompatibleUnitsFromSet["AlternativeNames", 
     Unit[1, "Coulomb"]] = {Unit[1, "Franklin"]}
 
CompatibleUnitsFromSet["AlternativeNames", Unit[1, "Farad"]] = 
    {}
 
CompatibleUnitsFromSet["AlternativeNames", Unit[1, "Henry"]] = 
    {}
 
CompatibleUnitsFromSet["AlternativeNames", Unit[1, "Hertz"]] = 
    {}
 
CompatibleUnitsFromSet["AlternativeNames", Unit[1, "Joule"]] = 
    {Unit[1, "BTU"]}
 
CompatibleUnitsFromSet["AlternativeNames", 
     Unit[1, "Kilogram"]] = {Unit[1, "AMU"], Unit[1, "Dalton"], 
     Unit[1, "AvoirdupoisOunce"], Unit[1, "AvoirdupoisPound"], 
     Unit[1, "GrossHundredweight"], Unit[1, "Ton"]}
 
CompatibleUnitsFromSet["AlternativeNames", 
     Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["AlternativeNames", Unit[1, "Meter"]] = 
    {Unit[1, "PointLength"], Unit[1, "SpanLength"], Unit[1, "Feet"], 
     Unit[1, "StatuteMile"]}
 
CompatibleUnitsFromSet["AlternativeNames", 
     Unit[1, "Meter"^2]] = {}
 
CompatibleUnitsFromSet["AlternativeNames", 
     Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["AlternativeNames", 
     Unit[1, "Meter"^3]] = {Unit[1, "DropVolume"], Unit[1, "Gill"], 
     Unit[1, "Noggin"], Unit[1, "Cup"], Unit[1, "UKPint"], 
     Unit[1, "UKGallon"], Unit[1, "LastVolume"]}
 
CompatibleUnitsFromSet["AlternativeNames", Unit[1, "Newton"]] = 
    {}
 
CompatibleUnitsFromSet["AlternativeNames", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["AlternativeNames", 
     Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["AlternativeNames", Unit[1, "Pascal"]] = 
    {}
 
CompatibleUnitsFromSet["AlternativeNames", Unit[1, "Poise"]] = 
    {}
 
CompatibleUnitsFromSet["AlternativeNames", Unit[1, "Radian"]] = 
    {Unit[1, "DegreeAngle"], Unit[1, "CircleAngle"]}
 
CompatibleUnitsFromSet["AlternativeNames", 
     Unit[1, "Meter"/"Second"]] = {}
 
CompatibleUnitsFromSet["AlternativeNames", Unit[1, "Second"]] = 
    {}
 
CompatibleUnitsFromSet["AlternativeNames", Unit[1, "Tesla"]] = 
    {Unit[1, "GammaMagnetism"]}
 
CompatibleUnitsFromSet["AlternativeNames", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["AlternativeNames", 
     Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["AlternativeNames", Unit[1, "Watt"]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Joule"]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Kilogram"]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Meter"]] = 
    {Unit[1, "AnthropicDigit"], Unit[1, "AnthropicInch"], Unit[1, "Palm"], 
     Unit[1, "Hand"], Unit[1, "Handbreadth"], Unit[1, "Shaftment"], 
     Unit[1, "Span"], Unit[1, "AnthropicFoot"], Unit[1, "Cubit"], 
     Unit[1, "AnthropicYard"], Unit[1, "Ell"], Unit[1, "Pace"], 
     Unit[1, "Fathom"], Unit[1, "Rod"], Unit[1, "Furlong"], 
     Unit[1, "AnthropicMile"], Unit[1, "AnthropicLeague"]}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Meter"^2]] = 
    {Unit[1, "AnthropicAcre"]}
 
CompatibleUnitsFromSet["Anthropic", 
     Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Meter"^3]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Newton"]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Pascal"]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["Anthropic", 
     Unit[1, "Meter"/"Second"]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Second"]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Volt"/"Meter"]] = 
    {}
 
CompatibleUnitsFromSet["Anthropic", Unit[1, "Watt"]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Joule"]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Kilogram"]] = 
    {Unit[1, "MaltaAwqiyyah"], Unit[1, "EgyptianAwqiyyah"], 
     Unit[1, "BeirutAwqiyyah"], Unit[1, "JerusalemAwqiyyah"], 
     Unit[1, "Aleppowqiyyah"]}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Meter"]] = 
    {Unit[1, "Assba"], Unit[1, "Cabda"], Unit[1, "ArabicFoot"], 
     Unit[1, "Arsh"], Unit[1, "Orgye"], Unit[1, "Qasab"], Unit[1, "Seir"], 
     Unit[1, "Ghalva"], Unit[1, "Farasakh"], Unit[1, "Barid"], 
     Unit[1, "Marhala"]}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Meter"^2]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Ampere"*"Meter"^2]] = 
    {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Meter"^3]] = 
    {Unit[1, "Qafiz"], Unit[1, "Cafiso"]}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Newton"]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Pascal"]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Meter"/"Second"]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Second"]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["Arabic", Unit[1, "Watt"]] = {}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Joule"]] = {}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Kilogram"]] = 
    {Unit[1, "EarthMass"], Unit[1, "JupiterMass"], Unit[1, "SolarMass"]}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Meter"^(-1)]] = 
    {}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Meter"]] = 
    {Unit[1, "EarthRadius"], Unit[1, "LunarDistance"], 
     Unit[1, "AstronomicalUnit"], Unit[1, "AU"], Unit[1, "LightYear"], 
     Unit[1, "Parsec"]}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Meter"^2]] = {}
 
CompatibleUnitsFromSet["Astronomical", 
     Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Meter"^3]] = {}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Newton"]] = {}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["Astronomical", 
     Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Pascal"]] = {}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["Astronomical", 
     Unit[1, "Meter"/"Second"]] = {}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Second"]] = 
    {Unit[1, "Day"], Unit[1, "JulianYear"], Unit[1, "JulianCentury"]}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["Astronomical", 
     Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["Astronomical", Unit[1, "Watt"]] = {}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Coulomb"]] = 
    {Unit[1, "ElementaryCharge"]}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Joule"]] = 
    {Unit[1, "HartreeEnergy"]}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Kilogram"]] = 
    {Unit[1, "ElectronRestMass"]}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Meter"]] = 
    {Unit[1, "BohrRadius"]}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Meter"^2]] = {}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Ampere"*"Meter"^2]] = 
    {}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Meter"^3]] = {}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Newton"]] = 
    {Unit[1, "HartreeEnergy"/"BohrRadius"]}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Pascal"]] = 
    {Unit[1, "HartreeEnergy"/"BohrRadius"^3]}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Meter"/"Second"]] = 
    {Unit[1, ("BohrRadius"*"HartreeEnergy")/"ReducedPlanckConstant"]}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Second"]] = 
    {Unit[1, "ReducedPlanckConstant"/"HartreeEnergy"]}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["Atomic", Unit[1, "Watt"]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Joule"]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Kilogram"]] = 
    {Unit[1, "Grain"], Unit[1, "Dram"], Unit[1, "Ounce"], Unit[1, "Pound"], 
     Unit[1, "ShortHundredweight"], Unit[1, "ShortTon"]}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Meter"^(-1)]] = 
    {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Meter"]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Meter"^2]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", 
     Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Meter"^3]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Newton"]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Meter"*"Ohm"]] = 
    {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Pascal"]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", 
     Unit[1, "Meter"/"Second"]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Second"]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", 
     Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["Avoirdupois", Unit[1, "Watt"]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", Unit[1, "Byte"]] = 
    {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Joule"]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Kilogram"]] = {Unit[1, "Grain"], Unit[1, "Dram"], 
     Unit[1, "Ounce"], Unit[1, "Pound"], Unit[1, "Stone"], 
     Unit[1, "Hundredweight"], Unit[1, "LongTon"]}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Meter"]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Meter"^2]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Meter"^3]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Newton"]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", Unit[1, "Ohm"]] = 
    {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Pascal"]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Meter"/"Second"]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Second"]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", Unit[1, "Volt"]] = 
    {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", 
     Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["BritishAvoirdupois", Unit[1, "Watt"]] = 
    {}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Ampere"]] = 
    {Unit[1, "Abampere"]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Coulomb"]] = 
    {Unit[1, "Abcoulomb"]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Farad"]] = 
    {Unit[1, "Abfarad"]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Henry"]] = 
    {Unit[1, "Abhenry"]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Joule"]] = 
    {Unit[1, "Erg"]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Kilogram"]] = 
    {Unit[1, "Gram"]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Meter"^(-1)]] = 
    {Unit[1, "Kayser"]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Meter"]] = 
    {Unit[1, "Centimeter"]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Meter"^2]] = 
    {Unit[1, "Centimeter"^2]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Meter"^3]] = 
    {Unit[1, "Centimeter"^3]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Newton"]] = 
    {Unit[1, "Dyne"]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Ohm"]] = 
    {Unit[1, "Abohm"]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Meter"*"Ohm"]] = 
    {Unit[1, "Abohm"*"Centimeter"]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Pascal"]] = 
    {Unit[1, "Barye"]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Poise"]] = 
    {Unit[1, "Poise"]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Radian"]] = 
    {Unit[1, "Radian"]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Meter"/"Second"]] = 
    {Unit[1, "Centimeter"/"Second"]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Second"]] = 
    {Unit[1, "Second"]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Tesla"]] = 
    {Unit[1, "Gauss"]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Volt"]] = 
    {Unit[1, "Abvolt"]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Volt"/"Meter"]] = 
    {Unit[1, "Abvolt"/"Centimeter"]}
 
CompatibleUnitsFromSet["CGS", Unit[1, "Watt"]] = 
    {Unit[1, "Erg"/"Second"]}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Joule"]] = {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Kilogram"]] = {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Meter"]] = {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Meter"^2]] = {}
 
CompatibleUnitsFromSet["Champagne", 
     Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Meter"^3]] = 
    {Unit[1, "MetricWineBottle"]}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Newton"]] = {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Pascal"]] = {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["Champagne", 
     Unit[1, "Meter"/"Second"]] = {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Second"]] = {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Volt"/"Meter"]] = 
    {}
 
CompatibleUnitsFromSet["Champagne", Unit[1, "Watt"]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Byte"]] = 
    {Unit[1, "Kibibit"], Unit[1, "Kibibyte"], Unit[1, "Mebibit"], 
     Unit[1, "Mebibyte"], Unit[1, "Gibibit"], Unit[1, "Gibibyte"], 
     Unit[1, "Tebibit"], Unit[1, "Tebibyte"], Unit[1, "Pebibit"], 
     Unit[1, "Pebibyte"], Unit[1, "Exbibit"], Unit[1, "Exbibyte"], 
     Unit[1, "Zebibit"], Unit[1, "Zebibyte"], Unit[1, "Yobibit"], 
     Unit[1, "Yobibyte"]}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Joule"]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Kilogram"]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Meter"]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Meter"^2]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Meter"^3]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Newton"]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Pascal"]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Meter"/"Second"]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Second"]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["IEC", Unit[1, "Watt"]] = {}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Joule"]] = 
    {Unit[1, "Calorie"], Unit[1, "BritishThermalUnit"]}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Kilogram"]] = 
    {Unit[1, "Grain"], Unit[1, "Pennyweight"], Unit[1, "Dram"], 
     Unit[1, "Ounce"], Unit[1, "TroyOunce"], Unit[1, "TroyPound"], 
     Unit[1, "Pound"], Unit[1, "Stone"], Unit[1, "Hundredweight"], 
     Unit[1, "LongTon"]}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Meter"]] = 
    {Unit[1, "Thou"], Unit[1, "Inch"], Unit[1, "Link"], Unit[1, "Foot"], 
     Unit[1, "Yard"], Unit[1, "Fathom"], Unit[1, "Perch"], Unit[1, "Pole"], 
     Unit[1, "Chain"], Unit[1, "Furlong"], Unit[1, "Cable"], Unit[1, "Mile"], 
     Unit[1, "NauticalMile"], Unit[1, "League"]}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Meter"^2]] = 
    {Unit[1, "Rood"], Unit[1, "Acre"]}
 
CompatibleUnitsFromSet["Imperial", 
     Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Meter"^3]] = 
    {Unit[1, "ImperialFluidOunce"], Unit[1, "ImperialGill"], 
     Unit[1, "ImperialPint"], Unit[1, "ImperialQuart"], 
     Unit[1, "ImperialGallon"]}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Newton"]] = 
    {Unit[1, "PoundForce"]}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Pascal"]] = 
    {Unit[1, "PSI"]}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Radian"]] = 
    {Unit[1, "Degree"]}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Meter"/"Second"]] = 
    {Unit[1, "Mile"/"Hour"]}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Second"]] = 
    {Unit[1, "Second"], Unit[1, "Minute"], Unit[1, "Hour"], Unit[1, "Day"], 
     Unit[1, "Week"], Unit[1, "Month"], Unit[1, "Year"]}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["Imperial", Unit[1, "Watt"]] = 
    {Unit[1, "Horsepower"]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Ampere"]] = {Unit[1, "Ampere"]}
 
CompatibleUnitsFromSet["InteractiveChoices", Unit[1, "Byte"]] = 
    {Unit[1, "Bit"]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Coulomb"]] = {Unit[1, "Coulomb"]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Farad"]] = {Unit[1, "Farad"]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Henry"]] = {Unit[1, "Henry"]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Hertz"]] = {Unit[1, "Hertz"]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Joule"]] = {Unit[1, "Joule"], Unit[1, "Calorie"], 
     Unit[1, "BritishThermalUnit"]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Kilogram"]] = {Unit[1, "Grain"], Unit[1, "Pennyweight"], 
     Unit[1, "Dram"], Unit[1, "Ounce"], Unit[1, "TroyOunce"], 
     Unit[1, "TroyPound"], Unit[1, "Pound"], Unit[1, "Kilogram"], 
     Unit[1, "Stone"], Unit[1, "ShortHundredweight"], 
     Unit[1, "Hundredweight"], Unit[1, "ShortTon"], Unit[1, "LongTon"]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Meter"^(-1)]] = {Unit[1, "Meter"^(-1)]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Meter"]] = {Unit[1, "Thou"], Unit[1, "Inch"], Unit[1, "Hand"], 
     Unit[1, "Link"], Unit[1, "Foot"], Unit[1, "SurveyFoot"], 
     Unit[1, "Yard"], Unit[1, "Meter"], Unit[1, "Fathom"], Unit[1, "Perch"], 
     Unit[1, "Pole"], Unit[1, "Rod"], Unit[1, "Chain"], Unit[1, "Furlong"], 
     Unit[1, "Cable"], Unit[1, "Mile"], Unit[1, "SurveyMile"], 
     Unit[1, "NauticalMile"], Unit[1, "League"]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Meter"^2]] = {Unit[1, "Foot"^2], Unit[1, "Meter"^2], 
     Unit[1, "Chain"^2], Unit[1, "Rood"], Unit[1, "Acre"], 
     Unit[1, "SurveyAcre"], Unit[1, "Section"], Unit[1, "Township"]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Ampere"*"Meter"^2]] = {Unit[1, "Ampere"*"Meter"^2]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Meter"^3]] = {Unit[1, "FluidDram"], Unit[1, "Teaspoon"], 
     Unit[1, "Tablespoon"], Unit[1, "Inch"^3], Unit[1, "ImperialFluidOunce"], 
     Unit[1, "Jigger"], Unit[1, "USGill"], Unit[1, "ImperialGill"], 
     Unit[1, "Pint"], Unit[1, "DryPint"], Unit[1, "ImperialPint"], 
     Unit[1, "Quart"], Unit[1, "DryQuart"], Unit[1, "ImperialQuart"], 
     Unit[1, "BoardFoot"], Unit[1, "Gallon"], Unit[1, "DryGallon"], 
     Unit[1, "ImperialGallon"], Unit[1, "Peck"], Unit[1, "Foot"^3], 
     Unit[1, "Bushel"], Unit[1, "DryBarrel"], Unit[1, "Barrel"], 
     Unit[1, "OilBarrel"], Unit[1, "Hogshead"], Unit[1, "Yard"^3], 
     Unit[1, "Meter"^3], Unit[1, "Acre"*"Foot"]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Newton"]] = {Unit[1, "Newton"], Unit[1, "PoundForce"]}
 
CompatibleUnitsFromSet["InteractiveChoices", Unit[1, "Ohm"]] = 
    {Unit[1, "Ohm"]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Meter"*"Ohm"]] = {Unit[1, "Meter"*"Ohm"]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Pascal"]] = {Unit[1, "Pascal"], Unit[1, "PSI"]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Poise"]] = {Unit[1, "Pascal"*"Second"]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Radian"]] = {Unit[1, "Radian"], Unit[1, "Degree"]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Meter"/"Second"]] = {Unit[1, "Mile"/"Hour"], 
     Unit[1, "Meter"/"Second"]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Second"]] = {Unit[1, "Second"], Unit[1, "Minute"], 
     Unit[1, "Hour"], Unit[1, "Day"], Unit[1, "Week"], Unit[1, "Month"], 
     Unit[1, "Year"]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Tesla"]] = {Unit[1, "Tesla"]}
 
CompatibleUnitsFromSet["InteractiveChoices", Unit[1, "Volt"]] = 
    {Unit[1, "Volt"]}
 
CompatibleUnitsFromSet["InteractiveChoices", 
     Unit[1, "Volt"/"Meter"]] = {Unit[1, "Volt"/"Meter"]}
 
CompatibleUnitsFromSet["InteractiveChoices", Unit[1, "Watt"]] = 
    {Unit[1, "Watt"], Unit[1, "Horsepower"]}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Joule"]] = {}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Kilogram"]] = 
    {Unit[1, "Fun"], Unit[1, "Momme"], Unit[1, "Hyakume"], Unit[1, "Kin"], 
     Unit[1, "Kan"], Unit[1, "Kanme"]}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Meter"]] = 
    {Unit[1, "Mo"], Unit[1, "Rin"], Unit[1, "Bu"], Unit[1, "Sun"], 
     Unit[1, "Shaku"], Unit[1, "Hiro"], Unit[1, "Ken"], Unit[1, "JoLength"], 
     Unit[1, "ChoLength"], Unit[1, "ReLength"]}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Meter"^2]] = 
    {Unit[1, "ShakuArea"], Unit[1, "GoArea"], Unit[1, "JoArea"], 
     Unit[1, "BuArea"], Unit[1, "Tsubo"], Unit[1, "Se"], Unit[1, "TanArea"], 
     Unit[1, "ChoArea"]}
 
CompatibleUnitsFromSet["Japanese", 
     Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Meter"^3]] = 
    {Unit[1, "Sai"], Unit[1, "ShakuVolume"], Unit[1, "GoVolume"], 
     Unit[1, "Sho"], Unit[1, "To"], Unit[1, "Koku"]}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Newton"]] = {}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Pascal"]] = {}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Meter"/"Second"]] = 
    {}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Second"]] = {}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["Japanese", Unit[1, "Watt"]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Joule"]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Kilogram"]] = 
    {Unit[1, "Kati"], Unit[1, "Pikul"]}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Meter"]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Meter"^2]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Ampere"*"Meter"^2]] = 
    {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Meter"^3]] = 
    {Unit[1, "Chentong"], Unit[1, "Leng"], Unit[1, "Chupak"], 
     Unit[1, "Gantang"]}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Newton"]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Pascal"]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Meter"/"Second"]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Second"]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["Malay", Unit[1, "Watt"]] = {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Joule"]] = {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Kilogram"]] = 
    {Unit[1, "Uqija"], Unit[1, "Kwart"], Unit[1, "Ratal"], Unit[1, "Qsima"], 
     Unit[1, "Wizna"], Unit[1, "Qantar"], Unit[1, "Pezata"]}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Meter"]] = 
    {Unit[1, "Pulzier"], Unit[1, "Fitel"], Unit[1, "Xiber"], Unit[1, "Qasba"]}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Meter"^2]] = 
    {Unit[1, "PulzierKwadru"], Unit[1, "FitelKwadru"], 
     Unit[1, "XiberKwadru"], Unit[1, "Lumin"], Unit[1, "QasbaKwadru"], 
     Unit[1, "Kejla"], Unit[1, "KejlaVolume"], Unit[1, "SieghVolume"], 
     Unit[1, "Ghabara"], Unit[1, "Siegh"], Unit[1, "Tomna"], 
     Unit[1, "Wejba"], Unit[1, "Modd"], Unit[1, "ModdVolume"]}
 
CompatibleUnitsFromSet["Maltese", 
     Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Meter"^3]] = 
    {Unit[1, "PulzierKubu"], Unit[1, "Kwartin"], Unit[1, "KejlaMilk"], 
     Unit[1, "Pinta"], Unit[1, "Terz"], Unit[1, "TerzMilk"], Unit[1, "Nofs"], 
     Unit[1, "NofsMilk"], Unit[1, "Kartocc"], Unit[1, "KartoccMilk"], 
     Unit[1, "FitelKubu"], Unit[1, "KwartaMilk"], Unit[1, "Kwarta"], 
     Unit[1, "Garra"], Unit[1, "XibeKubu"], Unit[1, "TomnaVolume"], 
     Unit[1, "MalteseQafiz"], Unit[1, "Barmil"], Unit[1, "QasbaKubu"]}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Newton"]] = {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Pascal"]] = {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Meter"/"Second"]] = 
    {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Second"]] = {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["Maltese", Unit[1, "Watt"]] = {}
 
CompatibleUnitsFromSet["MeterTonneSecond", Unit[1, "Ampere"]] = 
    {}
 
CompatibleUnitsFromSet["MeterTonneSecond", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["MeterTonneSecond", 
     Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["MeterTonneSecond", Unit[1, "Farad"]] = 
    {}
 
CompatibleUnitsFromSet["MeterTonneSecond", Unit[1, "Henry"]] = 
    {}
 
CompatibleUnitsFromSet["MeterTonneSecond", Unit[1, "Hertz"]] = 
    {}
 
CompatibleUnitsFromSet["MeterTonneSecond", Unit[1, "Joule"]] = 
    {Unit[1, "Meter"*"Sthene"]}
 
CompatibleUnitsFromSet["MeterTonneSecond", 
     Unit[1, "Kilogram"]] = {Unit[1, "MetricTon"], Unit[1, "Tonne"]}
 
CompatibleUnitsFromSet["MeterTonneSecond", 
     Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["MeterTonneSecond", Unit[1, "Meter"]] = 
    {Unit[1, "Meter"]}
 
CompatibleUnitsFromSet["MeterTonneSecond", 
     Unit[1, "Meter"^2]] = {}
 
CompatibleUnitsFromSet["MeterTonneSecond", 
     Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["MeterTonneSecond", 
     Unit[1, "Meter"^3]] = {Unit[1, "Stere"]}
 
CompatibleUnitsFromSet["MeterTonneSecond", Unit[1, "Newton"]] = 
    {Unit[1, "Sthene"]}
 
CompatibleUnitsFromSet["MeterTonneSecond", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["MeterTonneSecond", 
     Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["MeterTonneSecond", Unit[1, "Pascal"]] = 
    {Unit[1, "Pieze"]}
 
CompatibleUnitsFromSet["MeterTonneSecond", Unit[1, "Poise"]] = 
    {}
 
CompatibleUnitsFromSet["MeterTonneSecond", Unit[1, "Radian"]] = 
    {}
 
CompatibleUnitsFromSet["MeterTonneSecond", 
     Unit[1, "Meter"/"Second"]] = {}
 
CompatibleUnitsFromSet["MeterTonneSecond", Unit[1, "Second"]] = 
    {Unit[1, "Second"]}
 
CompatibleUnitsFromSet["MeterTonneSecond", Unit[1, "Tesla"]] = 
    {}
 
CompatibleUnitsFromSet["MeterTonneSecond", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["MeterTonneSecond", 
     Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["MeterTonneSecond", Unit[1, "Watt"]] = 
    {Unit[1, ("Meter"*"Sthene")/"Second"]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Ampere"]] = 
    {Unit[1, "Ampere"]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Byte"]] = 
    {Unit[1, "Bit"]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Coulomb"]] = 
    {Unit[1, "Ampere"*"Second"]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Farad"]] = 
    {Unit[1, ("Ampere"^2*"Second"^4)/("Kilogram"*"Meter"^2)]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Henry"]] = 
    {Unit[1, ("Kilogram"*"Meter"^2)/("Ampere"^2*"Second"^2)]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Hertz"]] = 
    {Unit[1, "Second"^(-1)]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Joule"]] = 
    {Unit[1, ("Kilogram"*"Meter"^2)/"Second"^2]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Kilogram"]] = 
    {Unit[1, "Kilogram"]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Meter"^(-1)]] = 
    {Unit[1, "Meter"^(-1)]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Meter"]] = 
    {Unit[1, "Meter"]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Meter"^2]] = 
    {Unit[1, "Meter"^2]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Ampere"*"Meter"^2]] = 
    {Unit[1, "Ampere"*"Meter"^2]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Meter"^3]] = 
    {Unit[1, "Meter"^3]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Newton"]] = 
    {Unit[1, ("Kilogram"*"Meter")/"Second"^2]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Ohm"]] = 
    {Unit[1, ("Kilogram"*"Meter"^2)/("Ampere"^2*"Second"^3)]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Meter"*"Ohm"]] = 
    {Unit[1, ("Kilogram"*"Meter"^3)/("Ampere"^2*"Second"^3)]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Pascal"]] = 
    {Unit[1, "Kilogram"/("Meter"*"Second"^2)]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Poise"]] = 
    {Unit[1, "Kilogram"/("Meter"*"Second")]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Radian"]] = 
    {Unit[1, "Radian"]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Meter"/"Second"]] = 
    {Unit[1, "Meter"/"Second"]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Second"]] = 
    {Unit[1, "Second"]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Tesla"]] = 
    {Unit[1, ("Kilogram"*"Meter"^4)/("Ampere"*"Second"^2)]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Volt"]] = 
    {Unit[1, ("Kilogram"*"Meter"^2)/("Ampere"*"Second"^3)]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Volt"/"Meter"]] = 
    {Unit[1, ("Kilogram"*"Meter")/("Ampere"*"Second"^3)]}
 
CompatibleUnitsFromSet["MKS", Unit[1, "Watt"]] = 
    {Unit[1, ("Kilogram"*"Meter"^2)/"Second"^3]}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Joule"]] = {}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Kilogram"]] = 
    {Unit[1, "NorwegianOrt"], Unit[1, "Merke"], Unit[1, "Pund"], 
     Unit[1, "NorwegianBismerpund"], Unit[1, "Laup"], Unit[1, "Spann"], 
     Unit[1, "Vag"], Unit[1, "Skippund"]}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Meter"]] = 
    {Unit[1, "Skrupel"], Unit[1, "NorwegianLinje"], Unit[1, "Tomme"], 
     Unit[1, "NorwegianKvarter"], Unit[1, "NorwegianFot"], Unit[1, "Alen"], 
     Unit[1, "Favn"], Unit[1, "NorwegianStang"], Unit[1, "Las"], 
     Unit[1, "Kabellengde"], Unit[1, "NorwegianKvartmil"], 
     Unit[1, "Fjerdingsvei"], Unit[1, "Geografiskmil"], 
     Unit[1, "NorwegianSjomil"], Unit[1, "NorwegianMil"]}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Meter"^2]] = 
    {Unit[1, "KvadratRode"], Unit[1, "Mal"], Unit[1, "Tonneland"]}
 
CompatibleUnitsFromSet["Norwegian", 
     Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Meter"^3]] = 
    {Unit[1, "Skjeppe"], Unit[1, "NorwegianTonne"], Unit[1, "FavnVolume"]}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Newton"]] = {}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Pascal"]] = {}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["Norwegian", 
     Unit[1, "Meter"/"Second"]] = {}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Second"]] = {}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Volt"/"Meter"]] = 
    {}
 
CompatibleUnitsFromSet["Norwegian", Unit[1, "Watt"]] = {}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Ampere"]] = 
    {Unit[1, "PlanckCurrent"]}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Coulomb"]] = 
    {Unit[1, "PlanckCharge"]}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Hertz"]] = 
    {Unit[1, "PlanckAngularFrequency"]}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Joule"]] = 
    {Unit[1, "PlanckEnergy"]}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Kilogram"]] = 
    {Unit[1, "PlanckMass"]}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Meter"]] = 
    {Unit[1, "PlanckLength"]}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Meter"^2]] = 
    {Unit[1, "PlanckArea"]}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Ampere"*"Meter"^2]] = 
    {}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Meter"^3]] = 
    {Unit[1, "PlanckVolume"]}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Newton"]] = 
    {Unit[1, "PlanckForce"]}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Ohm"]] = 
    {Unit[1, "PlanckImpedence"]}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Pascal"]] = 
    {Unit[1, "PlanckPressure"]}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Meter"/"Second"]] = {}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Second"]] = 
    {Unit[1, "PlanckTime"]}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Volt"]] = 
    {Unit[1, "PlanckVoltage"]}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["Planck", Unit[1, "Watt"]] = 
    {Unit[1, "PlanckPower"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Ampere"]] = 
    {Unit[1, "Yoctoampere"], Unit[1, "Zeptoampere"], Unit[1, "Attoampere"], 
     Unit[1, "Femtoampere"], Unit[1, "Picoampere"], Unit[1, "Nanoampere"], 
     Unit[1, "Microampere"], Unit[1, "Milliampere"], Unit[1, "Centiampere"], 
     Unit[1, "Deciampere"], Unit[1, "Ampere"], Unit[1, "Decaampere"], 
     Unit[1, "Hectoampere"], Unit[1, "Kiloampere"], Unit[1, "Megaampere"], 
     Unit[1, "Gigaampere"], Unit[1, "Teraampere"], Unit[1, "Petaampere"], 
     Unit[1, "Exaampere"], Unit[1, "Zettaampere"], Unit[1, "Yottaampere"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Byte"]] = 
    {Unit[1, "Bit"], Unit[1, "Bit"], Unit[1, "Byte"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Coulomb"]] = 
    {Unit[1, "Yoctocoulomb"], Unit[1, "Zeptocoulomb"], 
     Unit[1, "Attocoulomb"], Unit[1, "Femtocoulomb"], Unit[1, "Picocoulomb"], 
     Unit[1, "Nanocoulomb"], Unit[1, "Microcoulomb"], 
     Unit[1, "Millicoulomb"], Unit[1, "Centicoulomb"], 
     Unit[1, "Decicoulomb"], Unit[1, "Coulomb"], Unit[1, "Decacoulomb"], 
     Unit[1, "Hectocoulomb"], Unit[1, "Kilocoulomb"], Unit[1, "Megacoulomb"], 
     Unit[1, "Gigacoulomb"], Unit[1, "Teracoulomb"], Unit[1, "Petacoulomb"], 
     Unit[1, "Exacoulomb"], Unit[1, "Zettacoulomb"], Unit[1, "Yottacoulomb"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Farad"]] = 
    {Unit[1, "Yoctofarad"], Unit[1, "Zeptofarad"], Unit[1, "Attofarad"], 
     Unit[1, "Femtofarad"], Unit[1, "Picofarad"], Unit[1, "Nanofarad"], 
     Unit[1, "Microfarad"], Unit[1, "Millifarad"], Unit[1, "Centifarad"], 
     Unit[1, "Decifarad"], Unit[1, "Farad"], Unit[1, "Decafarad"], 
     Unit[1, "Hectofarad"], Unit[1, "Kilofarad"], Unit[1, "Megafarad"], 
     Unit[1, "Gigafarad"], Unit[1, "Terafarad"], Unit[1, "Petafarad"], 
     Unit[1, "Exafarad"], Unit[1, "Zettafarad"], Unit[1, "Yottafarad"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Henry"]] = 
    {Unit[1, "Yoctohenry"], Unit[1, "Zeptohenry"], Unit[1, "Attohenry"], 
     Unit[1, "Femtohenry"], Unit[1, "Picohenry"], Unit[1, "Nanohenry"], 
     Unit[1, "Microhenry"], Unit[1, "Millihenry"], Unit[1, "Centihenry"], 
     Unit[1, "Decihenry"], Unit[1, "Henry"], Unit[1, "Decahenry"], 
     Unit[1, "Hectohenry"], Unit[1, "Kilohenry"], Unit[1, "Megahenry"], 
     Unit[1, "Gigahenry"], Unit[1, "Terahenry"], Unit[1, "Petahenry"], 
     Unit[1, "Exahenry"], Unit[1, "Zettahenry"], Unit[1, "Yottahenry"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Hertz"]] = 
    {Unit[1, "Yoctohertz"], Unit[1, "Zeptohertz"], Unit[1, "Attohertz"], 
     Unit[1, "Femtohertz"], Unit[1, "Picohertz"], Unit[1, "Nanohertz"], 
     Unit[1, "Microhertz"], Unit[1, "Millihertz"], Unit[1, "Centihertz"], 
     Unit[1, "Decihertz"], Unit[1, "Hertz"], Unit[1, "Decahertz"], 
     Unit[1, "Hectohertz"], Unit[1, "Kilohertz"], Unit[1, "Megahertz"], 
     Unit[1, "Gigahertz"], Unit[1, "Terahertz"], Unit[1, "Petahertz"], 
     Unit[1, "Exahertz"], Unit[1, "Zettahertz"], Unit[1, "Yottahertz"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Joule"]] = 
    {Unit[1, "Yoctojoule"], Unit[1, "Zeptojoule"], Unit[1, "Attojoule"], 
     Unit[1, "Femtojoule"], Unit[1, "Picojoule"], Unit[1, "Nanojoule"], 
     Unit[1, "Microjoule"], Unit[1, "Millijoule"], Unit[1, "Centijoule"], 
     Unit[1, "Decijoule"], Unit[1, "Joule"], Unit[1, "Decajoule"], 
     Unit[1, "Hectojoule"], Unit[1, "Kilojoule"], Unit[1, "Megajoule"], 
     Unit[1, "Gigajoule"], Unit[1, "Terajoule"], Unit[1, "Petajoule"], 
     Unit[1, "Exajoule"], Unit[1, "Zettajoule"], Unit[1, "Yottajoule"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Kilogram"]] = 
    {Unit[1, "Kilogram"], Unit[1, "Kilogram"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Meter"^(-1)]] = 
    {Unit[1, "Yottameter"^(-1)], Unit[1, "Zettameter"^(-1)], 
     Unit[1, "Exameter"^(-1)], Unit[1, "Petameter"^(-1)], 
     Unit[1, "Terameter"^(-1)], Unit[1, "Gigameter"^(-1)], 
     Unit[1, "Megameter"^(-1)], Unit[1, "Kilometer"^(-1)], 
     Unit[1, "Hectometer"^(-1)], Unit[1, "Decameter"^(-1)], 
     Unit[1, "Meter"^(-1)], Unit[1, "Decimeter"^(-1)], 
     Unit[1, "Centimeter"^(-1)], Unit[1, "Millimeter"^(-1)], 
     Unit[1, "Micrometer"^(-1)], Unit[1, "Nanometer"^(-1)], 
     Unit[1, "Picometer"^(-1)], Unit[1, "Femtometer"^(-1)], 
     Unit[1, "Attometer"^(-1)], Unit[1, "Zeptometer"^(-1)], 
     Unit[1, "Yoctometer"^(-1)]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Meter"]] = 
    {Unit[1, "Yoctometer"], Unit[1, "Zeptometer"], Unit[1, "Attometer"], 
     Unit[1, "Femtometer"], Unit[1, "Picometer"], Unit[1, "Nanometer"], 
     Unit[1, "Micrometer"], Unit[1, "Millimeter"], Unit[1, "Centimeter"], 
     Unit[1, "Decimeter"], Unit[1, "Meter"], Unit[1, "Decameter"], 
     Unit[1, "Hectometer"], Unit[1, "Kilometer"], Unit[1, "Megameter"], 
     Unit[1, "Gigameter"], Unit[1, "Terameter"], Unit[1, "Petameter"], 
     Unit[1, "Exameter"], Unit[1, "Zettameter"], Unit[1, "Yottameter"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Meter"^2]] = 
    {Unit[1, "Yoctometer"^2], Unit[1, "Zeptometer"^2], 
     Unit[1, "Attometer"^2], Unit[1, "Femtometer"^2], Unit[1, "Picometer"^2], 
     Unit[1, "Nanometer"^2], Unit[1, "Micrometer"^2], 
     Unit[1, "Millimeter"^2], Unit[1, "Centimeter"^2], 
     Unit[1, "Decimeter"^2], Unit[1, "Meter"^2], Unit[1, "Decameter"^2], 
     Unit[1, "Hectometer"^2], Unit[1, "Kilometer"^2], Unit[1, "Megameter"^2], 
     Unit[1, "Gigameter"^2], Unit[1, "Terameter"^2], Unit[1, "Petameter"^2], 
     Unit[1, "Exameter"^2], Unit[1, "Zettameter"^2], Unit[1, "Yottameter"^2]}
 
CompatibleUnitsFromSet["PrefixedSI", 
     Unit[1, "Ampere"*"Meter"^2]] = {Unit[1, "Meter"^2*"Yoctoampere"], 
     Unit[1, "Meter"^2*"Zeptoampere"], Unit[1, "Attoampere"*"Meter"^2], 
     Unit[1, "Femtoampere"*"Meter"^2], Unit[1, "Meter"^2*"Picoampere"], 
     Unit[1, "Meter"^2*"Nanoampere"], Unit[1, "Meter"^2*"Microampere"], 
     Unit[1, "Meter"^2*"Milliampere"], Unit[1, "Centiampere"*"Meter"^2], 
     Unit[1, "Deciampere"*"Meter"^2], Unit[1, "Ampere"*"Meter"^2], 
     Unit[1, "Decaampere"*"Meter"^2], Unit[1, "Hectoampere"*"Meter"^2], 
     Unit[1, "Kiloampere"*"Meter"^2], Unit[1, "Megaampere"*"Meter"^2], 
     Unit[1, "Gigaampere"*"Meter"^2], Unit[1, "Meter"^2*"Teraampere"], 
     Unit[1, "Meter"^2*"Petaampere"], Unit[1, "Exaampere"*"Meter"^2], 
     Unit[1, "Meter"^2*"Zettaampere"], Unit[1, "Meter"^2*"Yottaampere"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Meter"^3]] = 
    {Unit[1, "Yoctometer"^3], Unit[1, "Zeptometer"^3], 
     Unit[1, "Attometer"^3], Unit[1, "Femtometer"^3], Unit[1, "Picometer"^3], 
     Unit[1, "Nanometer"^3], Unit[1, "Micrometer"^3], 
     Unit[1, "Millimeter"^3], Unit[1, "Centimeter"^3], 
     Unit[1, "Decimeter"^3], Unit[1, "Meter"^3], Unit[1, "Decameter"^3], 
     Unit[1, "Hectometer"^3], Unit[1, "Kilometer"^3], Unit[1, "Megameter"^3], 
     Unit[1, "Gigameter"^3], Unit[1, "Terameter"^3], Unit[1, "Petameter"^3], 
     Unit[1, "Exameter"^3], Unit[1, "Zettameter"^3], Unit[1, "Yottameter"^3]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Newton"]] = 
    {Unit[1, "Yoctonewton"], Unit[1, "Zeptonewton"], Unit[1, "Attonewton"], 
     Unit[1, "Femtonewton"], Unit[1, "Piconewton"], Unit[1, "Nanonewton"], 
     Unit[1, "Micronewton"], Unit[1, "Millinewton"], Unit[1, "Centinewton"], 
     Unit[1, "Decinewton"], Unit[1, "Newton"], Unit[1, "Decanewton"], 
     Unit[1, "Hectonewton"], Unit[1, "Kilonewton"], Unit[1, "Meganewton"], 
     Unit[1, "Giganewton"], Unit[1, "Teranewton"], Unit[1, "Petanewton"], 
     Unit[1, "Exanewton"], Unit[1, "Zettanewton"], Unit[1, "Yottanewton"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Ohm"]] = 
    {Unit[1, "Yoctoohm"], Unit[1, "Zeptoohm"], Unit[1, "Attoohm"], 
     Unit[1, "Femtoohm"], Unit[1, "Picoohm"], Unit[1, "Nanoohm"], 
     Unit[1, "Microohm"], Unit[1, "Milliohm"], Unit[1, "Centiohm"], 
     Unit[1, "Deciohm"], Unit[1, "Ohm"], Unit[1, "Decaohm"], 
     Unit[1, "Hectoohm"], Unit[1, "Kiloohm"], Unit[1, "Megaohm"], 
     Unit[1, "Gigaohm"], Unit[1, "Teraohm"], Unit[1, "Petaohm"], 
     Unit[1, "Exaohm"], Unit[1, "Zettaohm"], Unit[1, "Yottaohm"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Meter"*"Ohm"]] = 
    {Unit[1, "Meter"*"Ohm"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Pascal"]] = 
    {Unit[1, "Yoctopascal"], Unit[1, "Zeptopascal"], Unit[1, "Attopascal"], 
     Unit[1, "Femtopascal"], Unit[1, "Picopascal"], Unit[1, "Nanopascal"], 
     Unit[1, "Micropascal"], Unit[1, "Millipascal"], Unit[1, "Centipascal"], 
     Unit[1, "Decipascal"], Unit[1, "Pascal"], Unit[1, "Decapascal"], 
     Unit[1, "Hectopascal"], Unit[1, "Kilopascal"], Unit[1, "Megapascal"], 
     Unit[1, "Gigapascal"], Unit[1, "Terapascal"], Unit[1, "Petapascal"], 
     Unit[1, "Exapascal"], Unit[1, "Zettapascal"], Unit[1, "Yottapascal"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Poise"]] = 
    {Unit[1, "Pascal"*"Second"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Radian"]] = 
    {Unit[1, "Radian"], Unit[1, "Radian"]}
 
CompatibleUnitsFromSet["PrefixedSI", 
     Unit[1, "Meter"/"Second"]] = {Unit[1, "Yoctometer"/"Second"], 
     Unit[1, "Zeptometer"/"Second"], Unit[1, "Attometer"/"Second"], 
     Unit[1, "Femtometer"/"Second"], Unit[1, "Picometer"/"Second"], 
     Unit[1, "Nanometer"/"Second"], Unit[1, "Micrometer"/"Second"], 
     Unit[1, "Millimeter"/"Second"], Unit[1, "Centimeter"/"Second"], 
     Unit[1, "Decimeter"/"Second"], Unit[1, "Meter"/"Second"], 
     Unit[1, "Decameter"/"Second"], Unit[1, "Hectometer"/"Second"], 
     Unit[1, "Kilometer"/"Second"], Unit[1, "Megameter"/"Second"], 
     Unit[1, "Gigameter"/"Second"], Unit[1, "Terameter"/"Second"], 
     Unit[1, "Petameter"/"Second"], Unit[1, "Exameter"/"Second"], 
     Unit[1, "Zettameter"/"Second"], Unit[1, "Yottameter"/"Second"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Second"]] = 
    {Unit[1, "Yoctosecond"], Unit[1, "Zeptosecond"], Unit[1, "Attosecond"], 
     Unit[1, "Femtosecond"], Unit[1, "Picosecond"], Unit[1, "Nanosecond"], 
     Unit[1, "Microsecond"], Unit[1, "Millisecond"], Unit[1, "Centisecond"], 
     Unit[1, "Decisecond"], Unit[1, "Second"], Unit[1, "Decasecond"], 
     Unit[1, "Hectosecond"], Unit[1, "Kilosecond"], Unit[1, "Megasecond"], 
     Unit[1, "Gigasecond"], Unit[1, "Terasecond"], Unit[1, "Petasecond"], 
     Unit[1, "Exasecond"], Unit[1, "Zettasecond"], Unit[1, "Yottasecond"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Tesla"]] = 
    {Unit[1, "Yoctotesla"], Unit[1, "Zeptotesla"], Unit[1, "Attotesla"], 
     Unit[1, "Femtotesla"], Unit[1, "Picotesla"], Unit[1, "Nanotesla"], 
     Unit[1, "Microtesla"], Unit[1, "Millitesla"], Unit[1, "Centitesla"], 
     Unit[1, "Decitesla"], Unit[1, "Tesla"], Unit[1, "Decatesla"], 
     Unit[1, "Hectotesla"], Unit[1, "Kilotesla"], Unit[1, "Megatesla"], 
     Unit[1, "Gigatesla"], Unit[1, "Teratesla"], Unit[1, "Petatesla"], 
     Unit[1, "Exatesla"], Unit[1, "Zettatesla"], Unit[1, "Yottatesla"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Volt"]] = 
    {Unit[1, "Yoctovolt"], Unit[1, "Zeptovolt"], Unit[1, "Attovolt"], 
     Unit[1, "Femtovolt"], Unit[1, "Picovolt"], Unit[1, "Nanovolt"], 
     Unit[1, "Microvolt"], Unit[1, "Millivolt"], Unit[1, "Centivolt"], 
     Unit[1, "Decivolt"], Unit[1, "Volt"], Unit[1, "Decavolt"], 
     Unit[1, "Hectovolt"], Unit[1, "Kilovolt"], Unit[1, "Megavolt"], 
     Unit[1, "Gigavolt"], Unit[1, "Teravolt"], Unit[1, "Petavolt"], 
     Unit[1, "Exavolt"], Unit[1, "Zettavolt"], Unit[1, "Yottavolt"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Volt"/"Meter"]] = 
    {Unit[1, "Yoctovolt"/"Meter"], Unit[1, "Zeptovolt"/"Meter"], 
     Unit[1, "Attovolt"/"Meter"], Unit[1, "Femtovolt"/"Meter"], 
     Unit[1, "Picovolt"/"Meter"], Unit[1, "Nanovolt"/"Meter"], 
     Unit[1, "Microvolt"/"Meter"], Unit[1, "Millivolt"/"Meter"], 
     Unit[1, "Centivolt"/"Meter"], Unit[1, "Decivolt"/"Meter"], 
     Unit[1, "Volt"/"Meter"], Unit[1, "Decavolt"/"Meter"], 
     Unit[1, "Hectovolt"/"Meter"], Unit[1, "Kilovolt"/"Meter"], 
     Unit[1, "Megavolt"/"Meter"], Unit[1, "Gigavolt"/"Meter"], 
     Unit[1, "Teravolt"/"Meter"], Unit[1, "Petavolt"/"Meter"], 
     Unit[1, "Exavolt"/"Meter"], Unit[1, "Zettavolt"/"Meter"], 
     Unit[1, "Yottavolt"/"Meter"]}
 
CompatibleUnitsFromSet["PrefixedSI", Unit[1, "Watt"]] = 
    {Unit[1, "Yoctowatt"], Unit[1, "Zeptowatt"], Unit[1, "Attowatt"], 
     Unit[1, "Femtowatt"], Unit[1, "Picowatt"], Unit[1, "Nanowatt"], 
     Unit[1, "Microwatt"], Unit[1, "Milliwatt"], Unit[1, "Centiwatt"], 
     Unit[1, "Deciwatt"], Unit[1, "Watt"], Unit[1, "Decawatt"], 
     Unit[1, "Hectowatt"], Unit[1, "Kilowatt"], Unit[1, "Megawatt"], 
     Unit[1, "Gigawatt"], Unit[1, "Terawatt"], Unit[1, "Petawatt"], 
     Unit[1, "Exawatt"], Unit[1, "Zettawatt"], Unit[1, "Yottawatt"]}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Joule"]] = {}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Kilogram"]] = 
    {Unit[1, "RomanChalcus"], Unit[1, "RomanSiliqua"], 
     Unit[1, "RomanObolus"], Unit[1, "RomanScruple"], Unit[1, "RomanDram"], 
     Unit[1, "RomanShekel"], Unit[1, "RomanOunce"], Unit[1, "RomanPound"], 
     Unit[1, "RomanMine"]}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Meter"]] = 
    {Unit[1, "RomanDigit"], Unit[1, "RomanInch"], Unit[1, "RomanPalm"], 
     Unit[1, "RomanFoot"], Unit[1, "RomanCubit"], Unit[1, "RomanStep"], 
     Unit[1, "RomanPace"], Unit[1, "RomanPerch"], Unit[1, "RomanArpent"], 
     Unit[1, "RomanStadium"], Unit[1, "RomanMile"], Unit[1, "RomanLeague"]}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Meter"^2]] = 
    {Unit[1, "RomanAcre"], Unit[1, "RomanAuneOfFurrows"], 
     Unit[1, "RomanCenturie"], Unit[1, "RomanMorn"], 
     Unit[1, "RomanQuadriplex"], Unit[1, "RomanRood"], Unit[1, "RomanYoke"]}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Ampere"*"Meter"^2]] = 
    {}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Meter"^3]] = 
    {Unit[1, "RomanSpoonful"], Unit[1, "RomanDose"], 
     Unit[1, "RomanDrawingSpoon"], Unit[1, "RomanSixthSester"], 
     Unit[1, "RomanQuarterSpoon"], Unit[1, "RomanThirdSester"], 
     Unit[1, "RomanDryHalfSester"], Unit[1, "RomanHalfSester"], 
     Unit[1, "RomanDoubleThirdSester"], Unit[1, "RomanDrySester"], 
     Unit[1, "RomanSester"], Unit[1, "RomanCongius"], Unit[1, "RomanGallon"], 
     Unit[1, "RomanPeck"], Unit[1, "RomanUrn"], Unit[1, "RomanBushel"], 
     Unit[1, "RomanJar"], Unit[1, "RomanHose"]}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Newton"]] = {}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Pascal"]] = {}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Meter"/"Second"]] = {}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Second"]] = {}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["Roman", Unit[1, "Watt"]] = {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Joule"]] = {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Kilogram"]] = 
    {Unit[1, "Dolia"], Unit[1, "Zolotnik"], Unit[1, "Lot"], Unit[1, "Funt"], 
     Unit[1, "Pood"], Unit[1, "Berkovets"]}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Meter"]] = 
    {Unit[1, "Tochka"], Unit[1, "Liniya"], Unit[1, "Diuym"], 
     Unit[1, "Vershok"], Unit[1, "Piad"], Unit[1, "Fut"], Unit[1, "Arshin"], 
     Unit[1, "Sazhen"], Unit[1, "Versta"], Unit[1, "Milia"]}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Meter"^2]] = 
    {Unit[1, "OfficialDesiatina"], Unit[1, "PropriatorsDesiatina"]}
 
CompatibleUnitsFromSet["Russian", 
     Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Meter"^3]] = 
    {Unit[1, "Shkalik"], Unit[1, "Chast"], Unit[1, "Charka"], 
     Unit[1, "ButylkaVodochnaya"], Unit[1, "ButylkaVinnaya"], 
     Unit[1, "LiquidKruzhka"], Unit[1, "DryKruzhka"], 
     Unit[1, "LiquidChetvert"], Unit[1, "Garnets"], Unit[1, "LiquidVedro"], 
     Unit[1, "DryVedro"], Unit[1, "Chetverik"], Unit[1, "Osmina"], 
     Unit[1, "DryChetvert"], Unit[1, "Bochka"]}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Newton"]] = {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Pascal"]] = {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Meter"/"Second"]] = 
    {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Second"]] = {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["Russian", Unit[1, "Watt"]] = {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Joule"]] = {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Kilogram"]] = 
    {Unit[1, "Ounce"], Unit[1, "Pound"], Unit[1, "Stone"]}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Meter"]] = 
    {Unit[1, "Foot"], Unit[1, "Yard"], Unit[1, "ScottishEll"], 
     Unit[1, "Fall"], Unit[1, "ScottishMile"]}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Meter"^2]] = 
    {Unit[1, "Inch"^2], Unit[1, "ScottishEll"^2], Unit[1, "Fall"^2], 
     Unit[1, "Rood"], Unit[1, "Acre"], Unit[1, "Oxgang"], 
     Unit[1, "Ploughgate"], Unit[1, "Daugh"]}
 
CompatibleUnitsFromSet["Scottish", 
     Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Meter"^3]] = 
    {Unit[1, "Drop"], Unit[1, "Mutchkins"], Unit[1, "Chopin"], 
     Unit[1, "ScottishPint"], Unit[1, "ScottishGallon"]}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Newton"]] = {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Pascal"]] = {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Meter"/"Second"]] = 
    {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Second"]] = {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["Scottish", Unit[1, "Watt"]] = {}
 
CompatibleUnitsFromSet["SI", Unit[1, "Ampere"]] = 
    {Unit[1, "Ampere"]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Byte"]] = {Unit[1, "Bit"]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Coulomb"]] = 
    {Unit[1, "Coulomb"]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Farad"]] = 
    {Unit[1, "Farad"]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Henry"]] = 
    {Unit[1, "Henry"]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Hertz"]] = 
    {Unit[1, "Hertz"]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Joule"]] = 
    {Unit[1, "Joule"]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Kilogram"]] = 
    {Unit[1, "Kilogram"]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Meter"^(-1)]] = 
    {Unit[1, "Meter"^(-1)]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Meter"]] = 
    {Unit[1, "Meter"]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Meter"^2]] = 
    {Unit[1, "Meter"^2]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Ampere"*"Meter"^2]] = 
    {Unit[1, "Ampere"*"Meter"^2]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Meter"^3]] = 
    {Unit[1, "Meter"^3]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Newton"]] = 
    {Unit[1, "Newton"]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Ohm"]] = {Unit[1, "Ohm"]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Meter"*"Ohm"]] = 
    {Unit[1, "Meter"*"Ohm"]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Pascal"]] = 
    {Unit[1, "Pascal"]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Poise"]] = 
    {Unit[1, "Pascal"*"Second"]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Radian"]] = 
    {Unit[1, "Radian"]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Meter"/"Second"]] = 
    {Unit[1, "Meter"/"Second"]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Second"]] = 
    {Unit[1, "Second"]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Tesla"]] = 
    {Unit[1, "Tesla"]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Volt"]] = 
    {Unit[1, "Volt"]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Volt"/"Meter"]] = 
    {Unit[1, "Volt"/"Meter"]}
 
CompatibleUnitsFromSet["SI", Unit[1, "Watt"]] = 
    {Unit[1, "Watt"]}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Joule"]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Kilogram"]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Meter"]] = 
    {Unit[1, "Punto"], Unit[1, "Linea"], Unit[1, "Pulgada"], Unit[1, "Coto"], 
     Unit[1, "Palmo"], Unit[1, "Pie"], Unit[1, "Vara"], Unit[1, "Paso"], 
     Unit[1, "Legua"], Unit[1, "Labor"]}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Meter"^2]] = {}
 
CompatibleUnitsFromSet["Spanish", 
     Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Meter"^3]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Newton"]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Pascal"]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Meter"/"Second"]] = 
    {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Second"]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["Spanish", Unit[1, "Watt"]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Joule"]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Kilogram"]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Meter"]] = 
    {Unit[1, "Link"], Unit[1, "SurveyFoot"], Unit[1, "Rod"], 
     Unit[1, "Chain"], Unit[1, "SurveyMile"], Unit[1, "League"]}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Meter"^2]] = 
    {Unit[1, "SurveyAcre"], Unit[1, "Section"], Unit[1, "Township"]}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Ampere"*"Meter"^2]] = 
    {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Meter"^3]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Newton"]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Pascal"]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Meter"/"Second"]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Second"]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["Survey", Unit[1, "Watt"]] = {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Joule"]] = {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Kilogram"]] = 
    {Unit[1, "SwedishOrt"], Unit[1, "Mark"], Unit[1, "Skalpund"], 
     Unit[1, "SwedishBismerpund"], Unit[1, "Lispund"], Unit[1, "Skeppspund"]}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Meter"]] = 
    {Unit[1, "Fjardingsvag"], Unit[1, "SwedishLinje"], Unit[1, "Tum"], 
     Unit[1, "SwedishKvarter"], Unit[1, "SwedishFot"], Unit[1, "Tvarhand"], 
     Unit[1, "Aln"], Unit[1, "Famn"], Unit[1, "SwedishStang"], 
     Unit[1, "Ref"], Unit[1, "Stenkast"], Unit[1, "Kabellangd"], 
     Unit[1, "SwedishKvartmil"], Unit[1, "Skogsmil"], 
     Unit[1, "SwedishSjomil"], Unit[1, "Nymil"], Unit[1, "SwedishMil"], 
     Unit[1, "Kyndemil"]}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Meter"^2]] = 
    {Unit[1, "Kvadratmil"], Unit[1, "Kannaland"], Unit[1, "Kappland"], 
     Unit[1, "Spannland"], Unit[1, "Tunnland"]}
 
CompatibleUnitsFromSet["Swedish", 
     Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Meter"^3]] = 
    {Unit[1, "Pot"], Unit[1, "Ankare"], Unit[1, "SwedishOhm"], 
     Unit[1, "Storfavn"], Unit[1, "Kubikkfavn"]}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Newton"]] = {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Pascal"]] = {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Meter"/"Second"]] = 
    {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Second"]] = {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["Swedish", Unit[1, "Watt"]] = {}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Joule"]] = {}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Kilogram"]] = 
    {Unit[1, "Cash"], Unit[1, "Candareen"], Unit[1, "Mace"], Unit[1, "Tael"], 
     Unit[1, "Catty"], Unit[1, "Picul"]}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Meter"]] = 
    {Unit[1, "Chhun"], Unit[1, "Chhioh"]}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Meter"^2]] = 
    {Unit[1, "Pheng"], Unit[1, "Bo"], Unit[1, "Le"], Unit[1, "Kah"]}
 
CompatibleUnitsFromSet["Taiwanese", 
     Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Meter"^3]] = 
    {Unit[1, "Meter"^3]}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Newton"]] = {}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Pascal"]] = {}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["Taiwanese", 
     Unit[1, "Meter"/"Second"]] = {}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Second"]] = {}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Volt"/"Meter"]] = 
    {}
 
CompatibleUnitsFromSet["Taiwanese", Unit[1, "Watt"]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Joule"]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Kilogram"]] = 
    {Unit[1, "Grain"], Unit[1, "Pennyweight"], Unit[1, "TroyOunce"], 
     Unit[1, "TroyPound"]}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Meter"^(-1)]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Meter"]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Meter"^2]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Meter"^3]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Newton"]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Meter"*"Ohm"]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Pascal"]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Radian"]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Meter"/"Second"]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Second"]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["Troy", Unit[1, "Watt"]] = {}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Ampere"]] = {}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Byte"]] = {}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Coulomb"]] = {}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Farad"]] = {}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Henry"]] = {}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Hertz"]] = {}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Joule"]] = 
    {Unit[1, "Calorie"], Unit[1, "BritishThermalUnit"]}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Kilogram"]] = 
    {Unit[1, "Grain"], Unit[1, "Pennyweight"], Unit[1, "Dram"], 
     Unit[1, "Ounce"], Unit[1, "TroyOunce"], Unit[1, "TroyPound"], 
     Unit[1, "Pound"], Unit[1, "ShortHundredweight"], Unit[1, "ShortTon"]}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Meter"^(-1)]] = 
    {}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Meter"]] = 
    {Unit[1, "Inch"], Unit[1, "Hand"], Unit[1, "Link"], Unit[1, "Foot"], 
     Unit[1, "SurveyFoot"], Unit[1, "Yard"], Unit[1, "Fathom"], 
     Unit[1, "Rod"], Unit[1, "Chain"], Unit[1, "Cable"], Unit[1, "Mile"], 
     Unit[1, "SurveyMile"], Unit[1, "NauticalMile"], Unit[1, "League"]}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Meter"^2]] = 
    {Unit[1, "Foot"^2], Unit[1, "Chain"^2], Unit[1, "Acre"], 
     Unit[1, "SurveyAcre"], Unit[1, "Section"], Unit[1, "Township"]}
 
CompatibleUnitsFromSet["USCustomary", 
     Unit[1, "Ampere"*"Meter"^2]] = {}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Meter"^3]] = 
    {Unit[1, "FluidDram"], Unit[1, "Teaspoon"], Unit[1, "Tablespoon"], 
     Unit[1, "Inch"^3], Unit[1, "Jigger"], Unit[1, "USGill"], 
     Unit[1, "Pint"], Unit[1, "DryPint"], Unit[1, "Quart"], 
     Unit[1, "DryQuart"], Unit[1, "BoardFoot"], Unit[1, "Gallon"], 
     Unit[1, "DryGallon"], Unit[1, "Peck"], Unit[1, "Foot"^3], 
     Unit[1, "Bushel"], Unit[1, "DryBarrel"], Unit[1, "Barrel"], 
     Unit[1, "OilBarrel"], Unit[1, "Hogshead"], Unit[1, "Yard"^3], 
     Unit[1, "Acre"*"Foot"]}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Newton"]] = 
    {Unit[1, "PoundForce"]}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Ohm"]] = {}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Meter"*"Ohm"]] = 
    {}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Pascal"]] = 
    {Unit[1, "PSI"]}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Poise"]] = {}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Radian"]] = 
    {Unit[1, "Degree"]}
 
CompatibleUnitsFromSet["USCustomary", 
     Unit[1, "Meter"/"Second"]] = {Unit[1, "Mile"/"Hour"]}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Second"]] = 
    {Unit[1, "Second"], Unit[1, "Minute"], Unit[1, "Hour"], Unit[1, "Day"], 
     Unit[1, "Week"], Unit[1, "Month"], Unit[1, "Year"]}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Tesla"]] = {}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Volt"]] = {}
 
CompatibleUnitsFromSet["USCustomary", 
     Unit[1, "Volt"/"Meter"]] = {}
 
CompatibleUnitsFromSet["USCustomary", Unit[1, "Watt"]] = 
    {Unit[1, "Horsepower"]}
    
    
  