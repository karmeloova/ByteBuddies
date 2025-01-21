extends Node
var folder_path = "res://Resources/Levels/"

var levels : Array[Level] 
var exp : int = 0
var current_level : Level
var level_number : int = 0
var was_promotion : Array[bool]
var promoted_levels : Array[Level]
signal changed_exp()
signal promoted()

func _ready():
	add_levels_to_array()
	current_level = levels[level_number]
	SignalManager.add_exp.connect(_on_add_exp)

func _on_add_exp(value):
	if(BoosterManager.active_booster != null && BoosterManager.booster_category == MyEnums.BoosterCategory.exp && VariableManager.is_playing) :
		print("juhu podwójny exp")
		SignalManager.decrease_booster_uses.emit()
		exp += value*2
	else : exp += value
	if(exp >= current_level.next_level_need_exp) :
		while(exp >= current_level.next_level_need_exp) :
			exp -= current_level.next_level_need_exp
			promotion()
	changed_exp.emit()
	
func add_levels_to_array() :
	levels.append(load("res://Resources/Levels/Level1.tres"))
	levels.append(load("res://Resources/Levels/Level2.tres"))
	levels.append(load("res://Resources/Levels/Level3.tres"))
	levels.append(load("res://Resources/Levels/Level4.tres"))
	levels.append(load("res://Resources/Levels/Level5.tres"))

func promotion() :
	if(level_number+1 < levels.size()) :
		was_promotion.append(true)
		level_number += 1
		current_level = levels[level_number]
		VariableManager.coins += current_level.money_prize
		SignalManager.change_money.emit()
		promoted_levels.append(current_level)
		promoted.emit()
