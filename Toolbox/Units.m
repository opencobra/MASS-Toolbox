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
Minute = Quantity["Minutes"];
Hour = Quantity["Hours"];
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


Toolbox`Private`prefixify[name_String]:=(#<>name<>" = "<>ToString[Quantity[#<>name<>"s"],InputForm])&/@
		{"Kilo","Centi","Milli","Micro","Nano","Pico"}


ToExpression/@Toolbox`Private`prefixify[#]&/@{"mole","coulomb","farad","joule","gram","meter","mole","newton","liter","second"}


(* ::Subsubsection:: *)
(*Backwards Compatibility*)


AutomaticUnits`Unit[number_,amount_]:=Quantity[number,amount/.(string_String:>(ToUpperCase[StringTake[string,1]]<>StringDrop[string,1]<>"s"))];


Unit[number_,amount_]:=Quantity[number,amount/.(string_String:>(ToUpperCase[StringTake[string,1]]<>StringDrop[string,1]<>"s"))];


End[]
