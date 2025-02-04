extends Node2D
var desc_text : String

func _ready():
	SignalManager.use_booster.connect(_on_use_booster)

func _on_use_booster(booster : Plan, extra_games : int):
	visible = true
	$"../BuildBooster".visible = false
	desc_text = "Teraz, przez " + str(booster.games_duration+extra_games) + " następnych mini-gier "
	if(booster.booster_category == MyEnums.BoosterCategory.exp) :
		desc_text += "Twoje punkty doświadczenia będą "
	if(booster.multiplier == 2) :
		desc_text += "podwajane!\n"
	desc_text += "Dobra robota! Możesz wrócić do ekranu głównego klikając strzałkę na górze."
	$Title.text += booster.plan_name
	$Description.text = desc_text
	
