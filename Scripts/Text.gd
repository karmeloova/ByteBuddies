extends Node2D
var points = 0;
var basketColor = 0;
var fruitColor = 0;
var coins = 0;
var fishes = 0;
var new_high_score

func _ready():
	$Score.text = "Wynik: 0" 
	$Coins.text = str(coins)
	$Fishes.text = str(fishes)

	SignalManager.add_point.connect(_on_add_point);
	SignalManager.basketColor.connect(_on_basketColor);
	SignalManager.fruitColor.connect(_on_fruitColor);
	SignalManager.loseGame.connect(_on_lose_game);
	SignalManager.save_data.connect(_on_save_data);
	SignalManager.update_fish_counter_in_mini_game.connect(_on_update_fish_counter_in_mini_game)

func _on_add_point() :
	if(basketColor==fruitColor) : 
		points += 1;
		$Score.text = "Wynik: " + str(points);
		if(points%3 == 0) : add_coin()
		if(points%10 == 0) : SignalManager.add_fishes.emit()
	else : SignalManager.loseLife.emit();

func _on_basketColor(color) :
	basketColor = color;
	
func _on_fruitColor(color) :
	fruitColor = color;

func _on_lose_game() :
	if(points > VariableManager.fruit_catcher_high_score) :
		VariableManager.fruit_catcher_high_score = points
		new_high_score = true
	SignalManager.set_lose_score.emit(points, new_high_score)
	SignalManager.set_lose_currencies.emit(coins, fishes, true)
	add_coins()
	SignalManager.unlock_achievement.emit(points, "fruit_catcher", null)
	SignalManager.add_exp.emit(points/2)

func _on_save_data() :
	SignalManager.add_exp.emit(points/2)
	add_coins()

func add_coin() :
	coins += 1;
	$Coins.text = "Coins: " + str(coins)

func add_coins() :
	if(BoosterManager.active_booster != null && BoosterManager.active_booster.booster_category == MyEnums.BoosterCategory.coins && VariableManager.is_playing) :
		VariableManager.coins += coins*BoosterManager.multiplier
		SignalManager.decrease_booster_uses.emit()
	else :
		VariableManager.coins += coins

func _on_update_fish_counter_in_mini_game(value : int) :
	fishes += value
	$Fishes.text = str(fishes)
