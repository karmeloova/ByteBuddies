extends Node2D

@export var lives : Array[Sprite2D]
@export var lose_life_sprite : CompressedTexture2D
var lives_count : int = 3

func _ready():
	SignalManager.loseLife.connect(_on_lose_life)

func _on_lose_life() :
	lives_count -= 1
	for i in 3-lives_count :
		lives[i].texture = lose_life_sprite;
		lives[i].rotation = 0
	if(lives_count == 0) : 
		SignalManager.loseGame.emit()
		return
