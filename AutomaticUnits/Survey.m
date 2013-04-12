UnitSet["Survey"]={(*Survey distances*)
	DeclareUnit["Link", Unit[33/50, "Foot"], UsageMessage->"Link is a unit of length.",TraditionalLabel->"li"],
	DeclareUnit["Chain", Unit[66, "Foot"], UsageMessage->"Chain is a unit of length.",TraditionalLabel->"ch"],
	DeclareUnit["Rod", Unit[25, "Link"], UsageMessage->"Rod is a unit of length.",TraditionalLabel->"rd"], 
	DeclareUnit["SurveyFoot", Unit[1200/3937,"Meter"], UsageMessage->"SurveyMile is a unit of length.",TraditionalLabel->"ft"],
	DeclareUnit["SurveyMile", Unit[5280, "SurveyFoot"], UsageMessage->"SurveyMile is a unit of length.",TraditionalLabel->"mi"], (*Change from M7*)
	DeclareUnit["League", Unit[3, "SurveyMile"], UsageMessage->"League is a unit of length.",TraditionalLabel->"lea"],
	(*Area*)
	DeclareUnit["SurveyAcre", Unit[43560, "SurveyFoot"^2], UsageMessage->"SurveyAcre is a unit of area."],
	DeclareUnit["Section", Unit["SurveyMile"]^2, UsageMessage->"Section is a unit of area."], 
	DeclareUnit["Township", Unit[36, "Section"], UsageMessage->"Township is a unit of area.",TraditionalLabel->"twp"]
};