extends Node2D
var dir = 1;
var timer = null;
var eat_timer = null;
var eat_count : int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	
	SignalManager.scratch.connect(_on_scratch);
	SignalManager.eat.connect(_on_eat)
	
	timer = Timer.new();
	timer.set_wait_time(5.0)
	timer.set_one_shot(false)
	timer.connect("timeout", _on_timeout)
	add_child(timer)
	timer.start()
	
	eat_timer = Timer.new()
	eat_timer.set_wait_time(0.5)
	eat_timer.set_autostart(false)
	eat_timer.set_one_shot(true)
	eat_timer.connect("timeout", _on_eat_timer_timeout)
	add_child(eat_timer)
	
func _on_timeout() :
	for i in VariableManager.needs :
		if(VariableManager.needs[i] > 0) : VariableManager.needs[i] -= 1;
	SignalManager.changed_needs.emit();

func _on_scratch(howMany) :
	if(VariableManager.needs["scratch"] < 100) : VariableManager.needs["scratch"] += 5;
	SignalManager.changed_needs.emit();

func _on_eat() :
	print("XDDDDD")
	eat_timer.start()

func _on_eat_timer_timeout() :
	if(VariableManager.needs["hungry"] < 100 and VariableManager.hungry_points_in_bowl > 0) : 
		print("jem")
		VariableManager.needs["hungry"] += 5
		VariableManager.hungry_points_in_bowl -= 1
		SignalManager.changed_needs.emit()
		eat_timer.start()
	else : 
		eat_timer.stop()
	
