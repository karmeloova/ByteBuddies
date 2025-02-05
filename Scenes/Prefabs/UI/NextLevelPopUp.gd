extends Node2D
@export var plans_to_unlock : Array[Plan]

func _on_button_mouse_entered():
	$PanelTemplate/Exit.modulate = Color("b2b2b2")

func _on_button_mouse_exited():
	$PanelTemplate/Exit.modulate = Color("ffffff")

func _on_button_pressed():
	visible = false
	SignalManager.show_next_pop_up.emit()

func set_textes(level : Level) :
	SignalManager.changed_scene.emit()
	$LevelText.text = str(level.level)
	$Prize.text = "+" + str(level.money_prize)
	if(level.unlock_something) :
		for plan in plans_to_unlock :
			if(plan.required_level.level == level.level) :
				$UnlockLabel.text = "Gratulacje, odblokowales: " + plan.plan_name
				$UnlockLabel.visible = true
				break
