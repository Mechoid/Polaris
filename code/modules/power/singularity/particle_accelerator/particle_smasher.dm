/*
 * Contains the particle smasher and its recipes.
 */

/obj/machinery/particle_smasher
	name = "Particle Focus"
	desc = "A strange device used to create exotic matter."
	icon = 'icons/obj/machines/particle_smasher.dmi'
	icon_state = "smasher"
	anchored = 0
	density = 1
	use_power = 0

	var/successful_craft = FALSE	// Are we waiting to be emptied?
	var/image/material_layer	// Holds the image used for the filled overlay.
	var/image/material_glow		// Holds the image used for the glow overlay.
	var/image/reagent_layer		// Holds the image used for showing a contained beaker.
	var/energy = 0				// How many 'energy' units does this have? Acquired by a Particle Accelerator like a Singularity.
	var/max_energy = 600
	var/obj/item/stack/material/target	// The material being bombarded.
	var/obj/item/weapon/reagent_containers/reagent_container		// Holds the beaker. The process will consume ALL reagents inside it.
	var/beaker_type = /obj/item/weapon/reagent_containers/glass/beaker
	var/list/storage		// Holds references to items allowed to be used in the fabrication phase.
	var/max_storage = 3	// How many items can be jammed into it?
	var/list/recipes	// The list containing the Particle Smasher's recipes.

/obj/machinery/particle_smasher/Initialize()
	..()
	storage = list()
	update_icon()
	spawn(3)
		recipes = typesof(/datum/recipe/particle_smasher)

/obj/machinery/particle_smasher/examine(mob/user)
	..()
	if(user in view(1))
		to_chat(user, "<span class='notice'>\The [src] contains:</span>")
		for(var/obj/item/I in contents)
			to_chat(user, "<span class='notice'>\the [I]</span>")

/obj/machinery/particle_smasher/attackby(obj/item/W as obj, mob/user as mob)
	if(W.type == /obj/item/device/analyzer)
		to_chat(user, "<span class='notice'>\The [src] reads an energy level of [energy].</span>")
	else if(istype(W, /obj/item/stack/material))
		var/obj/item/stack/material/M = W
		if(M.uses_charge)
			to_chat(user, "<span class='notice'>You cannot fill \the [src] with a synthesizer!</span>")
			return
		target = M.split(1)
		target.forceMove(src)
		update_icon()
	else if(istype(W, beaker_type))
		if(reagent_container)
			to_chat(user, "<span class='notice'>\The [src] already has a container attached.</span>")
			return
		if(isrobot(user) && istype(W.loc, /obj/item/weapon/gripper))
			var/obj/item/weapon/gripper/G = W.loc
			G.drop_item()
		else
			user.drop_from_inventory(W)
		reagent_container = W
		reagent_container.forceMove(src)
		to_chat(user, "<span class='notice'>You add \the [reagent_container] to \the [src].</span>")
		update_icon()
		return
	else if(W.is_wrench())
		anchored = !anchored
		playsound(src, W.usesound, 75, 1)
		if(anchored)
			user.visible_message("[user.name] secures [src.name] to the floor.", \
				"You secure the [src.name] to the floor.", \
				"You hear a ratchet.")
		else
			user.visible_message("[user.name] unsecures [src.name] from the floor.", \
				"You unsecure the [src.name] from the floor.", \
				"You hear a ratchet.")
		update_icon()
		return
	else if(istype(W, /obj/item/weapon/card/id))
		to_chat(user, "<span class='notice'>Swiping \the [W] on \the [src] doesn't seem to do anything...</span>")
		return ..()
	else if(((isrobot(user) && istype(W.loc, /obj/item/weapon/gripper)) || (!isrobot(user) && W.canremove)) && storage.len < max_storage)
		if(isrobot(user) && istype(W.loc, /obj/item/weapon/gripper))
			var/obj/item/weapon/gripper/G = W.loc
			G.drop_item()
		else
			user.drop_from_inventory(W)
		W.forceMove(src)
		storage += W
	else
		return ..()

