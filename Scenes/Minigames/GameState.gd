extends Node2D
var score = 0
var money = 0
var fishes = 0
var new_high_score = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Score.text = "Wynik: " + str(score)
	$Money.text = str(money)
	$Fishes.text = str(fishes)
	SignalManager.calculate_score.connect(_on_calculate_score)
	SignalManager.add_coin.connect(_on_add_coin)
	SignalManager.save_data.connect(_on_save_data)
	SignalManager.restartGame.connect(_on_save_data)
	SignalManager.loseGame.connect(_on_lose_game)
	SignalManager.update_fish_counter_in_mini_game.connect(_on_update_fish_counter_in_mini_game)

func _on_calculate_score(lines) :
	# Punkty za długość kodu
	if(VariableManager.lines_couner <= lines+1) :
		score += 20
	elif(VariableManager.lines_couner - (lines+1) <= 5) :
		score += randi_range(10, 19)
	elif(VariableManager.lines_couner - (lines+1) <= 10) :
		score += randi_range(1,9)
	
	# Punkty za ilość wykonań
	if(VariableManager.execute_counter == 1) :
		score += 15
	elif(VariableManager.execute_counter <= (VariableManager.tiles_counter-1)/2) :
		score += 10
	else :
		score += 5
	
	update_score()

func update_score() :
	$Score.text = "Wynik: " + str(score)

func _on_add_coin(value) :
	money += value
	$Money.text = str(money)

func _on_save_data() :
	add_coins()
	SignalManager.add_exp.emit(score/5)

func _on_lose_game() :
	if(score > VariableManager.snack_navigator_high_score) :
		VariableManager.snack_navigator_high_score = score
		new_high_score = true
	SignalManager.set_lose_score.emit(score, new_high_score)
	SignalManager.set_lose_currencies.emit(money, fishes, true)
	add_coins()
	SignalManager.unlock_achievement.emit(score, "snack_navigator", null)
	SignalManager.add_exp.emit(score/5)

func add_coins() :
	if(BoosterManager.active_booster != null && BoosterManager.active_booster.booster_category == MyEnums.BoosterCategory.coins && VariableManager.is_playing) :
		VariableManager.coins += money*BoosterManager.multiplier
		SignalManager.decrease_booster_uses.emit()
	else :
		VariableManager.coins += money

func _on_update_fish_counter_in_mini_game(value : int) :
	fishes += value
	$Fishes.text = str(fishes)
