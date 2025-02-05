extends Control
var i = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if(VariableManager.tutorial) :
		visible = true
		get_tree().paused = true
	else :
		visible = false

func _on_button_pressed():
	self.get_child(i).visible = false
	i += 1
	if(self.get_child_count() > i) :
		self.get_child(i).visible = true
	else :
		VariableManager.tutorial = false
		get_parent().set_cat_name()
