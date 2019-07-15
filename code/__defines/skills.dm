// These defines are for tweaking the 'balance' of the skill system.

#define SKILL_POINT_FLOOR			20		// Default minimum amount of skill points, generally when at the min age.
#define SKILL_POINT_CEILING			150		// Default maximum amount of skill points, generally when at the max age.
#define SKILL_POINT_ANTAG_BONUS		50		// Flat bonus points given to antagonists. This is applied after the age-based curve and can exceed SKILL_POINT_CEILING.

#define SKILL_DISCOUNT_FACTOR		0.5
#define SKILL_DISCOUNT_MAX_POINTS	100

// Defines for each skill level, so you don't need to remember how BYOND counts.
// Skills generally are capped at SKILL_LEVEL_FOUR, however some are capped at SKILL_LEVEL_THREE.
#define SKILL_LEVEL_ZERO		1 // Default level for everyone.
#define SKILL_LEVEL_ONE			2 // Basic stuff.
#define SKILL_LEVEL_TWO			3 // Less basic.
#define SKILL_LEVEL_THREE		4 // Competency in a skill, can do everything they could've done before the skill system.
#define SKILL_LEVEL_FOUR		5 // Gets bonuses to whatever the skill is involved in.


// These defines are used in a few places.
// Firstly, they act as the index for a special list in the global skill collection object.
// Secondly, they are used as input for skill check procs.
// Thirdly, they are also used for savefile purposes (so try to avoid changing it if possible).


/*
 * Technology Skills.
 */

// Advanced, possibly self-aware machines, primarily data-based.
#define SKILL_INFOTECH		"Information Tech"

// Technology used heavily in conjunction or integrated with organics.
#define SKILL_BIOTECH		"Biomechanics"

// Technology primarily focused on constructing and modifying heavy machinery, or robotics.
#define SKILL_MECHTECH		"Mechatronics"

// Technology primarily focused on materials, their strengths, and applications.
#define SKILL_MATTECH		"Material Engineering"

// Technology used in xenoarchaeology.
#define SKILL_XENOTECH		"Ancient Tech"

/*
 * General Skills.
 */

// EVA, use of space suits and ability to maneuver in low-grav. [DONE]
#define SKILL_EVA			"EVA"

// Piloting or operating an Exosuit or other heavy machinery. [DONE]
#define SKILL_EXOSUITS		"Exosuits"

// Piloting multi-person space-craft.
#define SKILL_PILOT			"Spacecraft"

/*
 * Crafting Skills
 */

// Ability to construct or repair different structures.
#define SKILL_CONSTRUCTION	"Construction"

// Ability to manually craft with materials.
#define SKILL_CRAFTING		"Crafting"

/*
 * Medical skills.
 */

// Flesh-diagnostics.
#define SKILL_DIAGNOSTICS	"Diagnostics"

// Chemicals. Mental math, syringe identification, etc.
#define SKILL_CHEMISTRY		"Chemistry"

// Ability to perform surgery on meat.
#define SKILL_SURGERY		"Surgery"

// "First Aid" Ability to keep someone stable, splints, bandages, etc.
#define SKILL_RESPONSE		"Response Aid"

// Handling of corpses, autopsies, cloning.
#define SKILL_POSTMORT		"Postmortem Operations"

// General medical practice, syringe usage on living persons, uses for stethoscopes, etc.
#define SKILL_MEDPRACTICE	"Medical Practice"

/*
 * Combat Skills.
 */

// Guns and ability to use them. [DONE]
#define SKILL_GUNS			"Gun Combat"
#define SKILL_EGUNS			"Energy Guns"
#define SKILL_BGUNS			"Ballistic Guns"

// Melee combat, armed specifically. [DONE]
#define SKILL_MELEE			"Melee Combat"

// Unarmed combat, without weapons. [DONE]
#define SKILL_UNARMED		"Unarmed Combat"
