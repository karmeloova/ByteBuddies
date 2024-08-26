extends Label
var coins : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.add_coin.connect(_on_add_coin)
	SignalManager.loseGame.connect(_on_lose_game)
	text = "Coins: " + str(coins)

func _on_add_coin(value) :
	coins += 1
	text = "Coins: " + str(coins)

func _on_lose_game() :
	VariableManager.coins += coins