/obj/machinery/particle_smasher/update_icon()
	cut_overlays()
	if(!material_layer)
		material_layer = image(icon, "[initial(icon_state)]-material")
	if(!material_glow)
		material_glow = image(icon, "[initial(icon_state)]-material-glow")
		material_glow.plane = PLANE_LIGHTING_ABOVE
	if(!reagent_layer)
		reagent_layer = image(icon, "[initial(icon_state)]-reagent")
	if(anchored)
		icon_state = "[initial(icon_state)]-o"
		if(target)
			material_layer.color = target.material.icon_colour
			add_overlay(material_layer)
			if(successful_craft)
				material_glow.color = target.material.icon_colour
				add_overlay(material_glow)
		if(reagent_container)
			add_overlay(reagent_layer)
	else
		icon_state = initial(icon_state)

	if(target && energy)
		var/power_percent = round((energy / max_energy) * 100)
		light_color = target.material.icon_colour
		switch(power_percent)
			if(0 to 25)
				light_range = 1
			if(26 to 50)
				light_range = 2
			if(51 to 75)
				light_range = 3
			if(76 to INFINITY)
				light_range = 4
		set_light(light_range, 2, light_color)
	else
		set_light(0, 0, "#FFFFFF")

/obj/machinery/particle_smasher/bullet_act(var/obj/item/projectile/Proj)
	if(istype(Proj, /obj/item/projectile/beam))
		if(Proj.damage >= 50)
			TryCraft()
	return 0

/obj/machinery/particle_smasher/process()
	if(!src.anchored)	// Rapidly loses focus.
		if(energy)
			radiation_repository.radiate(src, round(((src.energy-150)/50)*5,1))
			energy = max(0, energy - 30)
			update_icon()
		return

	if(energy)
		radiation_repository.radiate(src, round(((src.energy-150)/50)*5,1))
		energy = CLAMP(energy - 5, 0, max_energy)

	return

/obj/machinery/particle_smasher/proc/TryCraft()
	world << "Smasher is trying to craft."

	if(!recipes || !recipes.len)
		world << "Recipe Assignment Failure"
		recipes = typesof(/datum/recipe/particle_smasher)

	if(!target)	// You are just blasting an empty machine.
		world << "Smasher is empty."
		visible_message("<span class='notice'>\The [src] shudders.</span>")
		update_icon()
		return

	if(successful_craft)
		world << "Already Crafted."
		visible_message("<span class='warning'>\The [src] fizzles.</span>")
		if(prob(33))	// Why are you blasting it after it's already done!
			radiation_repository.radiate(src, 10 + round(src.energy / 60, 1))
			energy = max(0, energy - 30)
		update_icon()
		return

	var/list/possible_recipes = list()
	var/max_prob = 0
	for(var/D in recipes)	// Only things for the smasher. Don't get things like the chef's cake recipes.
		world << "Loop Check"
		var/datum/recipe/particle_smasher/R
		if(istype(D, /datum/recipe/particle_smasher))
			R = D

		if(!istype(R))
			world << "Recipes contains non-recipe-datum variable."
			continue

		if(R.probability)	// It's actually a recipe you're supposed to be able to make.
			world << "Prob check"
			if(istype(target, R.required_material))
				world << "Req Material Check"
				if(energy >= R.required_energy_min && energy <= R.required_energy_max)	// The machine has enough Vaguely Defined 'Energy'.
					world << "Req Energy Check [energy]"
					var/turf/T = get_turf(src)
					var/datum/gas_mixture/environment = T.return_air()
					world << environment
					if(environment.temperature >= R.required_atmos_temp_min && environment.temperature <= R.required_atmos_temp_max)	// Too hot, or too cold.
						world << "Temp Check [environment.temperature]"
						if(R.reagents && R.reagents.len)
							world << "Has Reagent Check"
							if(!reagent_container || R.check_reagents(reagent_container.reagents) == -1)	// It doesn't have a reagent storage when it needs it, or it's lacking what is needed.
								world << "Reagent Fail"
								continue
						if(R.items && R.items.len)
							world << "Has Items Check"
							if(!(storage && storage.len) || R.check_items(src) == -1)	// It's empty, or it doesn't contain what is needed.
								world << "Item Fail"
								continue
						world << "Add [R] to possible recipes."
						possible_recipes += R
						max_prob += R.probability
						world << "Max Probability = [max_prob]"

	if(possible_recipes.len)
		world << "Possible Recipes List: [possible_recipes.len]"
		var/local_prob = rand(0, max_prob - 1)%max_prob
		world << "Local Probability = [local_prob]"
		var/cumulative = 0
		for(var/datum/recipe/particle_smasher/R in possible_recipes)
			cumulative += R.probability
			world << "Cumulative: [cumulative]"
			if(local_prob < cumulative)
				world << "Trying to Craft"
				successful_craft = TRUE
				DoCraft(R)
				break
	update_icon()

