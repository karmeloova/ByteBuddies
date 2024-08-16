extends Control

func _on_add_to_bowl_pressed():
	
	SignalManager.add_to_bowl.emit($HungryPoints.text)
	SignalManager.remove_from_fridge.emit($Name.text)
