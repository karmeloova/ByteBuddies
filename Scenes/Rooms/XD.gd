extends Node2D

func _on_button_pressed():
	VariableManager.coins += 100
	SignalManager.change_money.emit()

func _on_button_2_pressed():
	SignalManager.add_exp.emit(20)
