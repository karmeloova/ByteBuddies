extends Node2D

func _ready():
	SignalManager.show_pop_up.connect(_on_show_pop_up)

func _on_show_pop_up() :
	visible = true

func _on_yes_button_pressed():
	SignalManager.save_settings.emit(true)
	SignalManager.hide_settings_panel.emit()
	visible = false

func _on_no_button_pressed():
	SignalManager.save_settings.emit(false)
	SignalManager.hide_settings_panel.emit()
	visible = false

func _on_cancel_pressed():
	visible = false
