extends Node2D

func _on_button_pressed():
	VariableManager.coins += 100
	SignalManager.change_money.emit()

func _on_button_2_pressed():
	SignalManager.add_exp.emit(20)

func _on_button_3_pressed():
	VariableManager.fishes += 10
	SignalManager.update_fish_counter.emit()

func _input(event):
	if(Input.is_key_pressed(KEY_0)) :
		visible = !visible
