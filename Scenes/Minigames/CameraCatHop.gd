extends Camera2D
var camera_speed : int = 125

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	if(VariableManager.moved) :
		position.y -= camera_speed*delta
	
