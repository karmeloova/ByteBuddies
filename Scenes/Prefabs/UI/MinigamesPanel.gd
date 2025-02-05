extends Node2D
@export var game_name : String
var booster_text : String

func _ready():
	get_tree().paused = true
	$Panel/MinigameName.text = game_name
	set_high_score()
	check_active_booster()
	SignalManager.set_correct_instruction.emit(game_name)
	SignalManager.restartGame.connect(_on_restart_game)
	SignalManager.play_music.emit(load("res://Audio/MiniGameMusic.mp3"))
	SignalManager.changed_scene.emit()
	
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

func check_active_booster() :
	if(BoosterManager.active_booster != null && !$Panel/BoosterGamesLeft.visible) :
		booster_text = "Booster " + BoosterManager.active_booster.plan_name + " aktywny. Pozostalo " + str(BoosterManager.games_duration) + " gier."
		$Panel/BoosterGamesLeft.text = booster_text
		$Panel/BoosterGamesLeft.visible = true
