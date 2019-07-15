/datum/category_group/skill/combat
	name = "Combat"
	category_item_type = /datum/category_item/skill/combat

// Firearms
/datum/category_item/skill/combat/guns
	id = SKILL_GUNS
	name = "Firearms Training"
	flavor_desc = "Your character’s knowledge and skill of using hand-held and mounted firearms."
	govern_desc = "Governs what kind of weapons someone can easily use, ease of reloading, and using mounted guns."
	typical_desc = "A low level is typical for many different jobs that may utilize ranged weapons. \
	A high level is typical of specialists trained to use high-power weapons, requiring high-accuracy and discipline."
	levels = list(
		/datum/skill_level/guns/zero,
		/datum/skill_level/guns/one,
		/datum/skill_level/guns/two,
		/datum/skill_level/guns/three
		)

/datum/skill_level/guns/zero
	name = "Untrained"
	flavor_desc = "You have basic safety training common to people who read firearms magazines or \
	indulge in other related media. You know which end of the gun should be pointed at the target."
	mechanics_desc = "Can fire weapons at a greatly decreased speed.<br>\
	Can reliably use small energy-based arms.<br>\
	Can operate weapon cells slowly, but ballistic magazine loading is greatly delayed.<br>\
	Will have penalties when trying to use two-handed weapons.<br>\
	Your reaction fire from aiming is less reliable."

/datum/skill_level/guns/one
	name = "Civilian Training"
	flavor_desc = "You can comfortably use standard energy weapons, and may do so regularly in the course of your work. \
	You’ve also been trained in the usage of various pieces of mounted equipment."
	mechanics_desc = "Can fire weapons at a slightly decreased speed.<br>\
	Can operate larger firearms reliably.<br>\
	Shorter weapon cell loading time.<br>\
	Shorter ballistic loading time.<br>\
	Can properly use sights or scopes on weapons."
	cost = 10

/datum/skill_level/guns/two
	name = "Firearm Specialist"
	flavor_desc = "You can use all kinds of weapons, including specialized mounted weapons, and you’ve become accustomed to repeating ballistic kick."
	mechanics_desc = "Can fire weapons at a standard speed.<br>\
	Can load ballistics instantly."
	cost = 25

/datum/skill_level/guns/three
	name = "Firearms Expert"
	flavor_desc = "Your firearms are essentially extensions of your body, and you know them as such."
	mechanics_desc = "Firearm encumberance is slightly decreased.<br>\
	Will no longer accidentally discharge weapons when disarmed.<br>\
	Reload speed for energy weapons is decreased.<br>\
	Ballistic weapons can be 'tactically loaded', by using a magazine on a gun."
	enhancing = TRUE
	cost = 50

// Armed Melee
/datum/category_item/skill/combat/melee
	id = SKILL_MELEE
	name = "Armed Melee Training"
	flavor_desc = "Your character’s knowledge and skill of using melee weapons. Surprisingly common in space."
	govern_desc = "Governs what kind of weapons someone can easily use, ease of blocking, and using high-tech variants."
	typical_desc = "A low level is typical for many different jobs that may utilize melee tools. \
	A high level is typical of specialists trained to use high-power weapons, requiring finesse and discipline."
	levels = list(
		/datum/skill_level/melee/zero,
		/datum/skill_level/melee/one,
		/datum/skill_level/melee/two,
		/datum/skill_level/melee/three
		)

/datum/skill_level/melee/zero
	name = "Untrained"
	flavor_desc = "You have basic safety training common to people who watch renaissance shows or \
	indulge in other related media. You know which end of the knife should be pointed at the target."
	mechanics_desc = "Can reliably use most small weapons.<br>\
	Can wield a shield, though ineffectively.<br>\
	Will have penalties when trying to use two-handed weapons.<br>\
	Your general blocking is less reliable.<br>\
	Your melee speed is greatly delayed."

/datum/skill_level/melee/one
	name = "Sports Training"
	flavor_desc = "You can comfortably use standard melee weapons, and may do so regularly in the course of your work. \
	You’ve also been trained in the usage of various pieces of security equipment."
	mechanics_desc = "Can properly utilize shields.<br>\
	Can properly utilize flashes.<br>\
	Can properly utilize stunbatons.<br>\
	Melee delay is decreased."
	cost = 10

/datum/skill_level/melee/two
	name = "Melee Specialist"
	flavor_desc = "You can use all kinds of weapons, including specialized energy-weapons, and you’ve become accustomed to handling two-handed weapons."
	mechanics_desc = "Can utilize melee weapons without an accuracy or speed penalty.<br>\
	Melee strikes on Disarm intent can dislocate limbs."
	cost = 25

/datum/skill_level/melee/three
	name = "Melee Expert"
	flavor_desc = "Your melee weapons are essentially extensions of your body, and you can manipulate them as such."
	mechanics_desc = "Block chance is increased universally.<br>\
	Attack speed is increased universally.<br>\
	Two-handed weapons gain a damage bonus when aiming for center of mass."
	enhancing = TRUE
	cost = 50

//Unarmed.
/datum/category_item/skill/combat/unarmed
	id = SKILL_UNARMED
	name = "Unarmed Combat"
	flavor_desc = "Your character’s knowledge and skill in hand-to-hand combat."
	govern_desc = "Governs how effective someone is at hand-to-hand combat."
	typical_desc = "A low level is typical for anyone not engaged in hand-to-hand sports or other combat scenarios.\
	A high level is typical for individuals with training for handling unruly persons."
	levels = list(
		/datum/skill_level/unarmed/zero,
		/datum/skill_level/unarmed/one,
		/datum/skill_level/unarmed/two,
		/datum/skill_level/unarmed/three
		)

/datum/skill_level/unarmed/zero
	name = "Untrained"
	flavor_desc = "You have general knowledge from watching people fight in media \
	or general exercise."
	mechanics_desc = "Grab delays are severely increased.<br>\
	You are much easier for others to grab.<br>\
	It is hard to disarm others."

/datum/skill_level/unarmed/one
	name = "Sports Training"
	flavor_desc = "You train for some form of hand-to-hand sport, so you know how to hit where it hurts, but doesn't Hurt."
	mechanics_desc = "Can dislocate and pin others' limbs in grabs.<br>\
	Slightly easier for others to grab.<br>\
	Can pull punches."
	cost = 10

/datum/skill_level/unarmed/two
	name = "Martial Training"
	flavor_desc = "You are trained explicitly to handle unruly individuals and take them down barehanded if necessary."
	mechanics_desc = "General ability to reliably escape grabs of weaker individuals.<br>\
	You can force people to the ground reliably."
	cost = 25

/datum/skill_level/unarmed/three
	name = "Martial Artist"
	flavor_desc = "Your hands are required by law to be registered as lethal weapons."
	mechanics_desc = "Slight increase in dodge chance when engaged in melee.<br>\
	Punching will always do additional halloss.<br>\
	You only require a basic grab to throw someone."
	enhancing = TRUE
	cost = 50
