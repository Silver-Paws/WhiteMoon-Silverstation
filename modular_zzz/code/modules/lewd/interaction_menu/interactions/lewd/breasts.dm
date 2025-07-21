/// ADD ANDROMEDA-13 (@ms_kira): Перевод, дополнение ЕРП контента.
/// Взято из PR #6 билда Андромеда-13
/datum/interaction/lewd/breastfeed
	name = "Грудь: накормить (Грудь)"
	description = "Накормить своего партнера своей грудью."
	message = list(
		"прижимает свои груди ко рту %TARGET%, выплескивая теплое %MILK% прямо в рот.",
		"наполняет рот %TARGET% теплым и сладким %MILK%, пока грудь сжата.",
		"стреляет в рот %TARGET% своим %MILK%, сжавши свою грудку.",
		"небрежно тычась грудкой в рот %TARGET%, кормит теплым и сладким %MILK%.",
		"нежно сжимает свою грудь, заставляя вытечь сладкое %MILK% в рот %TARGET%.",
		"возится своей грудью с ртом %TARGET%, наполняя тот теплым и сладким %MILK%.",
		"пускает большую струю своей %MILK% прямо на заднюю стенку горла %TARGET%."
	)

/datum/interaction/lewd/titgrope
	name = "Грудь: поласкать"
	description = "Поласкать груди партнёра."
	message = list(
		"нежно хватается за груди %TARGET%.",
		"мягко жмёт груди %TARGET%.",
		"обхватывает груди %TARGET%.",
		"проводит несколькими пальцами по сосочкам груди %TARGET%.",
		"настойчиво дразнит соски %TARGET%.",
		"аккуратно сжимает груди %TARGET% в своих конечностях.",
		"обхватывает груди %TARGET%, начиная водить их по часовой стрелке разминая.",
		"сдавливает груди %TARGET% вместе, затем плавно разминая.",
		"настойчиво жмёт груди %TARGET%, нежно сдавливая их.",
		"проводит пальцем по груди %TARGET%."
	)

/datum/interaction/lewd/titgrope/act(mob/living/user, mob/living/target)
	var/obj/item/liquid_container
	var/list/original_messages = message.Copy()

	// Check for container
	// Проверьте наличие контейнера
	var/obj/item/cached_item = user.get_active_held_item()
	if(istype(cached_item) && cached_item.is_refillable() && cached_item.is_drainable())
		liquid_container = cached_item
	else
		cached_item = user.pulling
		if(istype(cached_item) && cached_item.is_refillable() && cached_item.is_drainable())
			liquid_container = cached_item

	if(liquid_container)
		message = list("сцеживает грудь %TARGET% в [liquid_container].")
		interaction_modifier_flags |= INTERACTION_OVERRIDE_FLUID_TRANSFER
		. = ..()
		interaction_modifier_flags &= ~INTERACTION_OVERRIDE_FLUID_TRANSFER
		message = original_messages
		return

	// Вариации действий от интента
	switch(resolve_intent_name(user.combat_mode))
		if("harm")
			message = list(
				"агрессивно хватается за груди %TARGET% и крепко сжимает их.",
				"берется за груди %TARGET% и начинает крепко сдавливать их.",
				"крепко сдавливает груди %TARGET% в своих конечностях.",
				"неаккуратно и сильно шлепает %TARGET% по груди.",
				"насильно и с силой сжимает груди %TARGET%.",
				"насильно лапает груди %TARGET%, доставляя боль.",
				"крепко ухватившись, насильно облапывает груди %TARGET%.",
				"агрессивно берется за груди %TARGET% и тянет их в разные стороны, сдавливая.",
				"грубо лапает груди %TARGET% вдавливая их"
			)
		if("disarm")
			message = list(
				"игриво ласкает груди %TARGET%.",
				"дразняще лапает груди %TARGET%.",
				"игриво сжимает груди %TARGET%.",
				"заигрывающе мягко водит грудями %TARGET% в разные стороны.",
				"озорнисто сдавливает груди %TARGET%.",
				"игриво подразнивает соски на груди %TARGET% своими пальцами."
			)
		if("grab")
			message = list(
				"крепко и настойчиво обхватывает груди %TARGET%.",
				"словно они собственность, лапает груди %TARGET%.",
				"жадно и беспощадно разминает груди %TARGET%, потягивая те к себе.",
				"грубо и собственнически ласкает груди %TARGET%.",
				"жадно крутит сосочки на груди %TARGET% потягивая те.",
				"жадно потягивает сосочки %TARGET%.",
				"жадно потягивает груди %TARGET%."
			)
	. = ..()
	message = original_messages

