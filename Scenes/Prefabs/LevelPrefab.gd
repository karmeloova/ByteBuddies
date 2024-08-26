extends Node2D

@export var levels : Array[Level]
var next_level
var level_number : int = 0
var can_be_promoted : bool = true

func _ready():
	next_level = levels[level_number]
	$Exp.max_value = next_level.need_exp
	$Exp.value = VariableManager.current_exp
	$Level.text = "Poziom 1"
	$CurrentExp.text = str(VariableManager.current_exp) + "/" + str(next_level.need_exp)
	SignalManager.add_exp.connect(_on_add_exp)

func _on_add_exp(value):
	$Exp.value = VariableManager.current_exp
	$CurrentExp.text = str(VariableManager.current_exp) + "/" + str(next_level.need_exp)
	if(VariableManager.current_exp >= next_level.need_exp) :
		if(VariableManager.can_be_promoted) : promotion()
		else: print("osiągnąłeś maksymalny poziom")	

func promotion():
	VariableManager.current_exp = 0;
	$Exp.value = VariableManager.current_exp
	$Level.text = "Poziom " + str(next_level.level)
	level_number += 1
	if(level_number == levels.size()-1) :
		VariableManager.can_be_promoted = false
	next_level = levels[level_number]
	$Exp.max_value = next_level.need_exp
	$CurrentExp.text = str(VariableManager.current_exp) + "/" + str(next_level.need_exp)
	print("Jestes teraz na poziomie: ", levels[level_number-1].level)
	

