extends Node2D
@export var game_name : String

func _ready():
	get_tree().paused = true
	$Panel/MinigameName.text = game_name
	set_high_score()
	SignalManager.set_correct_instruction.emit(game_name)
	SignalManager.restartGame.connect(_on_restart_game)
	
func set_high_score() :
	match game_name :
		"Snack Navigator" :
			$Panel/Record.text = "Rekord: " + str(VariableManager.snack_navigator_high_score)
		"Cat Jump":
			$Panel/Record.text = "Rekord: " + str(VariableManager.cat_jump_high_score)
		"Pet Code":
			$Panel/Record.text = "Rekord: " + str(VariableManager.pet_code_high_score)
		"Fruit Catcher":
			$Panel/Record.text = "Rekord: " + str(VariableManager.fruit_catcher_high_score)

func _on_restart_game() :
	visible = false
