extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.add_exp.connect(_on_add_exp)

func _on_add_exp(value):
	VariableManager.current_exp += value
