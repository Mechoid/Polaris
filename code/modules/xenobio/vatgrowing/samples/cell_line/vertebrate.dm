#define VAT_GROWTH_RATE 4

////////////////////////////////
//// 		VERTEBRATES		////
////////////////////////////////

/datum/micro_organism/cell_line/mouse //nuisance cell line designed to complicate the growing of animal type cell lines.
	desc = "Murine cells"
	required_reagents = list(/datum/reagent/consumable/nutriment/protein)
	supplementary_reagents = list(
							/datum/reagent/growthserum = 2,
							/datum/reagent/liquidgibs = 2,
							/datum/reagent/consumable/cornoil = 2,
							/datum/reagent/consumable/nutriment = 1,
							/datum/reagent/consumable/nutriment/vitamin = 1,
							/datum/reagent/consumable/sugar = 1,
							/datum/reagent/consumable/cooking_oil = 1,
							/datum/reagent/consumable/rice = 1,
							/datum/reagent/consumable/eggyolk = 1)

	suppressive_reagents = list(
							/datum/reagent/toxin/heparin = -6,
							/datum/reagent/consumable/astrotame = -4, //Saccarin gives rats cancer.
							/datum/reagent/consumable/ethanol/rubberneck = -3,
							/datum/reagent/consumable/grey_bull = -1)

	virus_suspectibility = 2
	growth_rate = VAT_GROWTH_RATE
	resulting_atoms = list(/mob/living/simple_animal/mouse = 2)

/datum/micro_organism/cell_line/chicken //basic cell line designed as a good source of protein and eggyolk.
	desc = "Galliform skin cells."
	required_reagents = list(/datum/reagent/consumable/nutriment/protein)
	supplementary_reagents = list(
							/datum/reagent/consumable/rice = 4,
							/datum/reagent/growthserum = 3,
							/datum/reagent/consumable/eggyolk = 1,
							/datum/reagent/consumable/nutriment/vitamin = 2)

	suppressive_reagents = list(/datum/reagent/fuel/oil = -4,
								/datum/reagent/toxin = -2)

	virus_suspectibility = 1
	growth_rate = VAT_GROWTH_RATE
	resulting_atoms = list(/mob/living/simple_animal/chicken = 1)

/datum/micro_organism/cell_line/cow
	desc = "Bovine stem cells"
	required_reagents = list(
						/datum/reagent/consumable/nutriment/protein,
						/datum/reagent/consumable/nutriment,
						/datum/reagent/cellulose)

	supplementary_reagents = list(
						/datum/reagent/growthserum = 4,
						/datum/reagent/consumable/nutriment/vitamin = 2,
						/datum/reagent/consumable/rice = 2,
						/datum/reagent/consumable/flour = 1)

	suppressive_reagents = list(/datum/reagent/toxin = -2,
							/datum/reagent/toxin/carpotoxin = -5)

	virus_suspectibility = 1
	resulting_atoms = list(/mob/living/simple_animal/cow = 1)

/datum/micro_organism/cell_line/cat
	desc = "Feliform cells"
	required_reagents = list(
						/datum/reagent/consumable/nutriment/protein,
						/datum/reagent/liquidgibs
						)
	supplementary_reagents = list(
						/datum/reagent/growthserum = 3,
						/datum/reagent/consumable/nutriment/vitamin = 2,
						/datum/reagent/medicine/oculine = 2,
						/datum/reagent/consumable/milk = 1) //milkies
	suppressive_reagents = list(
						/datum/reagent/consumable/coco = -4,
						/datum/reagent/consumable/hot_coco = -2,
						/datum/reagent/consumable/chocolatepudding = -2,
						/datum/reagent/consumable/milk/chocolate_milk = -1)

	virus_suspectibility = 1.5
	resulting_atoms = list(/mob/living/simple_animal/pet/cat = 1) //The basic cat mobs are all male, so you mightt need a gender swap potion if you want to fill the fortress with kittens.

