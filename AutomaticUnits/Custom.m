(* ::Package:: *)

(* Custom file to include Moles and all prefixed versions as units *)

Remove[Mole]
UnitSet["Custom"]={
    DeclareUnit["itemUnit", Unit[1, "itemUnit"],
    UsageMessage->"This is a custom item",
    TraditionalLabel->"item"],

	DeclareUnit["Mole", Unit[1,"Mole"],
	UsageMessage->"Mole is the unit of substance or amount",
	TraditionalLabel->"mol"]
};

AutomaticUnits`private`SIPrefixify["Mole","substance","mol"]

