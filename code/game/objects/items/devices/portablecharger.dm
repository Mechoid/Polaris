/*
A portable cell charger, that draws from a large cell.
*/

/obj/item/device/portablecharger
	name = "portable charger"
	desc = "A portable charger, capable of charging most types of batteries."
	icon = 'icons/obj/device.dmi'
	icon_state = "charger"
	w_class = ITEMSIZE_NORMAL
	flags = CONDUCT
	var/obj/item/weapon/cell/power_supply
	var/obj/item/weapon/cell/output
	var/power_supply_type = /obj/item/weapon/cell
	var/outputting_cell_type = /obj/item/weapon/cell
	var/emagged = 0
	var/charge_percentage = 5 //A whole number below 100.
	var/accepts_device_cell_supply = 0

/obj/item/device/portablecharger/New()
	processing_objects |= src
	..()

/obj/item/device/portablecharger/Destroy()
	processing_objects -= src
	if(power_supply)
		qdel(power_supply)
		power_supply = null
	if(output)
		qdel(output)
		output = null
	return ..()

/obj/item/device/portablecharger/emp_act(severity)
	for(var/obj/O in contents)
		O.emp_act(severity)
	..()

/obj/item/device/portablecharger/emag_act() //Future proofing.
	if(!emagged)
		emagged = 1

/obj/item/device/portablecharger/update_icon()
	overlays.Cut()
	if(power_supply)
		overlays += image('icons/obj/device.dmi', "charger-primary")
	else if(output)
		icon_state = "[initial(icon_state)]0"
		return
	if(power_supply && output)
		if(output.maxcharge == output.charge)
			icon_state = "[initial(icon_state)]2"
		else if(can_charge())
			icon_state = "[initial(icon_state)]1"
		else
			icon_state = "[initial(icon_state)]0"
	else
		icon_state = "[initial(icon_state)]"
		return

/obj/item/device/portablecharger/process()
	if(!can_charge())
		return
	var/charge_transfer = 0
	charge_transfer = get_output_percentage(charge_percentage)

	var/transferred = 0
	transferred = power_supply.use(charge_transfer)

	if(transferred)
		output.give(transferred)
	update_icon()

/obj/item/device/portablecharger/attack_self(var/mob/user)
	if(output)
		eject_charging_cell(user)
	else if(power_supply)
		eject_power_supply(user)
	update_icon()

/obj/item/device/portablecharger/attackby(obj/item/weapon/W, mob/user)
	if(is_compatible_supply(W) && !power_supply)
		user.drop_item()
		W.loc = src
		power_supply = W
		to_chat(user, "<span class='notice'>You install a cell into \the [src]'s power supply slot.</span>")
		update_icon()
	else if(is_compatible_output(W) && !output)
		if(is_compatible_supply(W))
			to_chat(user, "<span class='notice'>\The [src]'s power supply slot was already filled.</span>")
		user.drop_item()
		W.loc = src
		output = W
		to_chat(user, "<span class='notice'>You install a cell into \the [src]'s charging slot.</span>")
		update_icon()
	else if(is_compatible_output(W) || is_compatible_supply(W))
		to_chat(user, "<span class='notice'>You could not seem to find an open slot on \the [src] to insert \the [W].")
		update_icon()

/*
Procs/Verbs unique to this device.
*/

/obj/item/device/portablecharger/proc/get_output_percentage(var/input) //Input is a whole number below 100. Returns the output cell's to-charge value if an output cell is present.
	if(output)
		return (output.maxcharge * (input/100))

/obj/item/device/portablecharger/proc/can_charge()
	if(power_supply && output)
		if(power_supply.charge >= (get_output_percentage(charge_percentage)) && output.maxcharge != output.charge)
			return 1
	return 0

/obj/item/device/portablecharger/proc/is_compatible_supply(var/obj/item/weapon/W)
	if(istype(W, power_supply_type))
		if(!accepts_device_cell_supply && istype(W, /obj/item/weapon/cell/device))
			return 0
		else
			return 1
	else
		return 0

/obj/item/device/portablecharger/proc/is_compatible_output(var/obj/item/weapon/W)
	if(istype(W, outputting_cell_type))
		return 1
	else
		return 0

/obj/item/device/portablecharger/verb/eject_power_supply(var/mob/user)
	if(power_supply)
		if(ishuman(user))
			user.put_in_hands(power_supply)
		else
			power_supply.loc = get_turf(loc)

		power_supply.add_fingerprint(user)
		power_supply.update_icon()

		to_chat(user, "You remove \the [src.power_supply].")
		src.power_supply = null
		update_icon()
		return
	else
		to_chat(user, "\The [src] has no power supply.")

/obj/item/device/portablecharger/verb/eject_charging_cell(var/mob/user)
	if(output)
		if(ishuman(user))
			user.put_in_hands(output)
		else
			output.loc = get_turf(loc)

		output.add_fingerprint(user)
		output.update_icon()

		to_chat(user, "You remove \the [src.output].")
		src.output = null
		update_icon()
		return
	else
		to_chat(user, "\The [src] has no charging cell.")
		return