/obj/machinery/particle_smasher/proc/DoCraft(var/datum/recipe/particle_smasher/recipe)
	world << "DoCraft called."
	if(!successful_craft || !recipe)
		return

	qdel(target)
	target = null

	world << "Confirm Deletion: [target]"

	if(reagent_container)
		world << "Reagent Container Purge."
		reagent_container.reagents.clear_reagents()

	if(recipe.items && recipe.items.len)
		world << "Recipe has items."
		for(var/obj/item/I in storage)
			for(var/item_type in recipe.items)
				if(istype(I, item_type))
					world << "[I] Matches Recipe Item"
					storage -= I
					qdel(I)
					break

	var/result = recipe.result
	var/obj/item/stack/material/M = new result(src)
	target = M
	world << "Returning New Sheet: [target]"
	update_icon()

/obj/machinery/particle_smasher/verb/eject_contents()
	set src in view(1)
	set category = "Object"
	set name = "Eject Particle Focus Contents"

	if(usr.incapacitated())
		return

	DumpContents()

/obj/machinery/particle_smasher/proc/DumpContents()
	target = null
	reagent_container = null
	var/turf/T = get_turf(src)
	for(var/obj/item/I in contents)
		if(I in storage)
			storage -= I
		I.forceMove(T)
	update_icon()

/*
 * The special recipe datums used for the particle smasher.
 */

/datum/recipe/particle_smasher
	//reagents	//Commented out due to inheritance. Still a list, used as ex:	// example: = list("pacid" = 5)
	//items		//Commented out due to inheritance. Still a list, used as ex:	// example: = list(/obj/item/weapon/tool/crowbar, /obj/item/weapon/welder) Place /foo/bar before /foo. Do not include fruit. Maximum of 3 items.

	result = /obj/item/stack/material/iron		// The sheet this will produce.
	var/required_material = /obj/item/stack/material/iron	// The required material sheet.
	var/required_energy_min = 0			// The minimum energy this recipe can process at.
	var/required_energy_max = 600		// The maximum energy this recipe can process at.
	var/required_atmos_temp_min = 0		// The minimum ambient atmospheric temperature required, in kelvin.
	var/required_atmos_temp_max = 600	// The maximum ambient atmospheric temperature required, in kelvin.
	var/probability = 0					// The probability for the recipe to be produced. 0 will make it impossible.

/datum/recipe/particle_smasher/check_items(var/obj/container as obj)
	. = 1
	if (items && items.len)
		var/list/checklist = list()
		checklist = items.Copy() // You should really trust Copy
		if(istype(container, /obj/machinery/particle_smasher))
			var/obj/machinery/particle_smasher/machine = container
			for(var/obj/O in machine.storage)
				if(istype(O,/obj/item/weapon/reagent_containers/food/snacks/grown))
					continue // Fruit is handled in check_fruit().
				var/found = 0
				for(var/i = 1; i < checklist.len+1; i++)
					var/item_type = checklist[i]
					if (istype(O,item_type))
						checklist.Cut(i, i+1)
						found = 1
						break
				if (!found)
					. = 0
		if (checklist.len)
			. = -1
	return .

/datum/recipe/particle_smasher/deuterium_tritium
	reagents = list("hydrogen" = 15)

	result = /obj/item/stack/material/tritium
	required_material = /obj/item/stack/material/deuterium

	required_energy_min = 200
	required_energy_max = 400

	required_atmos_temp_max = 200
	probability = 30

/datum/recipe/particle_smasher/verdantium_morphium
	result = /obj/item/stack/material/morphium
	required_material = /obj/item/stack/material/verdantium

	required_energy_min = 400
	required_energy_max = 500
	probability = 20

/datum/recipe/particle_smasher/plasteel_morphium
	items = list(/obj/item/prop/alien/junk)

	result = /obj/item/stack/material/morphium
	required_material = /obj/item/stack/material/plasteel

	required_energy_min = 100
	required_energy_max = 300
	probability = 10

/datum/recipe/particle_smasher/osmium_lead
	reagents = list("tungsten" = 10)

	result = /obj/item/stack/material/lead
	required_material = /obj/item/stack/material/osmium

	required_energy_min = 200
	required_energy_max = 400

	required_atmos_temp_min = 800
	required_atmos_temp_max = 900
	probability = 50

/datum/recipe/particle_smasher/phoron_valhollide
	reagents = list("phoron" = 10, "pacid" = 10)

	result = /obj/item/stack/material/valhollide
	required_material = /obj/item/stack/material/phoron

	required_energy_min = 300
	required_energy_max = 500

	required_atmos_temp_min = 1
	required_atmos_temp_max = 100
	probability = 10
