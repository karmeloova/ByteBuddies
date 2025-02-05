extends Label
var coins : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.add_coin.connect(_on_add_coin)
	SignalManager.loseGame.connect(_on_lose_game)
	SignalManager.save_data.connect(_on_save_data)
	SignalManager.restartGame.connect(_on_save_data)
	text = str(coins)

func _on_add_coin(value) :
	coins += 1
	text = str(coins)

func _on_lose_game() :
	add_coins()
	SignalManager.set_lose_currencies.emit(coins, 0, false)

func _on_save_data() :
	add_coins()

func add_coins() :
	if(BoosterManager.active_booster != null && BoosterManager.active_booster.booster_category == MyEnums.BoosterCategory.coins && VariableManager.is_playing) :
		VariableManager.coins += coins*BoosterManager.multiplier
		SignalManager.decrease_booster_uses.emit()
	else :
		VariableManager.coins += coins