/datum/interaction/lewd/titgrope/post_interaction(mob/living/user, mob/living/target)
	. = ..()
	if(interaction_modifier_flags & INTERACTION_OVERRIDE_FLUID_TRANSFER)
		var/obj/item/liquid_container

		var/obj/item/cached_item = user.get_active_held_item()
		if(istype(cached_item) && cached_item.is_refillable() && cached_item.is_drainable())
			liquid_container = cached_item
		else
			cached_item = user.pulling
			if(istype(cached_item) && cached_item.is_refillable() && cached_item.is_drainable())
				liquid_container = cached_item

		if(liquid_container)
			var/obj/item/organ/genital/breasts/breasts = target.get_organ_slot(ORGAN_SLOT_BREASTS)
			if(breasts?.internal_fluid_datum)
				// Calculate milk amount based on how full the breasts are (0.5 to 2 multiplier)
				// Рассчитайте количество молока в зависимости от наполненности груди (множитель от 0,5 до 2)
				var/milk_multiplier = 0.5
				if(breasts.internal_fluid_maximum > 0)
					milk_multiplier = 0.5 + (1.5 * (breasts.internal_fluid_count / breasts.internal_fluid_maximum))

				var/transfer_amount = rand(1, 3 * milk_multiplier)
				var/datum/reagents/R = new(breasts.internal_fluid_maximum)
				breasts.transfer_internal_fluid(R, transfer_amount)
				R.trans_to(liquid_container, R.total_volume)
				qdel(R)

	// Handle arousal effects based on intent
	// Обработка эффектов возбуждения в зависимости от интента
	var/intent = resolve_intent_name(user.combat_mode)
	if(intent != "harm" && prob(5 + target.arousal))
		var/list/arousal_messages
		switch(intent)
			if("help")
				arousal_messages = list(
					"%TARGET% подрагивает от возбуждения.",
					"%TARGET% подрагивает от возбуждения, слегка отклоняясь.",
					"%TARGET% тихо постанывает.",
					"%TARGET% тихо постанывает, слегка отклоняясь.",
					"%TARGET% выдыхает тихий постон.",
					"%TARGET% выдыхает тихий постон, слегка откинув голову.",
					"%TARGET% задыхается в удовольствии.",
					"%TARGET% задыхается в удовольствии, интенсивно подрагивая.",
					"%TARGET% тихонько вздрагивает.",
					"%TARGET% тихонько вздрагивает, зажмурив глаза.",
					"%TARGET% дрожит, когда руки проходят по её груди."
				)
			if("disarm")
				arousal_messages = list(
					"%TARGET% игриво извивается.",
					"%TARGET% игриво извивается и ерзает.",
					"%TARGET% испускает подразнивающее хихиканье.",
					"%TARGET% испускает подразнивающее хихиканье, нежно извиваясь.",
					"%TARGET% прикусывает свою губу, нежно вздыхая.",
					"%TARGET% прикусывает свои губы, аккуратно выдыхая.",
					"%TARGET% дразняще покачивается из стороны в сторону.",
					"%TARGET% дразняще покачивается ерзая на месте.",
					"%TARGET% кокетливо хихикает с удовольствием в глазах.",
					"%TARGET% делает кокетливый вздох."
				)
			if("harm")
				arousal_messages = list(
					"%TARGET% извивается от ласкающей боли.",
					"%TARGET% протяжно подрагивает от применяемого насилия.",
					"%TARGET% болезненно содрогается от грубости.",
					"%TARGET% болезненно постанывает зажмурив глаза и покосившись.",
					"%TARGET% дрожит от боли, выдыхая.",
					"%TARGET% с болью постанывает, извиваясь и дрожа.",
					"%TARGET% извивается в попытке вырваться из грубого захвата, испуская протяжный постон."
				)
			if("grab")
				arousal_messages = list(
					"%TARGET% жадно стонет.",
					"%TARGET% жадно постанывает.",
					"%TARGET% подается навстречу прикосновениям.",
					"%TARGET% подается навстречу прикосновениям, протяжно подрагивая.",
					"%TARGET% издает жаждящий постон.",
					"%TARGET% издает жаждящий постон, извиваясь от удовольствия.",
					"%TARGET% подрагивает от возбуждения.",
					"%TARGET% извиваясь дрожит от возбуждения.",
					"%TARGET% извивается, дрожа от предвкушения и нежно вздыхая.",
					"%TARGET% дрожит от предвкушения, застонав."
				)

		if(arousal_messages)
			var/target_message = list(pick(arousal_messages))
			target.visible_message(span_lewd(replacetext(target_message, "%TARGET%", target)))

