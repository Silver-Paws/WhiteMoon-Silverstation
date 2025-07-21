/datum/interaction/lewd/finger_self_vagina
	name = "Фингеринг (Себя, вагинальный)"
	description = "Поиграйтесь с собственной киской."
	cum_message_text_overrides = list(CLIMAX_POSITION_USER = list(
		"содрогаясь, оргазмирует на свои пальцы.",
		"дрожа, сквиртует прямо на свои пальцы .",
		"извивается от удовольствия, прежде чем оргазмировать на себя.",
		"чуть согнувшись, пачкает обильным оргазмом собственные пальцы."
	))
	cum_self_text_overrides = list(CLIMAX_POSITION_USER = list(
		"Задрожав, вы оргазмируете от работы своих пальцев.",
		"Нежно дрожа, вы оргазмируете на собственные пальчики.",
		"Неумолимо подрагивая от ощущений собственной киски, вы сквиртуете на собственные пальчики.",
		"Поджав свои ножки вместе, вы стреляете соками себе на ладонь."
	))
	message = list(
		"глубоко погружает пальцы в свою киску",
		"фингерит себя в вагину",
		"играет пальчиками с собственной киской",
		"активно фингерит свою киску"
	)

/datum/interaction/lewd/finger_self_vagina/act(mob/living/user, mob/living/target)
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

/datum/interaction/lewd/finger_self_anus
	name = "Фингеринг (Себя, анальный)"
	description = "Finger your own ass."
	message = list(
		"фингерит свою попку.",
		"глубоко заводит два пальца внутрь своей задницы.",
		"погружает несколько пальцев в задницу, выдохнув ртом.",
		"изгибается в спине, фингеря свою попку сразу двумя пальцами."
	)
