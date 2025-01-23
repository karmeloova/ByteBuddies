extends Node2D

func _ready():
	SignalManager.update_fish_counter.connect(_on_update_fish_counter)
	$Label.text = str(VariableManager.fishes)

func _on_update_fish_counter() :
	$Label.text = str(VariableManager.fishes)
