extends Node2D

func _ready():
	$FishCounter.text = str(VariableManager.fishes)
	SignalManager.update_fish_counter.connect(_on_update_fish_counter)

func _on_update_fish_counter() :
	$FishCounter.text = str(VariableManager.fishes)
