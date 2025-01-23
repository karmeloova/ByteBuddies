extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.show_description.connect(_on_show_description)
	SignalManager.hide_description.connect(_on_hide_desription)
	
func _on_show_description(desc):
	text = desc
	visible = true
	
func _on_hide_desription() :
	visible = false
