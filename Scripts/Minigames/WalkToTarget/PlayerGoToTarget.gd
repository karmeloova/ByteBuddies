extends Area2D
var start_position;
var coll = 0;
var tween;
var instructions_tab = [];
var steps_counter = 0
var moved = false;
var game_pause;

# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = position
	position = VariableManager.start_position
	
	SignalManager.restartGame.connect(_on_restart_game_)
	SignalManager.stopGame.connect(_on_stop_game)
	SignalManager.startGameAfterPause.connect(_on_start_game_after_pause)
	SignalManager.makeMove.connect(_on_make_move)

func _on_make_move(tab_of_instructions) :
	instructions_tab = tab_of_instructions;
	moved = true;
	$TweenWaiter.start(0.01);

func _on_restart_game_():
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
	if(steps_counter > coll and not(game_pause)) : 
		$TweenWaiter.stop();
		$RestartWaiter.start(1);
		print("Steps: ", steps_counter, " Coll: ", coll)
		print("Zle poszedles mordo")

func _on_coll_waiter_timeout():
	checkColl()

func _on_restart_waiter_timeout():
	SignalManager.loseLife.emit();
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

func _on_stop_game() :
	if(moved) :
		$TweenWaiter.stop();
		tween.pause();
	game_pause = true;

func _on_start_game_after_pause():
	if(moved) :
		$TweenWaiter.start();
		print($TweenWaiter.time_left);
		tween.play();
	game_pause = false;
