extends Node2D
@onready var coins_node = self
var Coin = preload("res://Scenes/Prefabs/Coin.tscn")
var coin_instance

func _ready():
	SignalManager.generate_coin.connect(_on_generate_coin)

func _on_generate_coin(last_position, platform_size) -> void :
	coin_instance = Coin.instantiate()
	coins_node.call_deferred("add_child", coin_instance)
	coin_instance.position = Vector2(last_position.x+platform_size/2-15, last_position.y-40)
