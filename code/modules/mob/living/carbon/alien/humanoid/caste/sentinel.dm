/mob/living/carbon/alien/humanoid/sentinel
	name = "alien sentinel"
	caste = "s"
	maxHealth = 150
	health = 150
	icon_state = "aliens_s"


/mob/living/carbon/alien/humanoid/sentinel/New()
	internal_organs += new /obj/item/organ/alien/plasmavessel
	internal_organs += new /obj/item/organ/alien/neurotoxinthroat/normal
	AddAbility(new /obj/effect/proc_holder/alien/sneak)
	tail = new /obj/item/weapon/xenomorphtail/sentinel(src)
	..()

/mob/living/carbon/alien/humanoid/sentinel/movement_delay()
	. = ..()
