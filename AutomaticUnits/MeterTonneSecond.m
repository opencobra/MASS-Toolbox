UnitSet["MeterTonneSecond"]={
	Unit["Meter"],Unit["Second"],
	DeclareUnit["Tonne", Unit[1000000, "Gram"], UsageMessage->"Tonne is a unit of mass.",TraditionalLabel->"t"],
	DeclareUnit["MetricTon", Unit[1, "Tonne"], UsageMessage->"MetricTon is a unit of mass."],
	DeclareUnit["Stere", Unit["Meter"]^3, UsageMessage->"Stere is a unit of volume.",TraditionalLabel -> "st"] ,
	DeclareUnit["Sthene",Unit[1000, "Newton"],UsageMessage->"Sthene is a unit of force in the Metere Tonne Second unit system."],
	DeclareUnit["Pieze",Unit[1000,"Pascal"],UsageMessage->"Pieze is a unit of pressure in the Metere Tonne Second unit system."],
	Unit["Sthene"] Unit["Meter"], Unit["Sthene"] Unit["Meter"]/Unit["Second"]
};