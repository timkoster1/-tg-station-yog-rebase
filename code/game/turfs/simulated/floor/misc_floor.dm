/turf/open/floor/goonplaque
	name = "Commemorative Plaque"
	icon_state = "plaque"
	desc = "\"This is a plaque in honour of our comrades on the G4407 Stations and the TG4407 stations. Hopefully YOG4407 model can live up to your fame and fortune.\" Scratched in beneath that is a crude image of a meteor and a spaceman. The spaceman is laughing. The meteor is exploding. A brief text follows: George Melons is back at it again."
	floor_tile = /obj/item/stack/tile/plasteel

/turf/open/floor/vault
	icon_state = "rockvault"
	floor_tile = /obj/item/stack/tile/plasteel

/turf/open/floor/plating/glass
	icon_state = "glass9"
	desc = "A thick duraglass tile, you can see space from here!"
	floor_tile = /obj/item/stack/tile/plasteel
	layer = ABOVE_OBJ_LAYER

/turf/open/floor/plating/glass/g2
	icon_state = "glass3"
	floor_tile = /obj/item/stack/tile/plasteel

/turf/open/floor/plating/glass/g3
	icon_state = "glass4"
	floor_tile = /obj/item/stack/tile/plasteel

/turf/open/floor/plating/glass/g4
	icon_state = "glass5"
	floor_tile = /obj/item/stack/tile/plasteel

/turf/open/floor/plating/glass/g5
	icon_state = "glass6"
	floor_tile = /obj/item/stack/tile/plasteel

/turf/open/floor/plating/glass/g6
	icon_state = "glass7"
	floor_tile = /obj/item/stack/tile/plasteel

/turf/open/floor/plating/glass/g7
	icon_state = "glass8"
	floor_tile = /obj/item/stack/tile/plasteel

/turf/open/floor/plating/glass/g8
	icon_state = "glass1"
	floor_tile = /obj/item/stack/tile/plasteel


/turf/open/floor/plating/glass/attackby(obj/item/C, mob/user, params) 		//prevents idiots from unscrewing my floors and making everything look like ass
	if(intact && istype(C, /obj/item/weapon/crowbar))
		if(broken || burnt)
			to_chat(user, "<span class='danger'>You can't remove this tile, as it would leak into space!.</span>")

		else

			to_chat(user, "<span class='danger'>You can't remove this tile, as it would leak into space!.</span>")
		return 0
	return 0
	//Cockblocked :^)

/turf/open/floor/bluegrid
	icon = 'icons/turf/floors.dmi'
	icon_state = "bcircuit"
	floor_tile = /obj/item/stack/tile/plasteel

/turf/open/floor/bluegrid/New()
	..()
	nuke_tiles += src

/turf/open/floor/bluegrid/Destroy()
	nuke_tiles -= src
	return ..()

/turf/open/floor/greengrid
	icon = 'icons/turf/floors.dmi'
	icon_state = "gcircuit"
	floor_tile = /obj/item/stack/tile/plasteel

/turf/open/floor/plating/beach
	name = "Beach"
	icon = 'icons/misc/beach.dmi'

/turf/open/floor/plating/beach/ex_act(severity, target)
	contents_explosion(severity, target)

/turf/open/floor/plating/beach/sand
	name = "Sand"
	icon_state = "sand"
	baseturf = /turf/open/floor/plating/beach/sand

/turf/open/floor/plating/beach/coastline_t
	name = "Coastline"
	icon_state = "sandwater_t"
	baseturf = /turf/open/floor/plating/beach/coastline_t

/turf/open/floor/plating/beach/coastline_b
	name = "Coastline"
	icon_state = "sandwater_b"
	baseturf = /turf/open/floor/plating/beach/coastline_b

/turf/open/floor/plating/beach/water
	name = "Water"
	icon_state = "water"
	baseturf = /turf/open/floor/plating/beach/water

/turf/open/floor/plating/ironsand/New()
	..()
	name = "Iron Sand"
	icon_state = "ironsand[rand(1,15)]"

/turf/open/floor/plating/ironsand/burn_tile()
	return

/turf/open/floor/plating/ice
	name = "ice sheet"
	desc = "A sheet of solid ice. Looks slippery."
	icon = 'icons/turf/snow.dmi'
	icon_state = "ice"
	temperature = 180
	baseturf = /turf/open/floor/plating/ice
	slowdown = 1
	wet = TURF_WET_PERMAFROST

/turf/open/floor/plating/ice/colder
	temperature = 140

