extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.change_money.connect(_on_change_money)
	$Money.text = str(VariableManager.coins)
	
func _on_change_money() :
	$Money.text = str(VariableManager.coins)
