extends Button

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
func _on_mouse_entered() :
	modulate = Color("b2b2b2")

func _on_mouse_exited() :
	modulate = Color("ffffff")
