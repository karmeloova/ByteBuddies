extends Node2D

func _ready():
	SignalManager.change_money.connect(_on_change_money)
	$Money.text = str(VariableManager.coins)
	
func _on_change_money() :
	$Money.text = str(VariableManager.coins)
