UnitSet["BritishAvoirdupois"]={
	Unit["Grain"],
	Unit["Dram"],
	Unit["Ounce"],
	Unit["Pound"],
	DeclareUnit["Stone", Unit[14, "Pound"], UsageMessage->"Stone is a unit of weight."],
	DeclareUnit["LongTon", Unit[2240, "Pound"], UsageMessage->"LongTon is a unit of weight."],
	DeclareUnit["Hundredweight", Unit[112, "Pound"], UsageMessage->"Hundredweight is the Imperial unit of weight.",TraditionalLabel->"cwt"]
};