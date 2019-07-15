/*
 * The home of basic deflect / defense code.
 */

/obj/item
	var/defend_chance = 5	// The base chance for the weapon to parry.
	var/projectile_parry_chance = 0	// The base chance for a projectile to be deflected.

// Returns the item's defend chance.
/obj/item/proc/get_melee_defend_chance(var/mob/user)
	return defend_chance

// Returns the item's deflect chance.
/obj/item/proc/get_projectile_defend_chance(var/mob/user)
	return projectile_parry_chance

/obj/item/weapon/melee/handle_shield(mob/user, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	if(.)
		return .

	var/defensemod = 0.7
	if(isliving(user))
		var/mob/living/L = user
		if(L.skill_check(SKILL_MELEE, SKILL_LEVEL_TWO))
			defensemod = 1
		else if(L.skill_check(SKILL_MELEE, SKILL_LEVEL_ONE))
			defensemod = 0.85

	if(default_parry_check(user, attacker, damage_source) && prob(min(100, get_melee_defend_chance(user) * defensemod)))
		user.visible_message("<span class='danger'>\The [user] parries [attack_text] with \the [src]!</span>")
		return 1
	if(unique_parry_check(user, attacker, damage_source) && prob(min(100, get_projectile_defend_chance(user) * defensemod)))
		user.visible_message("<span class='danger'>\The [user] deflects [attack_text] with \the [src]!</span>")
		return 1

	return 0

/obj/item/weapon/melee/unique_parry_check(mob/user, mob/attacker, atom/damage_source)
	if(.)
		return .
	if(user.incapacitated() || !istype(damage_source, /obj/item/projectile))
		return 0

	var/bad_arc = reverse_direction(user.dir)
	if(!check_shield_arc(user, bad_arc, damage_source, attacker))
		return 0

	return 1

/obj/item/weapon/melee/get_melee_defend_chance(var/mob/user)
	. = ..()
	if(isliving(user))
		var/mob/living/L = user
		if(L.skill_check(SKILL_LEVEL_THREE))
			if(. < 10)
				. = 10
			else
				. = ..() * 1.1
			. = min(100, .)
	return .

/obj/item/weapon/melee/get_projectile_defend_chance(var/mob/user)
	. = ..()
	if(isliving(user))
		var/mob/living/L = user
		if(L.skill_check(SKILL_LEVEL_THREE))
			if(. < 5)
				. = 5
			else
				. = ..() * 1.1
			. = min(100, .)
	return .
