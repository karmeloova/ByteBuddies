extends RigidBody2D
var collided : bool = false
var camera_move : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	VariableManager.platform_size = $Sprite2D.scale.x;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	if not collided : 
		SignalManager.add_point.emit()
		SignalManager.move_camera.emit(150-VariableManager.player_size/2);
		VariableManager.moved = true;
		collided = true;

func _on_remove_timer_timeout():
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	$RemoveTimer.start(1)
	SignalManager.remove_platform.emit()
	SignalManager.add_platform.emit()
