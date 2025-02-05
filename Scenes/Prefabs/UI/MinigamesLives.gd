extends Node2D

@export var lives : Array[Sprite2D]
@export var lose_life_sprite : CompressedTexture2D
@export var live_sprite : CompressedTexture2D
var lives_count : int = 3

func _ready():
	SignalManager.add_fishes.connect(_on_add_fishes)
	SignalManager.loseLife.connect(_on_lose_life)

func _on_lose_life() :
	lives_count -= 1
	for i in 3-lives_count :
		lives[i].texture = lose_life_sprite;
	if(lives_count == 0) : 
		get_tree().paused = true
		SignalManager.loseGame.emit()
		return

func _on_add_fishes() :
	VariableManager.fishes += lives_count
	SignalManager.update_fish_counter.emit()
	SignalManager.update_fish_counter_in_mini_game.emit(lives_count)

func reset_lives() :
	for i in get_children() :
		i.texture = live_sprite
	lives_count = 3
