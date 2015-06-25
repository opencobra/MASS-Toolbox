
UnitSet["AlternativeNames"]={
(*Alternate names*)
DeclareUnit["StatuteMile", Unit[1, "SurveyMile"], UsageMessage->"StatuteMile is a unit of length."], (*No short label*)
DeclareUnit["UKGallon", Unit[4.54609, "Liter"], UsageMessage->"UKGallon is a British volume unit.",TraditionalLabel->"impgal"], 
DeclareUnit["UKPint", Unit[0.568261, "Liter"], UsageMessage->"UKPint is a British volume unit.",TraditionalLabel->"ipt"], 
DeclareUnit["Feet", Unit[1, "Foot"], UsageMessage->"Feet is a unit of length."],
DeclareUnit["AvoirdupoisOunce", Unit[1, "Ounce"], UsageMessage->"AvoirdupoisOunce is a unit of weight."], 
DeclareUnit["AvoirdupoisPound", Unit[1, "Pound"], UsageMessage->"AvoirdupoisPound is a unit of weight."], 
DeclareUnit["GrossHundredweight", Unit[1, "Hundredweight"], UsageMessage->"GrossHundredweight is a unit of weight."], 
DeclareUnit["BTU", Unit["BritishThermalUnit"], UsageMessage->"BTU is a unit of energy.",TraditionalLabel -> "Btu"], (*Value change since M7*)
DeclareUnit["AMU", Unit[1.66053878283*^-24, "Gram"], UsageMessage->"AMU is a unit of mass."], (*Improved value*)
DeclareUnit["Dalton", Unit[1, "AMU"], UsageMessage->"Dalton is a unit of mass."], 
(*Legacy units*)
DeclareUnit["Ton", Unit[2000, "Pound"], UsageMessage->"Ton is a unit of weight."],(*Short and Long are used elsewhere now*)
DeclareUnit["Gill", Unit[1/4, "Pint"], UsageMessage->"Gill is a unit of volume.",TraditionalLabel->"gi"], (*This is now the USGill*)
DeclareUnit["Noggin", Unit[1, "Gill"], UsageMessage->"Noggin is a unit of volume."], (*Defined in M7 but cannot find source*)
DeclareUnit["Franklin",Unit[1,"Statcoulomb"],UsageMessage->"Franklin is a unit of electric charge.",TraditionalLabel -> "Fr"],

(*Alternatives for conflict names*)
DeclareUnit["Cup", Unit[1/2, "Pint"], CreateSymbol -> False], (*Legacy compatibility unit*)
DeclaureUnit["CupUnit",Unit["Cup"],UsageMessage->"CupUnit is a unit of volume."],
DeclareUnit["ByteUnit",Unit["Byte"],UsageMessage->"ByteUnit is a unit of data."],
DeclareUnit["DegreeAngle",Unit["Degree"],UsageMessage->"DegreeAngle is a unit of angle."],
DeclareUnit["CircleAngle", Unit["Circle"],UsageMessage->"CircleAngle is a unit of angle."],
DeclareUnit["SpanLength", Unit["Span"],UsageMessage->"SpanLength is a unit of length."],
DeclareUnit["LastVolume", Unit["Last"],UsageMessage->"LastVolume is a unit of volume."],
DeclareUnit["DropVolume", Unit["Drop"],UsageMessage->"Drop is a unit of volume."],
DeclareUnit["PointLength", Unit["Point"],UsageMessage->"PointLength is a unit of volume."],
DeclareUnit["GammaMagnetism", Unit["Gamma"],UsageMessage->"GammaMagnetism is a unit of magnetism."],
DeclareUnit["GrayRadioactivity", Unit["Gray"],UsageMessage->"GrayRadioactivity is a unit of radioactivity"]
};


(*TODO: Units still to define...

More units - http://en.wikipedia.org/wiki/Conversion_of_units

Need more information
http://en.wikipedia.org/wiki/Romanian_units_of_measurement		This system is a mess
http://en.wikipedia.org/wiki/Persian_units_of_measurement		Can't tell what the names are from this
http://en.wikipedia.org/wiki/Jewish_and_biblical_units_of_measurement   These are all intervals and Interval is not supported yet
http://en.wikipedia.org/wiki/Tamil_units_of_measurement     Mostly missing metric conversion values
http://en.wikipedia.org/wiki/Obsolete_Polish_units_of_measurement     Insufficient data


Obsolete units
http://en.wikipedia.org/wiki/Ancient_Mesopotamian_units_of_measurement
http://en.wikipedia.org/wiki/Old_Irish_units_of_measurement
http://en.wikipedia.org/wiki/Obsolete_Tatar_units_of_measurement
ObsoleteJapanese
http://en.wikipedia.org/wiki/Japanese_units_of_measurement





*)
