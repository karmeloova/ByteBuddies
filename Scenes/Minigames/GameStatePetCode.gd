extends Node2D
var score : int = 0
var coins : int = 0
var fishes : int = 0 
var new_high_score = false

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.add_point.connect(_on_add_point)
	SignalManager.add_coin.connect(_on_add_coin)
	SignalManager.loseGame.connect(_on_lose_game)
	SignalManager.save_data.connect(_on_save_data)
	SignalManager.restartGame.connect(_on_save_data)
	SignalManager.update_fish_counter_in_mini_game.connect(_on_update_fish_in_mini_games)
	$Score.text = "Wynik: " + str(score)
	$Money.text = str(coins)
	$Fishes.text = str(fishes)

func _on_add_point() :
	score += VariableManager.code_pet_score
	$Score.text = "Wynik: " + str(score)

func _on_add_coin(value) :
	coins += value
	$Money.text = str(coins)

func _on_lose_game() :
	if(VariableManager.pet_code_high_score < score) :
		VariableManager.pet_code_high_score = score
		new_high_score = true
	SignalManager.set_lose_score.emit(score, new_high_score)
	SignalManager.set_lose_currencies.emit(coins, fishes, true)
	add_coins()
	SignalManager.unlock_achievement.emit(score, "pet_code", null)
	SignalManager.add_exp.emit(score/3)
	
func _on_save_data() :
	add_coins()
	SignalManager.add_exp.emit(score/3)
	
func add_coins() :
	if(BoosterManager.active_booster != null && BoosterManager.active_booster.booster_category == MyEnums.BoosterCategory.coins && VariableManager.is_playing) :
		VariableManager.coins += coins*BoosterManager.multiplier
		SignalManager.decrease_booster_uses.emit()
	else :
		VariableManager.coins += coins

func _on_update_fish_in_mini_games(value : int) :
	fishes += value
	$Fishes.text = str(fishes)
