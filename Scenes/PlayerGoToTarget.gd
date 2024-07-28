extends Area2D
var start_position;
var coll = 0;
var tween;
var instructions_tab = [];
var steps_counter = 0
var moved = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = position
	position = VariableManager.start_position
	
	SignalManager.go_forward.connect(_on_go_forward);
	SignalManager.go_right.connect(_on_go_right);
	SignalManager.go_left.connect(_on_go_left);
	SignalManager.restart_button.connect(_on_restart_button_)
	SignalManager.end_code.connect(_on_end_code)

func _on_go_forward(steps) :
	for i in range(steps) :
		instructions_tab.append("forward");
	
func _on_go_right(steps) :
	for i in range(steps) :
		instructions_tab.append("right");

func _on_go_left(steps) :
	for i in range(steps) :
		instructions_tab.append("left");

func _on_end_code() :
	moved = true;
	$TweenWaiter.start(0.01);

func _on_restart_button_():
	restart();

func _on_tween_waiter_timeout():
	if(steps_counter < instructions_tab.size()) :
		tween = create_tween()
		if(instructions_tab[steps_counter] == "forward") :
			tween.tween_property($".", "position", Vector2(position.x, 
			position.y - VariableManager.tile_size.y), 0.25)
			$TweenWaiter.start(0.25)
		if(instructions_tab[steps_counter] == "right") :
			tween.tween_property($".", "position", Vector2(position.x + 
			VariableManager.tile_size.x, position.y), 0.25)
			$TweenWaiter.start(0.25)
		if(instructions_tab[steps_counter] == "left") :
			tween.tween_property($".", "position", Vector2(position.x - 
			VariableManager.tile_size.x, position.y), 0.25)
			$TweenWaiter.start(0.25)
		$CollWaiter.start(0.15)
		steps_counter += 1;
	else : 
		coll = 0;
		steps_counter = 0;
		instructions_tab = [];
		SignalManager.moveEnd.emit();

func _on_area_entered(area):
	if(moved) : coll += 1;
	if(area.name.contains("Last_tile")) : 
		print("Gratki, doszedłeś do końca!")
		$NextLevelWaiter.start(1);

func checkColl() :
	if(steps_counter > coll) : 
		$TweenWaiter.stop();
		$RestartWaiter.start(1);
		SignalManager.loseLife.emit();
		print("Zle poszedles mordo")

func _on_coll_waiter_timeout():
	checkColl()

func _on_restart_waiter_timeout():
	restart();

func restart() :
	position = VariableManager.start_position;
	coll = 0;
	instructions_tab = [];
	steps_counter = 0
	moved = false;

func _on_next_level_waiter_timeout():
	SignalManager.nextLevel.emit();
	restart();
