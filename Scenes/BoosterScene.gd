extends Node2D

func _ready():
	SignalManager.changed_scene.emit()

