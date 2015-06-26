UnitSet["Atomic"]={
	DeclareUnit["ElectronRestMass",Unit[9.109382616*^-31,"Kilogram"],
		UsageMessage->"ElectronRestMass is the atomic unit of mass.",TraditionalLabel->SubscriptBox["m","e"]],
	DeclareUnit["BohrRadius",Unit[5.29177210818*^-11,"Meter"],
		UsageMessage->"BohrRadius is the atomic unit of mass.",TraditionalLabel->SubscriptBox["a","0"]],
	DeclareUnit["ElementaryCharge",Unit[1.6021765314*^-19,"Coulomb"],
		UsageMessage->"ElementaryCharge is the atomic unit of charge.",TraditionalLabel->"e"],	
	DeclareUnit["ReducedPlanckConstant",1.0545716818*^-34 Unit["Joule"]Unit["Second"],
		UsageMessage->"ReducedPlanckConstant is the atomic unit of angular momentum.",TraditionalLabel->"\[HBar]"],		
	DeclareUnit["HartreeEnergy",Unit[4.3597441775*^-18,"Joule"],
		UsageMessage->"HartreeEnergy is the atomic unit of energy.",TraditionalLabel->SubscriptBox["E","h"]],
		(*Time*)
	Unit["ReducedPlanckConstant"]/Unit["HartreeEnergy"],
		(*Velocity*)
	Unit["BohrRadius"] Unit["HartreeEnergy"]/Unit["ReducedPlanckConstant"],	
	(*Force*)
	Unit["HartreeEnergy"]/Unit["BohrRadius"],
	(*Pressure*)
	Unit["HartreeEnergy"]/Unit["BohrRadius"]^3
};