/turf/open/floor/plating/ice/temperate
	temperature = 255.37

/turf/open/floor/plating/ice/break_tile()
	return

/turf/open/floor/plating/ice/burn_tile()
	return

/turf/open/floor/plating/snowed
	name = "snowed-over plating"
	desc = "A section of plating covered in a light layer of snow."
	icon = 'icons/turf/snow.dmi'
	icon_state = "snowplating"
	temperature = 180

/turf/open/floor/plating/snowed/colder
	temperature = 140

/turf/open/floor/plating/snowed/temperatre
	temperature = 255.37

/turf/open/floor/noslip
	name = "high-traction floor"
	icon_state = "noslip"
	floor_tile = /obj/item/stack/tile/noslip
	broken_states = list("noslip-damaged1","noslip-damaged2","noslip-damaged3")
	burnt_states = list("noslip-scorched1","noslip-scorched2")
	slowdown = -0.3

/turf/open/floor/noslip/MakeSlippery()
	return

/turf/open/floor/oldshuttle
	icon = 'icons/turf/shuttleold.dmi'
	icon_state = "floor"
	floor_tile = /obj/item/stack/tile/plasteel

//Clockwork floor: Slowly heals toxin damage on nearby servants.
/turf/open/floor/clockwork
	name = "clockwork floor"
	desc = "Tightly-pressed brass tiles. They emit minute vibration."
	icon = 'icons/turf/floors.dmi'
	icon_state = "clockwork_floor"

/turf/open/floor/clockwork/New()
	..()
	PoolOrNew(/obj/effect/overlay/temp/ratvar/floor, src)
	PoolOrNew(/obj/effect/overlay/temp/ratvar/beam, src)
	START_PROCESSING(SSobj, src)
	clockwork_construction_value++

/turf/open/floor/clockwork/Destroy()
	STOP_PROCESSING(SSobj, src)
	clockwork_construction_value--
	..()

/turf/open/floor/clockwork/process()
	for(var/mob/living/L in src)
		if(L.stat == DEAD || !is_servant_of_ratvar(L))
			continue
		L.adjustBruteLoss(-1)
		L.adjustFireLoss(-1)

/turf/open/floor/clockwork/ChangeTurf(path, defer_change = FALSE)
	if(path != type)
		STOP_PROCESSING(SSfastprocess, src)
		change_construction_value(-1)
	return ..()

/turf/open/floor/clockwork/Entered(atom/movable/AM)
	..()
	START_PROCESSING(SSobj, src)

/turf/open/floor/clockwork/process()
	if(!healservants())
		STOP_PROCESSING(SSobj, src)

/turf/open/floor/clockwork/proc/healservants()
	for(var/mob/living/L in src)
		if(L.stat == DEAD || !is_servant_of_ratvar(L))
			continue
		var/swapdamage = FALSE
		if(L.has_dna()) //if has_dna() is true they're at least carbon
			var/mob/living/carbon/C = L
			if(TOXINLOVER in C.dna.species.specflags)
				swapdamage = TRUE
		if(isanimal(L))
			var/mob/living/simple_animal/A = L
			if(A.damage_coeff[TOX] < 0)
				swapdamage = TRUE
		if(swapdamage) //they'd take damage, we need to swap it
			L.adjustToxLoss(3)
		else
			L.adjustToxLoss(-3)
		. = 1

/turf/open/floor/clockwork/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/weapon/crowbar))
		user.visible_message("<span class='notice'>[user] begins slowly prying up [src]...</span>", "<span class='notice'>You begin painstakingly prying up [src]...</span>")
		playsound(src, 'sound/items/Crowbar.ogg', 20, 1)
		if(!do_after(user, 70 / I.toolspeed, target = src))
			return 0
		user.visible_message("<span class='notice'>[user] pries up [src]!</span>", "<span class='notice'>You pry up [src], destroying it!</span>")
		playsound(src, 'sound/items/Crowbar.ogg', 80, 1)
		make_plating()
		return 1
	return ..()

/turf/open/floor/clockwork/make_plating()
	new/obj/item/clockwork/alloy_shards/small(src)
	new/obj/item/clockwork/alloy_shards/medium(src)
	return ..()

/turf/open/floor/clockwork/ratvar_act()
	for(var/mob/M in src)
		M.ratvar_act()

/turf/open/floor/clockwork/narsie_act()
	..()
	if(istype(src, /turf/open/floor/clockwork)) //if we haven't changed type
		var/previouscolor = color
		color = "#960000"
		animate(src, color = previouscolor, time = 8)
