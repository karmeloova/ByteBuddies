extends Area2D

func _on_area_entered(area):
	SignalManager.add_coin.emit(1)
	queue_free()
