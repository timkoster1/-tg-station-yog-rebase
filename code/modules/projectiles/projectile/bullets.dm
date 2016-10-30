/obj/item/projectile/bullet
	name = "bullet"
	icon_state = "bullet"
	damage = 60
	damage_type = BRUTE
	nodamage = 0
	flag = "bullet"
	hitsound_wall = "ricochet"

/obj/item/projectile/bullet/weakbullet //beanbag, heavy stamina damage
	damage = 5
	stamina = 80

/obj/item/projectile/bullet/weakbullet2 //detective revolver instastuns, but multiple shots are better for keeping punks down
	damage = 10
	weaken = 3
	stamina = 50

/obj/item/projectile/bullet/weakbullet3
	damage = 20

/obj/item/projectile/bullet/weakbullet4
	damage = 17

/obj/item/projectile/bullet/toxinbullet
	damage = 15
	damage_type = TOX

/obj/item/projectile/bullet/incendiary/firebullet
	damage = 10

/obj/item/projectile/bullet/armourpiercing
	damage = 17
	armour_penetration = 10

/obj/item/projectile/bullet/pellet
	name = "pellet"
	damage = 15

/obj/item/projectile/bullet/pellet/weak/New()
	damage = 6
	range = rand(8)

/obj/item/projectile/bullet/pellet/weak/on_range()
 	var/datum/effect_system/spark_spread/sparks = new /datum/effect_system/spark_spread
 	sparks.set_up(1, 1, src)
 	sparks.start()
 	..()

/obj/item/projectile/bullet/pellet/overload/New()
	damage = 3
	range = rand(10)

/obj/item/projectile/bullet/pellet/overload/on_hit(atom/target, blocked = 0)
 	..()
 	explosion(target, 0, 0, 2)

/obj/item/projectile/bullet/pellet/overload/on_range()
 	explosion(src, 0, 0, 2)
 	var/datum/effect_system/spark_spread/sparks = new /datum/effect_system/spark_spread
 	sparks.set_up(3, 3, src)
 	sparks.start()
 	..()

/obj/item/projectile/bullet/midbullet
	damage = 20
	stamina = 65 //two round bursts from the c20r knocks people down


/obj/item/projectile/bullet/midbullet2
	damage = 25

/obj/item/projectile/bullet/midbullet3
	damage = 30

/obj/item/projectile/bullet/heavybullet
	damage = 35

/obj/item/projectile/bullet/rpellet
	damage = 3
	stamina = 25

/obj/item/projectile/bullet/stunshot //taser slugs for shotguns, nothing special
	name = "stunshot"
	damage = 5
	stun = 5
	weaken = 5
	stutter = 5
	jitter = 20
	range = 7
	icon_state = "spark"
	color = "#FFFF00"

/obj/item/projectile/bullet/incendiary/on_hit(atom/target, blocked = 0)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(4)
		M.IgniteMob()


/obj/item/projectile/bullet/incendiary/shell
	name = "incendiary slug"
	damage = 20

/obj/item/projectile/bullet/incendiary/shell/Move()
	..()
	var/turf/location = get_turf(src)
	if(location)
		PoolOrNew(/obj/effect/hotspot, location)
		location.hotspot_expose(700, 50, 1)

/obj/item/projectile/bullet/incendiary/shell/dragonsbreath
	name = "dragonsbreath round"
	damage = 5


/obj/item/projectile/bullet/meteorshot
	name = "meteor"
	icon = 'icons/obj/meteor.dmi'
	icon_state = "dust"
	damage = 30
	weaken = 8
	stun = 8
	hitsound = 'sound/effects/meteorimpact.ogg'

/obj/item/projectile/bullet/meteorshot/weak
	damage = 10
	weaken = 4
	stun = 4

/obj/item/projectile/bullet/honker
	damage = 0
	weaken = 5
	stun = 5
	forcedodge = 1
	nodamage = 1
	hitsound = 'sound/items/bikehorn.ogg'
	icon = 'icons/obj/hydroponics/harvest.dmi'
	icon_state = "banana"
	range = 200

/obj/item/projectile/bullet/honker/New()
	..()
	SpinAnimation()

/obj/item/projectile/bullet/meteorshot/on_hit(atom/target, blocked = 0)
	. = ..()
	if(istype(target, /atom/movable))
		var/atom/movable/M = target
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		M.throw_at(throw_target, 3, 2)

