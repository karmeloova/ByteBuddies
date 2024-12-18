extends Node2D
var dir = 1;
var timer = null;
var eat_timer = null;
var sleeping_timer = null;
var cleaning_timer = null
var eat_count : int = 0

func _ready():
	SignalManager.scratch.connect(_on_scratch);
	SignalManager.eat.connect(_on_eat)
	SignalManager.playing.connect(_on_playing)
	SignalManager.sleeping.connect(_on_sleeping)
	SignalManager.cleaning.connect(_on_cleaning)
	
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
	
	sleeping_timer = Timer.new()
	sleeping_timer.set_wait_time(2)
	sleeping_timer.set_autostart(false)
	sleeping_timer.set_one_shot(false)
	sleeping_timer.connect("timeout", _on_sleeping_timer_timeout)
	add_child(sleeping_timer)
	
	cleaning_timer = Timer.new()
	cleaning_timer.set_wait_time(0.2)
	cleaning_timer.set_autostart(false)
	cleaning_timer.set_one_shot(false)
	cleaning_timer.connect("timeout", _on_cleaning_timer_timeout)
	add_child(cleaning_timer)
	
func _on_timeout() :
	for i in VariableManager.needs :
		if(VariableManager.needs[i] > 0) : VariableManager.needs[i] -= 1;
	SignalManager.changed_needs.emit();

func _on_scratch(_howMany) :
	if(VariableManager.needs["scratch"] < 100) : VariableManager.needs["scratch"] += 5;
	SignalManager.changed_needs.emit();

func _on_eat() :
	eat_timer.start()

func _on_eat_timer_timeout() :
	if(VariableManager.needs["hungry"] < 100 and VariableManager.hungry_points_in_bowl > 0) : 
		VariableManager.needs["hungry"] += 5
		VariableManager.hungry_points_in_bowl -= 1
		SignalManager.changed_needs.emit()
		eat_timer.start()
	else : 
		eat_timer.stop()
		SignalManager.eat_end.emit()
	
func _on_playing() :
	if(VariableManager.needs["play"] < 100) :
		VariableManager.needs["play"] += 5
		SignalManager.changed_needs.emit()

func _on_sleeping(state) :
	if(state) :
		sleeping_timer.start()
	else :
		sleeping_timer.stop()
		sleeping_timer.set_wait_time(2)

func _on_sleeping_timer_timeout() :
	if(VariableManager.needs["sleep"] < 100) :
		VariableManager.needs["sleep"] += 10
		SignalManager.changed_needs.emit()

func _on_cleaning(state) :
	if(state) :
		cleaning_timer.start()
	else :
		cleaning_timer.stop()
		cleaning_timer.set_wait_time(0.2)
		
func _on_cleaning_timer_timeout() :
	if(VariableManager.needs["clean"] < 100) :
		VariableManager.needs["clean"] += 1
		SignalManager.changed_needs.emit()
