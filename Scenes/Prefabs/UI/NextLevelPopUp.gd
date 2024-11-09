extends Node2D

func _on_button_mouse_entered():
	$PanelTemplate/Exit.modulate = Color("b2b2b2")

func _on_button_mouse_exited():
	$PanelTemplate/Exit.modulate = Color("ffffff")

func _on_button_pressed():
	visible = false
	SignalManager.show_next_pop_up.emit()

func set_textes(level : Level) :
	$LevelText.text = str(level.level)
	$Prize.text = "+" + str(level.money_prize) + " monet"
