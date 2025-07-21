/// ADD ANDROMEDA-13 (@ms_kira): Перевод, дополнение ЕРП контента.
/// Взято из PR #6 билда Андромеда-13
/datum/interaction/lewd/handjob
	name = "Член: подрочить партнёру"
	description = "Ублажи партнёра руками."
	message = list(
		"вздрачивает член %TARGET%",
		"грубо подрачивает пенис %TARGET%",
		"неаккуратно продрачивает член %TARGET%",
		"ласково играется с пенисом %TARGET%",
		"работает со стволом %TARGET% своими руками",
	)
	cum_message_text_overrides = list(
		CLIMAX_POSITION_TARGET = list(
			"кончает на руки %USER%.",
			"судорожно кончает в ладошки %USER%.",
			"кончает на ручки %USER%.",
			"выплескивает свое семя на руки %USER%.",
			"покрывает семенем пальцы %USER%."
		)
	)
	cum_self_text_overrides = list(
		CLIMAX_POSITION_TARGET = list(
			"Вы кончаете на руки %USER%.",
			"Вы судорожно кончаете в ладошки %USER%.",
			"Вы кончаете на ручки %USER%.",
			"Вы стреляете на ладошки %USER%.",
			"Вы покрываете семенем пальчики %USER%."
		)
	)
	cum_partner_text_overrides = list(
		CLIMAX_POSITION_TARGET = list(
			"%TARGET% кончает на ваши руки.",
			"%TARGET% судорожно кончает в ваши ладошки.",
			"%TARGET% сжавшись стреляет горячим семенем на ваши ручки.",
			"%TARGET% стреляет на ваши ладошки.",
			"%TARGET% покрывает семенем ваши пальчики."
		)
	)

/datum/interaction/lewd/handjob/act(mob/living/user, mob/living/target)
	var/obj/item/liquid_container

	// Check active hand first
	// Проверка, активная рука
	var/obj/item/cached_item = user.get_active_held_item()
	if(istype(cached_item) && cached_item.is_refillable() && cached_item.is_drainable())
		liquid_container = cached_item
	else
		// Check if pulling a container
		// Проверка, есть ли контейнер
		cached_item = user.pulling
		if(istype(cached_item) && cached_item.is_refillable() && cached_item.is_drainable())
			liquid_container = cached_item

	// Add container text to message if needed
	// Добавьте текст контейнера в сообщение, если это необходимо
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

/datum/interaction/lewd/handjob/show_climax(mob/living/cumming, mob/living/came_in, position)
	if(interaction_modifier_flags & INTERACTION_OVERRIDE_FLUID_TRANSFER)
		var/obj/item/liquid_container

		// Check active hand first
		// Проверка, активная рука
		var/obj/item/cached_item = came_in.get_active_held_item()
		if(istype(cached_item) && cached_item.is_refillable() && cached_item.is_drainable())
			liquid_container = cached_item
		else
			// Check if pulling a container
			// Проверка, есть ли контейнер
			cached_item = came_in.pulling
			if(istype(cached_item) && cached_item.is_refillable() && cached_item.is_drainable())
				liquid_container = cached_item

		if(liquid_container)
			// Store original lists, with null checks
			// Храните исходные списки с нулевыми проверками
			var/list/original_message_overrides = cum_message_text_overrides[position]
			var/list/original_self_overrides = cum_self_text_overrides[position]
			var/list/original_partner_overrides = cum_partner_text_overrides[position]
			original_message_overrides = original_message_overrides?.Copy()
			original_self_overrides = original_self_overrides?.Copy()
			original_partner_overrides = original_partner_overrides?.Copy()

			// Set container-specific messages
			// Установка сообщения конкретно для контейнера
			cum_message_text_overrides[position] = list("Кончает в [liquid_container].")
			cum_self_text_overrides[position] = list("Вы кончаете в [liquid_container].")
			cum_partner_text_overrides[position] = list("%TARGET% кончает в [liquid_container].")

			. = ..()

			// Restore original messages
			// Восстановление исходных сообщений
			cum_message_text_overrides[position] = original_message_overrides
			cum_self_text_overrides[position] = original_self_overrides
			cum_partner_text_overrides[position] = original_partner_overrides
			return

	. = ..()

/datum/interaction/lewd/handjob/post_climax(mob/living/cumming, mob/living/came_in, position)
	if(interaction_modifier_flags & INTERACTION_OVERRIDE_FLUID_TRANSFER)
		var/obj/item/liquid_container

		// Check active hand first
		// Проверка, активная рука
		var/obj/item/cached_item = came_in.get_active_held_item()
		if(istype(cached_item) && cached_item.is_refillable() && cached_item.is_drainable())
			liquid_container = cached_item
		else
			// Check if pulling a container
			// Проверка, тащит ли контейнер
			cached_item = came_in.pulling
			if(istype(cached_item) && cached_item.is_refillable() && cached_item.is_drainable())
				liquid_container = cached_item

		if(liquid_container)
			var/obj/item/organ/genital/testicles/testicles = cumming.get_organ_slot(ORGAN_SLOT_TESTICLES)
			if(testicles)
				testicles.transfer_internal_fluid(liquid_container.reagents, testicles.internal_fluid_count)

	. = ..()
