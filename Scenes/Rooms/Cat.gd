extends Node2D
var tween : Tween;

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.go_to_bowl.connect(_on_go_to_bowl)
	SignalManager.eat_end.connect(_on_eat_end)

func _on_go_to_bowl() :
	tween = self.create_tween()
	tween.set_parallel()
	tween.tween_property(self, "scale", Vector2(0.165, 0.165), 3)
	tween.tween_property(self, "position", Vector2(362, 404), 3)
	$EatTimer.start(3)

func _on_eat_timer_timeout():
	SignalManager.eat.emit();

func _on_eat_end() :
	tween = self.create_tween()
	tween.set_parallel()
	tween.tween_property(self, "scale", Vector2(0.262, 0.262), 3)
	tween.tween_property(self, "position", Vector2(594, 416), 3)
