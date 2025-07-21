/datum/interaction/lewd/jack_self
	name = "Член: подрочить себе"
	description = "Удовлетворитесь собственноручно."
	cum_message_text_overrides = list(CLIMAX_POSITION_USER = list(
		"кончает себе на руки после \"работы\".",
		"судорожно кончает в собственные ладошки.",
		"покрывает свои пальцы семенем.",
		"выплескивает семя на собственные руки."
	))
	cum_self_text_overrides = list(CLIMAX_POSITION_USER = list(
		"Вы кончаете себе на руки после 'работы'",
		"Вы судорожно кончаете в собственные ладошки.",
		"Вы покрываете свои пальцы семенем.",
		"Вы выплескиваете семя на собственные руки."
	))
	message = list(
		"работает руками, мастурбируя",
		"удовлетворяется, прикрыв глаза, водя по члену ладонью",
		"играется пальцами по стволу собственного члена",
		"дрочит, обхватив член всей ладонью и пальцами"
	)

/datum/interaction/lewd/jack_self/act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(!ishuman(user))
		return
	var/obj/item/liquid_container

	var/obj/item/cached_item = user.get_active_held_item()
	if(istype(cached_item) && cached_item.is_refillable() && cached_item.is_drainable())
		liquid_container = cached_item
	else
		cached_item = user.pulling
		if(istype(cached_item) && cached_item.is_refillable() && cached_item.is_drainable())
			liquid_container = cached_item

	if(liquid_container)
		var/list/original_messages = message.Copy()
		var/chosen_message = pick(message)
		message = list("[chosen_message] над [liquid_container]")
		interaction_modifier_flags |= INTERACTION_OVERRIDE_FLUID_TRANSFER
		. = ..()
		interaction_modifier_flags &= ~INTERACTION_OVERRIDE_FLUID_TRANSFER
		message = original_messages
	else
		. = ..()
