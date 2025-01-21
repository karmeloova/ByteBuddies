extends Node2D
var points = 0;
var basketColor = 0;
var fruitColor = 0;
var coins = 0;

func _ready():
	$Score.text = "Wynik: 0" 
	$Coins.text = "Coins: 0"
	SignalManager.add_point.connect(_on_add_point);
	SignalManager.basketColor.connect(_on_basketColor);
	SignalManager.fruitColor.connect(_on_fruitColor);
	SignalManager.loseGame.connect(_on_lose_game);
	SignalManager.save_data.connect(_on_save_data);

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
	VariableManager.coins += coins;
	SignalManager.unlock_achievement.emit(points, "fruit_catcher", null)
	SignalManager.add_exp.emit(points/2)

func _on_save_data() :
	SignalManager.add_exp.emit(points/2)
	VariableManager.coins += coins;

func add_coin() :
	coins += 1;
	$Coins.text = "Coins: " + str(coins)