/obj/item/projectile/bullet/meteorshot/New()
	..()
	SpinAnimation()


/obj/item/projectile/bullet/mime
	damage = 20

/obj/item/projectile/bullet/mime/on_hit(atom/target, blocked = 0)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.silent = max(M.silent, 10)


/obj/item/projectile/bullet/dart
	name = "dart"
	icon_state = "cbbolt"
	damage = 6
	var/piercing = 0

/obj/item/projectile/bullet/dart/New()
	..()
	create_reagents(50)
	reagents.set_reacting(FALSE)

/obj/item/projectile/bullet/dart/on_hit(atom/target, blocked = 0, hit_zone)
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		if(blocked != 100) // not completely blocked
			if(M.can_inject(null,0,hit_zone,piercing)) // Pass the hit zone to see if it can inject by whether it hit the head or the body.
				..()
				reagents.reaction(M, INJECT)
				reagents.trans_to(M, reagents.total_volume)
				return 1
			else
				blocked = 100
				target.visible_message("<span class='danger'>The [name] was deflected!</span>", \
									   "<span class='userdanger'>You were protected against the [name]!</span>")

	..(target, blocked, hit_zone)
	reagents.set_reacting(TRUE)
	reagents.handle_reactions()
	return 1

/obj/item/projectile/bullet/dart/metalfoam/New()
	..()
	reagents.add_reagent("aluminium", 15)
	reagents.add_reagent("foaming_agent", 5)
	reagents.add_reagent("facid", 5)

//This one is for future syringe guns update
/obj/item/projectile/bullet/dart/syringe
	name = "syringe"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "syringeproj"

//Piercing Syringe
/obj/item/projectile/bullet/dart/syringe/piercing
	piercing = 1

/obj/item/projectile/bullet/neurotoxin
	name = "neurotoxin spit"
	icon_state = "neurotoxin"
	damage = 5
	damage_type = TOX
	weaken = 5

/obj/item/projectile/bullet/neurotoxin/on_hit(atom/target, blocked = 0)
	if(isalien(target))
		weaken = 0
		nodamage = 1
	. = ..() // Execute the rest of the code.


/obj/item/projectile/bullet/neurospit
	name = "neurotoxin spit"
	icon_state = "neurotoxin"
	damage_type = BURN
	damage = 5

/obj/item/projectile/bullet/neurospit/on_hit(atom/target, blocked = 0)
	if(isalien(target))
		nodamage = 1
		damage = 0

	if(isitem(target))
		var/obj/item/I = target

		switch(damage)

			if(10)
				if(I.w_class == (1 || 2))
					splashAcid(I)

			if(15)
				if(I.w_class <= 3)
					splashAcid(I)


			if(20)
				if(I.w_class <= 4)
					splashAcid(I)

	if(istype(target, /obj/structure))
		if(damage == (15 || 20 || 25))
			splashAcid(target)
		else
			failText(target)

	if(istype(target, /obj/machinery))
		if(damage == (15 || 20 || 25))
			splashAcid(target)
		else
			failText(target)


	if(istype(target, /turf/closed/wall))
		if(damage == 25)
			splashAcid(turf = target)
		else
			failText(target)


	if(istype(target, /mob/living/carbon/human))
		if(damage <= 5)
			return

		var/mob/living/carbon/human/H = target
		if(H.dna.species.armor > damage*2) // species like golems are resistant to the alien acid
			damage -= 5
		else
			H.acid_act(damage,damage,damage*10)
			// we take off some of the load because most of the damage comes from the acid_act()
			nodamage = 1
			damage = 0




/obj/item/projectile/bullet/neurospit/proc/splashAcid(var/obj/item/item, var/turf/turf)
	if(item)
		new /obj/effect/acid(get_turf(item), item)
	if(turf)
		new /obj/effect/acid(turf, turf)

/obj/item/projectile/bullet/neurospit/proc/failText(var/target)
	visible_message("[src] slaps against [target], and the mixture begins to bubble! Nothing happens, and the [target] withstands the heat.", "[src] slaps against [target].")


/obj/item/projectile/bullet/neurospit/average
	damage = 10

/obj/item/projectile/bullet/neurospit/moderate
	damage = 15

/obj/item/projectile/bullet/neurospit/strong
	damage = 20

/obj/item/projectile/bullet/neurospit/bulky
	damage = 25
