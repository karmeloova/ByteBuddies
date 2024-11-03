extends Area2D

func _ready():
	VariableManager.tile_size = $CollisionShape2D.shape.size*$".".scale;
