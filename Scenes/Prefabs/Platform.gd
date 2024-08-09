extends RigidBody2D
var collided : bool = false
var camera_move : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	VariableManager.platform_size = $Sprite2D.scale.x;
	SignalManager.remove_platform.connect(_on_remove_platform)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	if not collided : 
		SignalManager.move_camera.emit(150-VariableManager.player_size/2);
		collided = true;

func _on_remove_platform(camera_pos) :
	if(position.y > camera_pos) :
		$RemoveTimer.start(1)
		

func _on_remove_timer_timeout():
	queue_free()
	
