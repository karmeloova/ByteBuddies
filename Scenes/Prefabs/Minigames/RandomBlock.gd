extends Node2D

@export var blocks : Array[Area2D]
var drawn_block

func _ready():
	for i in blocks :
		i.visible = false
	
	drawn_block = blocks.pick_random()
	drawn_block.visible = true;
