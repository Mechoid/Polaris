/datum/component
	var/enabled = TRUE
	var/dupe_mode = COMPONENT_DUPE_HIGHLANDER
	var/dupe_type
	var/list/signal_procs
	var/datum/parent

/datum/component/New(datum/P, ...)
	if(type == /datum/component)
		qdel(src)
		CRASH("[type] instantiated!")

	//check for common mishaps
	if(!isnum(dupe_mode))
		qdel(src)
		CRASH("[type]: Invalid dupe_mode!")
	var/dt = dupe_type
	if(dt && !ispath(dt))
		qdel(src)
		CRASH("[type]: Invalid dupe_type!")

	parent = P
	var/list/arguments = args.Copy(2)
	if(Do_Setup(arglist(arguments)) == COMPONENT_INCOMPATIBLE)
		parent = null
		qdel(src)
		return

	
	_CheckDupesAndJoinParent(P)
/datum/component/proc/_CheckDupesAndJoinParent()
	var/datum/P = parent
	var/dm = dupe_mode
	var/datum/component/old
	if(dm != COMPONENT_DUPE_ALLOWED)
		var/dt = dupe_type
		if(!dt)
			old = P.GetExactComponent(type)
		else
			old = P.GetComponent(dt)
		if(old)
			//One or the other has to die
			switch(dm)
				if(COMPONENT_DUPE_UNIQUE)
					old.InheritComponent(src, TRUE)
					qdel(src, TRUE, TRUE)
					return
				if(COMPONENT_DUPE_HIGHLANDER)
					InheritComponent(old, FALSE)
					qdel(old, FALSE, TRUE)
	//provided we didn't eat someone
	if(!old)
		//let the others know
		P.SendSignal(COMSIG_COMPONENT_ADDED, src)
	
	//lazy init the parent's dc list
	var/list/dc = P.datum_components
	if(!dc)
		P.datum_components = dc = list()
	
	//set up the typecache
	var/our_type = type
	for(var/I in _GetInverseTypeList(our_type))
		var/test = dc[I]
		if(test)	//already another component of this type here
			var/list/components_of_type
			if(!length(test))
				components_of_type = list(test)
				dc[I] = components_of_type
			else
				components_of_type = test
			if(I == our_type)	//exact match, take priority
				var/inserted = FALSE
				for(var/J in 1 to components_of_type.len)
					var/datum/component/C = components_of_type[J]
					if(C.type != our_type) //but not over other exact matches
						components_of_type.Insert(J, I)
						inserted = TRUE
						break
				if(!inserted)
					components_of_type += src
			else	//indirect match, back of the line with ya
				components_of_type += src
		else	//only component of this type, no list
			dc[I] = src

/datum/component/proc/Do_Setup(...)
	return

/datum/component/Destroy()
	enabled = FALSE
	var/datum/P = parent
	if(P)
		_RemoveNoSignal()
		P.SendSignal(COMSIG_COMPONENT_REMOVING, src)
	LAZYCLEARLIST(signal_procs)
	return ..()

/datum/component/proc/_RemoveNoSignal()
	var/datum/P = parent
	if(P)
		var/list/dc = P.datum_components
		var/our_type = type
		for(var/I in _GetInverseTypeListExceptRoot(our_type))
			var/list/components_of_type = dc[I]
			if(length(components_of_type))	//
				var/list/subtracted = components_of_type - src
				if(subtracted.len == 1)	//only 1 guy left
					dc[I] = subtracted[1]	//make him special
				else
					dc[I] = subtracted
			else	//just us
				dc -= I
		if(!dc.len)
			P.datum_components = null
		parent = null

/datum/component/proc/RegisterSignal(sig_type, proc_on_self, override = FALSE)
	if(QDELETED(src))
		return
	var/list/procs = signal_procs
	if(!procs)
		procs = list()
		signal_procs = procs

	if(!override)
		. = procs[sig_type]
		if(.)
			stack_trace("[sig_type] overridden. Use override = TRUE to suppress this warning")

	procs[sig_type] = CALLBACK(src, proc_on_self)

/datum/component/proc/InheritComponent(datum/component/C, i_am_original)
	return

/datum/component/proc/OnTransfer(datum/new_parent)
	return

/datum/component/proc/_GetInverseTypeListExceptRoot(our_type_cached)
	var/datum/component/current_type = our_type_cached
	. = list()
	while (current_type != /datum/component)
		. += current_type
		current_type = type2parent(current_type)

/datum/var/list/datum_components //special typecache of /datum/component

/datum/proc/SendSignal(sigtype, ...)
	var/list/comps = datum_components

	if(!comps)
		return NONE
	var/list/arguments = args.Copy(2)
	var/target = comps[/datum/component]
	if(!length(target))
		var/datum/component/C = target
		if(!C.enabled)
			return NONE
		var/list/sps = C.signal_procs
		var/datum/callback/CB = LAZYACCESS(sps, sigtype)
		if(!CB)
			return NONE
		return CB.InvokeAsync(arglist(arguments))
	. = NONE
	for(var/I in target)
		var/datum/component/C = I
		if(!C.enabled)
			continue
		var/datum/callback/CB = C.signal_procs[sigtype]
		if(!CB)
			continue
		. |= CB.InvokeAsync(arglist(arguments))

/datum/proc/GetComponent(c_type)
	var/list/dc = datum_components
	if(!dc)
		return null
	. = dc[c_type]
	if(length(.))
		return .[1]

/datum/proc/GetExactComponent(c_type)
	var/list/dc = datum_components
	if(!dc)
		return null
	var/datum/component/C = dc[c_type]
	if(C)
		if(length(C))
			C = C[1]
		if(C.type == c_type)
			return C

/datum/proc/GetComponents(c_type)
	var/list/dc = datum_components
	if(!dc)
		return null
	. = dc[c_type]
	if(!length(.))
		return list(.)

/datum/proc/AddComponent(new_type, ...)
	var/nt = new_type
	args[1] = src
	var/datum/component/C = new nt(arglist(args))
	return QDELING(C) ? GetComponent(new_type) : C

/datum/proc/LoadComponent(component_type, ...)
	. = GetComponent(component_type)
	if(!.)
		return AddComponent(arglist(args))


/datum/proc/TakeComponent(datum/component/C)
	if(!C)
		return
	var/datum/helicopter = C.parent
	if(helicopter == src)
    	//wat
		return
	C._RemoveNoSignal()
	helicopter.SendSignal(COMSIG_COMPONENT_REMOVING, C)
	C.OnTransfer(src)
	C.parent = src
	SendSignal(COMSIG_COMPONENT_ADDED, C) 

/datum/proc/TransferComponents(datum/target)
	var/list/dc = datum_components
	if(!dc)
		return
	var/comps = dc[/datum/component]
	if(islist(comps))
		for(var/I in comps)
			target.TakeComponent(I)
	else
		target.TakeComponent(comps)
