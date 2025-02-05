extends Control
var i = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	show_tutorial()

func _on_button_pressed():
	self.get_child(i).visible = false
	i += 1
	if(self.get_child_count() > i) :
		self.get_child(i).visible = true
	else :
		VariableManager.tutorial = false
		if(VariableManager.cat_name.length() < 1) : get_parent().set_cat_name()
		else: get_tree().paused = false

func _on_skip_button_pressed():
	VariableManager.tutorial = false
	
	for i in self.get_children():
		i.visible = false
	
	if(VariableManager.cat_name.length() < 1) :
		get_parent().set_cat_name()
	else :
		get_tree().paused = false

func show_tutorial() :
	if(VariableManager.tutorial) :
		i = 0
		visible = true
		get_tree().paused = true
		self.get_child(0).visible = true
	else :
		for i in self.get_children():
			i.visible = false
