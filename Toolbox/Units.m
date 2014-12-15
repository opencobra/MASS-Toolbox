(* ::Package:: *)

(* ::Title:: *)
(*Units*)


Begin["`Units`"];


(* ::Section:: *)
(*Definitions*)


Ampere = Quantity["Amperes"];
Mole = Quantity["Moles"];
Becquerel = Quantity["Becquerels"];
Candela = Quantity["Candelas"];
Coulomb = Quantity["Coulombs"];
Farad = Quantity["Farads"];
Joule = Quantity["Joules"];
Lux = Quantity["Lux"];
Gram = Quantity["Grams"];
Meter = Quantity["Meters"];
Kelvin = Quantity["Kelvins"];
Mole = Quantity["Moles"];
Henry = Quantity["Henries"];
Newton = Quantity["Newtons"];
Hertz = Quantity["Hertz"];
Liter = Quantity["Liters"];
Ohm = Quantity["Ohms"];
Lumen = Quantity["Lumens"];
Pascal = Quantity["Pascals"];
Radian = Quantity["Radians"];
Volt = Quantity["Volts"];
Second = Quantity["Seconds"];
Watt = Quantity["Watts"];
Siemens = Quantity["Siemens"];
Weber = Quantity[1,"Webers"];
Steradian = Quantity[1,"Steradians"];
Tesla = Quantity[1,"Teslas"];


(* ::Subsection:: *)
(*Prefixes*)


Yotta=1000000000000000000000000;
Zetta=1000000000000000000000;
Exa=1000000000000000000;
Peta=1000000000000000;
Tera=1000000000000;
Giga=1000000000;
Mega=1000000;
Kilo=1000;
Hecto=100;
Deca=10;
Deci=1/10;
Centi=1/100;
Milli=1/1000;
Micro=1/1000000;
Nano=1/1000000000;
Pico=1/1000000000000;
Femto=1/1000000000000000;
Atto=1/1000000000000000000;
Zepto=1/1000000000000000000000;
Yocto=1/1000000000000000000000000;


Private`prefixify[name_String]:=Module[{unitName},
	unitName= ToUpperCase[First[Characters[name]]]<>Rest[Characters[name]]<>"s";
	(#<>name<>" = "<>ToString[Quantity[ToExpression[#],unitName],InputForm])&/@
		{"Yotta","Zetta","Exa","Peta","Tera","Giga","Mega","Kilo","Hecto","Deca",
		"Deci","Centi","Milli","Micro","Nano","Pico","Femto","Atto","Zepto","Yocto"}
]


ToExpression/@Private`prefixify[#]&/@{"ampere","mole","becquerel","candela","coulomb","farad","joule","gram","meter","kelvin","mole","newton","liter","ohm","lumen","pascal","volt","second","watt","weber","steradian","tesla"}


End[]
