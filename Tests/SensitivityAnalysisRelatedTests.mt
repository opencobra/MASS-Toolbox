(* Mathematica Test File *)

Test[
	calcLinIndependentFreq[5]
	,
	{11, 21, 27, 35, 39}
	,
	TestID->"SensitivityAnalysisRelatedTests-20110526-X0U9V8"
]

Test[
	calcLinIndependentFreq[10]
	,
	{25, 63, 103, 135, 157, 177, 187, 193, 201, 205}
	,
	TestID->"SensitivityAnalysisRelatedTests-20110526-J2R9T8"
]

Test[
	calcLinIndependentFreq[14]
	,
	{87, 133, 195, 251, 277, 315, 355, 387, 409, 429, 439, 445, 453, 457}
	,
	TestID->"SensitivityAnalysisRelatedTests-20110526-R9W5I8"
]

Test[
	calcLinIndependentFreq[19]
	,
	{149, 275, 361, 421, 517, 593, 639, 701, 757, 783, 821, 861, 893, 915, 935, 945, 951, 959, 963}
	,
	TestID->"SensitivityAnalysisRelatedTests-20110526-V8P8Q3"
]

Test[
	calcLinIndependentFreq[50]
	,
	{2019, 2185, 2673, 2773, 2989, 3585, 3973, 4421, 4669, 5079, 5517, 5819, 6387, 6671, 6841, 6981, 7167, 7515, 7603, 7985, 8183, 8511, 8719, 8825, 9241, 9275, 9471, 9625, 9753, 9845, 9957, 10091, 10217, 10303, 10363, 10459, 10535, 10581, 10643, 10699, 10725, 10763, 10803, 10835, 10857, 10877, 10887, 10893, 10901, 10905}
	,
	TestID->"SensitivityAnalysisRelatedTests-20110526-O6A1F3"
]

Test[
	CheckAbort[calcLinIndependentFreq[51], True]
	,
	True
	,
	{calcLinIndependentFreq::dim}
	,
	TestID->"SensitivityAnalysisRelatedTests-20110526-I5X9X6"
]