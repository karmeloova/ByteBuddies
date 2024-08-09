extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.move_camera.connect(_on_move_camera)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_move_camera(distance) :
	position.y -= distance;
	SignalManager.remove_platform.emit(position.y)
	SignalManager.add_platform.emit()