/datum/interaction/lewd/breastsmother
	name = "Грудь: придушить"
	description = "Задушите кого-нибудь своей грудью."
	message = list(
		"прижимает свои груди к лицу %TARGET%.",
		"вздохнув, прижимает свои груди к лицу %TARGET% и елозит ими.",
		"душит лицо %TARGET% своими грудями.",
		"плавно придушивает %TARGET% своими сисечками.",
		"возится грудью о лицо %TARGET%, сжимая между полусфер.",
		"грубо сжимает голову %TARGET% между своими грудями.",
		"крепко прижимает лицо %TARGET% к своим грудям, зажимая его.",
		"зажимает голову %TARGET% между своих сисек, начиная елозить ими."
	)
	user_messages = list(
		"Вы чувствуете, как лицо %TARGET% крепко зажато между ваших сисек.",
		"Вы крепко прижимаете голову %TARGET% к своей груди.",
		"Вы доминантно жмете %TARGET% в своей груди.",
		"Вы грубо возитесь грудью о лицо %TARGET%.",
		"Вы держите лицо %TARGET% в своем декольте."
	)
	target_messages = list(
		"Ваше лицо зажато между грудей %USER%.",
		"Сиськи %USER% постепенно душат вас.",
		"Нежные на первый взгляд сисечки %USER% придушивают вас.",
		"Титьки %USER% грубо сжимают ваше лико, затрудняя дыхание.",
		"Вы ничего не видите, кроме декольте %USER%."
	)

/datum/interaction/lewd/do_boobjob
	name = "Грудь: ублажить партнера"
	description = "Ублажите партнёра своими грудьми, малыми или большими. "
	cum_message_text_overrides = list(
		CLIMAX_POSITION_TARGET = list(
			"%TARGET% обильно пачкает грудь %USER% своим семенем.",
			"%TARGET% кончает на грудь %USER% своим семенем.",
			"%TARGET% небрежно стреляет горячим семенем в грудки %USER%.",
			"%TARGET% несдерживаясь обильно стреляет в титьки %USER% своим семенем.",
			"%TARGET% обильно пачкает грудь и лицо %USER% своим семенем.",
			"%TARGET% испускает своё семя прямо в титьки %USER%.",
			"%TARGET% обильно стреляет семенем в сиськи %USER%, попадая и на лицо.",
			"%TARGET% покрывает грудь %USER% в своем семени."
		)
    )
	cum_self_text_overrides = list(
		CLIMAX_POSITION_TARGET = list(
			"%TARGET% обильно кончает на вашу грудь.",
			"%TARGET% кончает на вашу грудь своим семенем.",
			"%TARGET% небрежно стреляет горячим сенем в ваши грудки.",
			"%TARGET% несдержанно обильно стреляет в ваши титьки семенем.",
			"%TARGET% обильно кончает на вашу грудь и попадает в ваше лицо.",
			"%TARGET% стреляет семенем в ваши сиськи.",
			"%TARGET% неумолимо стреляет семенем в ваши сиськи, вдобавок пачкая и ваше лицо.",
			"%TARGET% покрывает вашу грудь семенем, пульсируя между ваших сисек."
		)
	)
	cum_partner_text_overrides = list(
		CLIMAX_POSITION_USER = list(
			"Вы обильно кончаете на грудь %USER%.",
			"Вы кончаете на грудь %USER% своим семенем.",
			"Вы небрежно стреляете горячим семенем в грудки %USER%.",
			"Вы несдержанно обильно стреляете в титьки %USER% горячим семенем.",
			"Вы неаккуратно кончаете на грудь %USER% попадая в лицо.",
			"Вы кончаете прямо в сиськи %USER%.",
			"Вы неаккуратно стреляете в грудь %USER% пачкая лицо.",
			"Вы покрываете титьки %USER% своим семенем."
		)
    )
	message = list(
		"обхватывает грудью пенис %TARGET%.",
		"игриво водит своей грудью вокруг пениса %TARGET%.",
		"нежно надрачивает член %TARGET% своими грудями.",
		"вздрачивает своими грудьми член %TARGET% вверх-вниз.",
		"неаккуратно сжимает сисечками член %TARGET%.",
		"елозит своими полусферками вокруг члена %TARGET%.",
		"аккуратно возится своими грудками вокруг пениса %TARGET%.",
		"работает своей грудью с членом %TARGET%.",
		"ублажает член %TARGET% своей грудью.",
		"двигает своими грудями вверх-вниз ухватив между ними член %TARGET%.",
		"сжимает свои груди вокруг члена %TARGET%."
	)
	user_messages = list(
		"Вы чувствуете как пенис %TARGET% содрогается в пульсации между ваших грудей.",
		"Тепло ствола %TARGET% довольно приятно ощущается между ваших грудей.",
		"Член %TARGET% будоражаще пульсирует между ваших грудок.",
		"Горячий член %TARGET% нежно содрогается от удовольствия, между ваших сисек.",
		"Вы ощущаете как груди трутся все легче, постепенно двигая своей грудью вверх-вниз, обхватив член %TARGET% ею же.",
		"Вы сжимаете свою грудь вокруг члена %TARGET%."
	)
	target_messages = list(
		"Мягкая грудь %USER% нежно сжимает ваш член.",
		"Нежная работа грудью %USER% сводит вашего друга с ума.",
		"Плавные и мягкие движения титьками %USER% заставляет дрожать.",
		"Ваш ствол с легкостью скользит между сисек %USER%.",
		"Вы ощущаете как груди %USER% двигаются вверх-вниз обхватывая ваш член, создавая еще большее тепло.",
		"Мягкость груди %USER% сводит вас с ума."
	)
