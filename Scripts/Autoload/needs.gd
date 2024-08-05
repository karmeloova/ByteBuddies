extends Node2D
var dir = 1;
var timer = null;
var necessities = {
	"hungry" : 0,
	"play" : 0,
	"scratch" : 0,
	"sleep" : 0,
	"clean" : 0
}


# Called when the node enters the scene tree for the first time.
func _ready():
	
	SignalManager.scratch.connect(_on_scratch);
	
	timer = Timer.new();
	timer.set_wait_time(1.0)
	timer.set_one_shot(false)
	timer.connect("timeout", _on_timeout)
	add_child(timer)
	timer.start()
	
func _on_timeout() :
	for i in VariableManager.needs :
		if(VariableManager.needs[i] < 100) : VariableManager.needs[i] += 5;
	SignalManager.changed_needs.emit();

func _on_scratch(howMany) :
	if(VariableManager.needs["scratch"] > 0) : VariableManager.needs["scratch"] -= 5;
	SignalManager.changed_needs.emit();
