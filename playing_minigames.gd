extends Node

func _ready():
	var play_timer = Timer.new()
	play_timer.set_wait_time(1.0)
	play_timer.set_one_shot(false)
	play_timer.connect("timeout", _on_timeout)
	add_child(play_timer)
	play_timer.start()

func _on_timeout():
	if(VariableManager.is_playing) :
		SignalManager.playing.emit()
