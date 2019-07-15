/*****************
* GENERAL SKILLS *
*****************/

/datum/category_group/skill/general
	name = "General"
	category_item_type = /datum/category_item/skill/general

/datum/category_item/skill/general/exosuits
	id = SKILL_EXOSUITS
	name = "Exosuit Operation"
	flavor_desc = "How well your character is able to pilot various kinds of exosuits."
	govern_desc = "Governs the ability to use exosuits on a general level. The various tools attached may demand \
	additional skills beyond this one."
	typical_desc = "A low level is typical of various professions with access to exosuits, such as miners, engineers, \
	and EMT personnel. A high level is typical of private security, police, or military specialists."
	levels = list(
		/datum/skill_level/exosuits/zero,
		/datum/skill_level/exosuits/one,
		/datum/skill_level/exosuits/two,
		/datum/skill_level/exosuits/three
		)

/datum/skill_level/exosuits/zero
	name = "Untrained"
	flavor_desc = "You are unfamiliar with exosuit controls, and if you attempt to use them you are liable to make mistakes."
	mechanics_desc = "Input is often scrambled when using any exosuit."

/datum/skill_level/exosuits/one
	name = "Class C Operations"
	flavor_desc = "You have been trained in exosuit operation and safety for common civilian exosuits."
	mechanics_desc = "Can use �civilian� exosuits like the Ripley or the Odysseus without penalties."
	cost = 10

/datum/skill_level/exosuits/two
	name = "Class A Operations"
	flavor_desc = "You�ve worked with exosuits extensively, and you know how to safely use the more complicated exosuits intended for combat operations."
	mechanics_desc = "Can additionally use the �combat� exosuits like the Durand or the Gygax without penalties."
	cost = 30

/datum/skill_level/exosuits/three
	name = "Class S Operations"
	flavor_desc = "Your exosuits� cockpit is like a second home to you. You know how to get the most out of controlling a huge machine surrounding you."
	mechanics_desc = "Some exosuit tools will have unique abilities enabled when you are operating them."
	enhancing = TRUE
	cost = 60

/datum/category_item/skill/general/eva
	id = SKILL_EVA
	name = "Extra-Vehicular Activity"
	flavor_desc = "Your character�s knowledge and skill of using space-suits and working in vacuum."
	govern_desc = "Governs what kind of space-suits someone can wear, ease of travel in space, and using jetpacks."
	typical_desc = "A low level is typical for many different jobs that may operate in vacuum. \
	A high level is typical of specialists trained to use powered suits, or for those needing to use propulsion systems precisely."
	levels = list(
		/datum/skill_level/eva/zero,
		/datum/skill_level/eva/one,
		/datum/skill_level/eva/two,
		/datum/skill_level/eva/three
		)

/datum/skill_level/eva/zero
	name = "Untrained"
	flavor_desc = "You have basic safety training common to people who work in space: You know how to put on and seal your internals, \
	and you can probably struggle into a soft-suit if you really need to, though you'll be clumsy at it."
	mechanics_desc = "Can wear emergency soft-suits.<br>\
	Can operate internals, and cooling units.<br>\
	Will always fall down when entering an area with gravity from an area lacking it, with or without magboots.<br>\
	Slipping in space is possible if not secured to a surface."

/datum/skill_level/eva/one
	name = "EVA Trained"
	flavor_desc = "You can comfortably use a space suit, and may do so regularly in the course of your work. \
	You�ve also been trained in the usage of various pieces of equipment for EVA."
	mechanics_desc = "Can wear regular voidsuits, or put them onto others who are less skilled.<br>\
	Can toggle magnetic boots.<br>\
	Can toggle jetpacks, and fly in space with one."
	cost = 10

/datum/skill_level/eva/two
	name = "EVA Specialist"
	flavor_desc = "You can use all kinds of space suits, including specialized powered suits., and you�ve become accustomed to using a jetpack to move around."
	mechanics_desc = "Can wear RIG suits.<br>\
	Can toggle stabilization setting on jetpacks to remain in place in space."
	cost = 20

/datum/skill_level/eva/three
	name = "EVA Expert"
	flavor_desc = "You are just as much at home in a vacuum as in atmosphere. Your training and experience helps keep you from being disoriented in space."
	mechanics_desc = "Spacesuit and RIG encumbrance is reduced somewhat.<br>\
	Will no longer slip in space due to being unsecured.<br>\
	Will land gracefully when suddenly entering gravity, instead of falling to the ground."
	enhancing = TRUE
	cost = 40