/datum/micro_organism/cell_line/corgi
	desc = "Canid cells"
	required_reagents = list(
						/datum/reagent/consumable/nutriment/protein,
						/datum/reagent/liquidgibs)

	supplementary_reagents = list(
						/datum/reagent/growthserum = 3,
						/datum/reagent/barbers_aid = 3,
						/datum/reagent/consumable/nutriment/vitamin = 2)

	suppressive_reagents = list(
						/datum/reagent/consumable/garlic = -2,
						/datum/reagent/consumable/tearjuice = -3,
						/datum/reagent/consumable/coco = -2)
	virus_suspectibility = 1
	resulting_atoms = list(/mob/living/simple_animal/pet/dog/corgi = 1)

/datum/micro_organism/cell_line/pug
	desc = "Squat canid cells"
	required_reagents = list(
						/datum/reagent/consumable/nutriment/protein,
						/datum/reagent/liquidgibs)

	supplementary_reagents = list(
						/datum/reagent/growthserum = 2,
						/datum/reagent/consumable/nutriment/vitamin = 3)

	suppressive_reagents = list(
						/datum/reagent/consumable/garlic = -2,
						/datum/reagent/consumable/tearjuice = -3,
						/datum/reagent/consumable/coco = -2)

	virus_suspectibility = 3
	resulting_atoms = list(/mob/living/simple_animal/pet/dog/pug = 1)

/datum/micro_organism/cell_line/bear //bears can't really compete directly with more powerful creatures, so i made it possible to grow them real fast.
	desc = "Ursine cells"
	required_reagents = list(
						/datum/reagent/consumable/nutriment/protein,
						/datum/reagent/liquidgibs,
						/datum/reagent/medicine/c2/synthflesh) //Nuke this if the dispenser becomes xenobio meta.

	supplementary_reagents = list(
						/datum/reagent/consumable/honey = 8, //Hunny.
						/datum/reagent/growthserum = 5,
						/datum/reagent/medicine/morphine = 4, //morphine is a vital nutrient for space bears, but it is better as a supplemental for gameplay reasons.
						/datum/reagent/consumable/nutriment/vitamin = 3)

	suppressive_reagents = list(
						/datum/reagent/consumable/condensedcapsaicin = -4, //bear mace, steal it from the sec checkpoint.
						/datum/reagent/toxin/carpotoxin = -2,
						/datum/reagent/medicine/insulin = -2) //depletes hunny.

	virus_suspectibility = 2
	resulting_atoms = list(/mob/living/simple_animal/hostile/bear = 1)

/datum/micro_organism/cell_line/carp
	desc = "Cyprinid cells"
	required_reagents = list(
						/datum/reagent/consumable/nutriment/protein,
						/datum/reagent/consumable/nutriment)

	supplementary_reagents = list(
						/datum/reagent/consumable/cornoil = 4, //Carp are oily fish
						/datum/reagent/toxin/carpotoxin = 3,
						/datum/reagent/consumable/cooking_oil = 2,
						/datum/reagent/consumable/nutriment/vitamin = 2)

	suppressive_reagents = list(
						/datum/reagent/toxin/bungotoxin = -6,
						/datum/reagent/mercury = -4,
						/datum/reagent/oxygen = -3)

	virus_suspectibility = 2
	resulting_atoms = list(/mob/living/simple_animal/hostile/carp = 1)

/datum/micro_organism/cell_line/megacarp
	desc = "Cartilaginous cyprinid cells"
	required_reagents = list(
						/datum/reagent/consumable/nutriment/protein,
						/datum/reagent/medicine/c2/synthflesh,
						/datum/reagent/consumable/nutriment)

	supplementary_reagents = list(
						/datum/reagent/consumable/cornoil = 4,
						/datum/reagent/growthserum = 3,
						/datum/reagent/toxin/carpotoxin = 2,
						/datum/reagent/consumable/cooking_oil = 2,
						/datum/reagent/consumable/nutriment/vitamin = 2)

	suppressive_reagents = list(
						/datum/reagent/toxin/bungotoxin = -6,
						/datum/reagent/oxygen = -3)

	virus_suspectibility = 1
	resulting_atoms = list(/mob/living/simple_animal/hostile/carp/megacarp = 1)
