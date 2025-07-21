/// ADD ANDROMEDA-13 (@ms_kira): Перевод, дополнение ЕРП контента.
/// Взято из PR #6 билда Андромеда-13
/datum/interaction/lewd/rimjob
	name = "Язык: римминг"
	description = "Он же анилингус. Приятное языком в отношении задницы вашего партнёра."
	message = list(
		"Лижет задницу %TARGET%.",
		"С пристрастием вылизывает попку %TARGET%.",
		"Проходится своим языком по попке %TARGET%.",
		"Глубоко погружает язык в попку %TARGET%.",
		"Зарывается языком в попку %TARGET%.",
		"Прижимает язык к попке %TARGET%.",
		"Страстно вылизывает попку %TARGET%."
	)

/datum/interaction/lewd/lickfeet
	name = "Язык: облизать ногу"
	description = "Ублажите партнёра уходом за его ногой."
	message = list(
		"лижет босые ноги %TARGET%.",
		"вылизывает ножки %TARGET%.",
		"страстно облизывает ножки %TARGET%.",
		"чувственно проходится языком по ножке %TARGET%.",
		"аккуратно и дразняще лижет ножку %TARGET%.",
		"проводит языком по подошвам %TARGET%.",
		"лижет пальцы ног %TARGET%.",
		"пробует на вкус босые ноги %TARGET%."
	)

/datum/interaction/lewd/lickfeet/act(mob/living/user, mob/living/target)
	var/list/original_messages = message.Copy()
	var/obj/item/clothing/shoes/shoes = target.get_item_by_slot(ITEM_SLOT_FEET)

	if(shoes)
		message = list(
			"лижет [shoes.name] %TARGET%.",
			"проходит язычком по подошвам [shoes.name] %TARGET%.",
			"проходится язычком по обуви [shoes.name] %TARGET%.",
			"пробует на вкус обувь [shoes.name] %TARGET%."
		)
	. = ..()
	message = original_messages

/datum/interaction/lewd/lick_nuts
	name = "Язык: вылизать яйца"
	description = "Оральная ласка мошонки вашего партнёра."
	message = list(
		"лижет яйца %TARGET%.",
		"посасывает мошонку %TARGET% в процессе вылизывания.",
		"брежно проходится язычком по мошонке %TARGET%.",
		"агрессивно сосет и вылизывает яички %TARGET%.",
		"сосет яички %TARGET%.",
		"лижет язычком яйца %TARGET%.",
	)
	user_messages = list(
		"Вы чувствуете яйца %TARGET% на своем языке.",
		"Вкус мошонки %TARGET% заполняет ваш рот.",
		"Вы заботливо уделяете внимание яйцам %TARGET%."
	)
	target_messages = list(
		"Язык %USER% работает над вашими яйцами.",
		"Вы чувствуете горячий рот %USER% на своих яйцам.",
		"Тепло языка %USER% заставляет ваши яйца покалывать."
	)

/datum/interaction/lewd/lick_sweat
	name = "Язык: слизывать пот"
	description = "Слижите пот вашего партнёра."
	message = list(
		"слизывает пот с тела %TARGET%.",
		"пробует на вкус солёный пот %TARGET%.",
		"проходится языком вдоль потного тела %TARGET%.",
		"наслаждается вкусом пота %TARGET%."
	)
	user_messages = list(
		"Вы вкушаете солёный вкус пота %TARGET%.",
		"Привкус пота %TARGET% наполняет ваш рот.",
		"Вы наслаждаетесь солоноватым привкусом пота с тела %TARGET%."
	)
	target_messages = list(
		"Вы ощущаете, как язык %USER% слизывает с вас пот.",
		"Влажный язык %USER% скользит по вашему потному телу.",
		"Тепло рта %USER% слегка щекотит ваше вспотевшее тело."
	)
