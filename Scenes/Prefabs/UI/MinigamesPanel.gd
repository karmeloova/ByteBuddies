extends Node2D
@export var game_name : String

func _ready():
	get_tree().paused = true
	$Panel/MinigameName.text = game_name
	set_high_score()
	SignalManager.set_correct_instruction.emit(game_name)
	SignalManager.restartGame.connect(_on_restart_game)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_high_score() :
	match game_name :
		"Snack Navigator" :
			$Panel/Record.text = "Record: " + str(VariableManager.snack_navigator_high_score)
		"Cat Jump":
			$Panel/Record.text = "Record: " + str(VariableManager.cat_jump_high_score)

func _on_restart_game() :
	visible = false
