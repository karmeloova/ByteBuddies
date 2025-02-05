extends Area2D

func _on_area_entered(area):
	SignalManager.add_coin.emit(1)
	SignalManager.play_sfx.emit(load("res://Audio/Money.mp3"))
	queue_free()
