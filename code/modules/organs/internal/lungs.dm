#define PROCESS_ACCURACY 10

/obj/item/organ/internal/lungs
	name = "lungs"
	icon_state = "lungs"
	gender = PLURAL
	organ_tag = O_LUNGS
	parent_organ = BP_TORSO

/obj/item/organ/internal/lungs/process()
	..()

	if(!owner)
		return

	if (germ_level > INFECTION_LEVEL_ONE)
		if(prob(5))
			owner.emote("cough")		//respitory tract infection

	if(is_bruised())
		if(prob(4))
			spawn owner.emote("me", 1, "coughs up blood!")
			owner.drip(10)
		if(prob(8))
			spawn owner.emote("me", 1, "gasps for air!")
			owner.losebreath += 15

/obj/item/organ/internal/lungs/proc/rupture()
	var/obj/item/organ/external/parent = owner.get_organ(parent_organ)
	if(istype(parent))
		owner.custom_pain("You feel a stabbing pain in your [parent.name]!", 50)
	bruise()