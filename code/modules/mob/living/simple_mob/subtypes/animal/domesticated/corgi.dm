//Corgi
/mob/living/simple_mob/dog
	name = "dog"
	real_name = "dog"
	desc = "It's a dog."
	tt_desc = "E Canis lupus familiaris"
	icon_state = "corgi"
	icon_living = "corgi"
	icon_dead = "corgi_dead"

	response_help  = "pets"
	response_disarm = "bops"
	response_harm   = "kicks"

	see_in_dark = 5
	mob_size = 8

	has_langs = list("Dog")

	meat_amount = 3
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/corgi

	ai_holder_type = /datum/ai_holder/simple_mob/passive

	var/obj/item/inventory_head

/mob/living/simple_mob/dog/corgi
	name = "corgi"
	real_name = "corgi"
	desc = "It's a corgi."
	tt_desc = "E Canis lupus familiaris"
	icon_state = "corgi"
	icon_living = "corgi"
	icon_dead = "corgi_dead"

//IAN! SQUEEEEEEEEE~
/mob/living/simple_mob/dog/corgi/Ian
	name = "Ian"
	real_name = "Ian"	//Intended to hold the name without altering it.
	gender = MALE
	desc = "It's a corgi."
	var/turns_since_scan = 0
	var/obj/movement_target
	response_help  = "pets"
	response_disarm = "bops"
	response_harm   = "kicks"

/mob/living/simple_mob/dog/corgi/puppy
	name = "corgi puppy"
	real_name = "corgi"
	desc = "It's a corgi puppy."
	icon_state = "puppy"
	icon_living = "puppy"
	icon_dead = "puppy_dead"

/mob/living/simple_mob/dog/attackby(var/obj/item/O as obj, var/mob/user as mob)  //Marker -Agouri
	if(istype(O, /obj/item/weapon/newspaper))
		if(!stat)
			visible_message("<span class='notice'>[user] baps [src] on the nose with the rolled up [O].</span>")
			spawn(0)
				for(var/i in list(1,2,4,8,4,2,1,2))
					set_dir(i)
					sleep(1)
	else
		..()

/mob/living/simple_mob/dog/regenerate_icons()
	overlays = list()

	if(inventory_head)
		var/head_icon_state = inventory_head.icon_state
		if(health <= 0)
			head_icon_state += "2"

		var/icon/head_icon = image('icons/mob/corgi_head.dmi',head_icon_state)
		if(head_icon)
			overlays += head_icon
/*
	if(inventory_back)
		var/back_icon_state = inventory_back.icon_state
		if(health <= 0)
			back_icon_state += "2"

		var/icon/back_icon = image('icons/mob/corgi_back.dmi',back_icon_state)
		if(back_icon)
			overlays += back_icon
*/
	return
