///Used to make mobs from microbiological samples. Grow grow grow.
/obj/machinery/growing_vat
	name = "growing vat"
	desc = "Tastes just like the chef's soup."
	icon_state = "growing_vat"
	var/buffer = 200

	///List of all microbiological samples in this soup.
	var/datum/biological_sample/biological_sample

	var/obj/item/hose_connector/input/Input

/obj/machinery/growing_vat/Initialize()
	..()

	Input = new (src)

	create_reagents(buffer)

///When we process, we make use of our reagents to try and feed the samples we have.
/obj/machinery/growing_vat/process()
	if(!biological_sample)
		return
	if(biological_sample.handle_growth(src))
		if(!prob(10))
			return
		playsound(loc, 'sound/effects/slosh.ogg', 25, TRUE)
		audible_message(pick(list("<span class='notice'>[src] grumbles!</span>", "<span class='notice'>[src] makes a splashing noise!</span>", "<span class='notice'>[src] sloshes!</span>")))

///Handles the petri dish depositing into the vat.
/obj/machinery/growing_vat/attackby(obj/item/I, mob/living/user)
	if(!istype(I, /obj/item/petri_dish))

		if(I.is_wrench())
			if(biological_sample)
				to_chat(user, "<span class='notice'>You cannot move the vat without damaging the sample!</span>")

			else
				anchored = !anchored

				to_chat(user, "<span class='notice'>You [anchored ? "" : "un"]wrench \the [src].</span>")

		return ..()

	var/obj/item/petri_dish/petri = I

	if(!petri.sample)
		return ..()

	if(biological_sample)
		to_chat(user, "<span class='warning'>There is already a sample in the vat!</span>")
		return
	deposit_sample(user, petri)

///Creates a clone of the supplied sample and puts it in the vat
/obj/machinery/growing_vat/proc/deposit_sample(mob/user, obj/item/petri_dish/petri)
	biological_sample = new
	for(var/datum/micro_organism/m in petri.sample.micro_organisms)
		biological_sample.micro_organisms += new m.type()
	biological_sample.sample_layers = petri.sample.sample_layers
	biological_sample.sample_color = petri.sample.sample_color
	to_chat(user, "<span class='warning'>You put some of the sample in the vat!</span>")
	playsound(src, 'sound/effects/bubbles.ogg', 50, TRUE)
	update_icon()

///Adds text for when there is a sample in the vat
/obj/machinery/growing_vat/examine(mob/user)
	. = ..()
	if(!biological_sample)
		return
	. += "<span class='notice'>It seems to have a sample in it!</span>"
	for(var/i in biological_sample.micro_organisms)
		var/datum/micro_organism/MO = i
		. += MO.get_details(user.research_scanner)

/obj/machinery/growing_vat/plunger_act(obj/item/plunger/P, mob/living/user, reinforced)
	. = ..()
	QDEL_NULL(biological_sample)

///Call update icon when reagents change to update the reagent content icons
/obj/machinery/growing_vat/on_reagent_change(changetype)
	update_icon()
	return ..()

///Adds overlays to show the reagent contents
/obj/machinery/growing_vat/update_icon()
	. = ..()
	cut_overlays()

	if(!reagents.total_volume)
		return

	var/reagentcolor = reagents.get_color()
	var/mutable_appearance/base_overlay = mutable_appearance(icon, "vat_reagent")
	base_overlay.appearance_flags = RESET_COLOR
	base_overlay.color = reagentcolor
	. += base_overlay
	if(biological_sample)
		var/mutable_appearance/bubbles_overlay = mutable_appearance(icon, "vat_bubbles")
		. += bubbles_overlay
