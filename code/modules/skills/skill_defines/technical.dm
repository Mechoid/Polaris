/*******************
* TECHNICAL SKILLS *
*******************/

/datum/category_group/skill/technical
	name = "Technical"
	category_item_type = /datum/category_item/skill/technical

/datum/category_item/skill/technical/infotech
	id = SKILL_INFOTECH
	name = "Information Technology"
	flavor_desc = "How well your character is able to understand advanced information technology."
	govern_desc = "Governs the ability to interact with machines, typically of the more advanced variety."
	typical_desc = "A low level is typical of individuals with engineering backgrounds, such as engineers, \
	or mechatronic engineers. A high level is typical of individuals working with cutting edge technology, or \
	artificial intelligences, such as roboticists or chief engineers."
	levels = list(
		/datum/skill_level/infotech/zero,
		/datum/skill_level/infotech/one,
		/datum/skill_level/infotech/two,
		/datum/skill_level/infotech/three
		)

/datum/skill_level/infotech/zero
	name = "Untrained"
	flavor_desc = "You are unfamiliar with more advanced aspects of modern electronics, let alone the workings of anything more sophisticated than a smartfridge."
	mechanics_desc = "You are unable to utilize many machines pertaining to A.I.<br>\
	You cannot modify AI or Cyborg laws."

/datum/skill_level/infotech/one
	name = "Technician"
	flavor_desc = "You have been trained in the use of modern data storage and processing systems, but still struggle with the true complexities of A.I."
	mechanics_desc = "Can use Reset AI boards.<br>\
	Can download techlevels onto disks.<br>\
	Can download genetic sequences onto disks.<br>\
	Can install Cyborg radio keys, or reset modules.<br>\
	Can construct integrated circuits, and use the printer."
	cost = 10

/datum/skill_level/infotech/two
	name = "Chief Technician"
	flavor_desc = "You’ve worked with computers extensively, and you know how to safely utilize or modify common drone systems."
	mechanics_desc = "Can delete specific data from the R&D servers.<br>\
	Can modify AI and Cyborg lawsets.<br>\
	"
	cost = 20

/datum/skill_level/infotech/three
	name = "A.I. Developer"
	flavor_desc = "Your knowledge of complex computers and data storage is"
	mechanics_desc = "Some exosuit tools will have unique abilities enabled when you are operating them."
	enhancing = TRUE
	cost = 40
