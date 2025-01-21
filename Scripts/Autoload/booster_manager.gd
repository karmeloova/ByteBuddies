extends Node
var active_booster : Plan 
var booster_category : MyEnums.BoosterCategory 
var multiplier : int = 0
var games_duration : int = 0

func _ready():
	SignalManager.use_booster.connect(_on_use_booster)
	SignalManager.decrease_booster_uses.connect(_on_decrease_booster_uses)

func _on_use_booster(booster : Plan) :
	active_booster = booster
	booster_category = booster.booster_category
	multiplier = booster.multiplier
	games_duration = booster.games_duration

func _on_decrease_booster_uses() :
	games_duration -= 1
	if(games_duration == 0) :
		active_booster = null
		multiplier = 0
