extends Area2D
@export var need_name : String
@export var need_label : Label

func _ready():
	SignalManager.changed_needs.connect(_on_changed_needs)

func _on_mouse_entered():
	need_label.text = str(VariableManager.needs[need_name]) + "%"
	need_label.visible = true

func _on_mouse_exited():
	need_label.visible = false

func _on_changed_needs():
	need_label.text = str(VariableManager.needs[need_name]) + "%"
