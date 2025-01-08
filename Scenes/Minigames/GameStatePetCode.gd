extends Node2D
var score : int = 0
var coins : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.add_point.connect(_on_add_point)
	SignalManager.add_coin.connect(_on_add_coin)
	SignalManager.loseGame.connect(_on_lose_game)
	SignalManager.save_data.connect(_on_save_data)
	SignalManager.restartGame.connect(_on_save_data)
	$Score.text = "Wynik: " + str(score)
	$Money.text = "Kasa: " + str(coins)

func _on_add_point() :
	score += VariableManager.code_pet_score
	$Score.text = "Wynik: " + str(score)

func _on_add_coin(value) :
	coins += value
	$Money.text = "Kasa: " + str(coins)

func _on_lose_game() :
	if(VariableManager.pet_code_high_score < score) :
		VariableManager.pet_code_high_score = score
	VariableManager.coins += coins
	SignalManager.unlock_achievement.emit(score, "pet_code", null)
	SignalManager.add_exp.emit(score/3)
	
func _on_save_data() :
	VariableManager.coins += coins
	SignalManager.add_exp.emit(score/3)
