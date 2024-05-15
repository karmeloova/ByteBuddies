extends Node2D
var img = [load("res://Images/Progress.png"), load("res://Images/Under.png")];
var dir = 1;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(10);
	$TextureProgressBar.value = VariableManager.hungry;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	$TextureProgressBar.value += dir*5
	VariableManager.hungry = $TextureProgressBar.value
	if($TextureProgressBar.value == 100 or $TextureProgressBar.value == 0) : 
		dir*=-1;
	$Timer.start();

