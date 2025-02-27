extends Node2D

var possible_directions = [-2, -1, 1, 2];
var last_direction = 0;
var last_position;
var tile_size;
var tile_instance
var positions_tab = [];
var start_positions = []
var neightbours = 0;
var how_many_tiles;
var tiles_counter = 1;
var zakrety = 0;
var diiir = 0

var end = false;
var first = true;

var niebedeliczyl = 0;
var czy_bylo_zero = false;
var first_pos

var tile = preload("res://Scenes/Prefabs/Tiles.tscn");
@onready var world = get_node("/root/WalkToTarget/Board")

# Called when the node enters the scene tree for the first time.
func _ready():
	VariableManager.level_counter = 1
	generateBoard();
	SignalManager.nextLevel.connect(_on_next_level)

func generateBoard() :
	tile_instance = tile.instantiate();
	world.add_child(tile_instance)
	
	tile_size = VariableManager.tile_size
	start_positions.append(503+tile_size.x/2)
	for i in range(1,8) :
		start_positions.append(start_positions[i-1] + tile_size.x)
		
	tile_instance.position.y = 650-tile_size.y/2;
	tile_instance.position.x = start_positions.pick_random()
	last_position = Vector2(tile_instance.position.x, tile_instance.position.y)
	first_pos = Vector2(tile_instance.position.x, tile_instance.position.y);
	VariableManager.start_position = first_pos
	positions_tab.append(last_position);
	
	if(VariableManager.level_counter < 4) :
		how_many_tiles = randi_range(5,8)
	elif(VariableManager.level_counter >= 4 and VariableManager.level_counter < 7) :
		how_many_tiles = randi_range(9, 12)
	else :
		how_many_tiles = randi_range(13, 16)
	
	VariableManager.tiles_counter = how_many_tiles;
	
	# Generowanie planszy do momentu, gdy nie będziemy przy krańcu ekranu 
	while(tiles_counter < how_many_tiles) :
		if(first) : 
			last_direction = 2;
		else : 
			if(czy_bylo_zero) : 
				for i in range(4) :
					if(possible_directions[i] != 0) : last_direction = possible_directions[i];
				czy_bylo_zero = false;
			else : last_direction = random_direction(possible_directions)
		first = false;
		match last_direction :
			-2 : 
				if(last_position.y + tile_size.y < 650-tile_size.y/2+1) :
					if(test_tile(Vector2(last_position.x, last_position.y + tile_size.y))) :
						generate_tile(last_direction)
						possible_directions = [-2, -1, 1, 0]
					else :
						if(possible_directions[0] != 0 ) : possible_directions[0] = 0;
				else :
					if(possible_directions[0] != 0 ) : possible_directions[0] = 0;

			-1 : 
				if(last_position.x - tile_size.x > 430+tile_size.x/2) :
					if(test_tile(Vector2(last_position.x - tile_size.x, last_position.y))) :
						generate_tile(last_direction)
						possible_directions = [-2, -1, 0, 2]
					else : 
						if(possible_directions[1] != 0 ) : possible_directions[1] = 0;
				else : 
					if(possible_directions[1] != 0 ) : possible_directions[1] = 0;

			1 : 
				if(last_position.x + tile_size.x < 1150-tile_size.x/2) :
					if(test_tile(Vector2(last_position.x + tile_size.x, last_position.y))) :
						generate_tile(last_direction)
						possible_directions = [-2, 0, 1, 2]
					else : 
						if(possible_directions[2] != 0 ) : possible_directions[2] = 0;
				else : 
					if(possible_directions[2] != 0 ) : possible_directions[2] = 0;

			2 : 
				if(last_position.y - tile_size.y > 0+tile_size.y/2) :
					if(test_tile(Vector2(last_position.x, last_position.y - tile_size.y))) :
						end = false;
						generate_tile(last_direction)
						possible_directions = [0, -1, 1, 2]
					else :
						if(possible_directions[3] != 0 ) : possible_directions[3] = 0
				else :
					end = true;
					if(possible_directions[3] != 0 ) : possible_directions[3] = 0;

			0 :
				czy_bylo_zero = true;
				for i in range(possible_directions.size()) :
					if(possible_directions[i] == 0) : niebedeliczyl += 1;
				if(niebedeliczyl == 4) : 
					generate_board_again()
					break;
				else : niebedeliczyl = 0; 

	tile_instance.name = "Last_tile";
	$"../Bowl".position = last_position
	
func random_direction(directions) :
	var random_index = randi() % directions.size();
	return directions[random_index];

# Funkcja służąca do generowania kolejnych płytek w zależności od wylosowanego
# miejsca
func generate_tile(last_direction) :
	if((diiir==1 || diiir==-1) && (last_direction==-2 || last_direction == 2)) :
		zakrety+=1;
	elif((diiir==2 || diiir==-2) && (last_direction==-1 || last_direction == 1)) :
		zakrety+=1; 
	
	tile_instance = tile.instantiate();
	world.add_child(tile_instance)
	
	match last_direction :
		-2 : tile_instance.position = Vector2(last_position.x, last_position.y + tile_size.y)
		-1 : tile_instance.position = Vector2(last_position.x - tile_size.x, last_position.y)
		1 : tile_instance.position = Vector2(last_position.x + tile_size.x, last_position.y)
		2 : tile_instance.position = Vector2(last_position.x, last_position.y - tile_size.y)
	last_position = Vector2(tile_instance.position.x, tile_instance.position.y)
	positions_tab.append(last_position);
	tiles_counter += 1
	diiir = last_direction

# Sprawdzamy sąsiadów dodając do obecnej pozycji odpowiednie wartości
func test_tile(position) :
	neightbours = 0;
	for i in range(positions_tab.size()) :
		# Prawo
		if(Vector2((position.x + tile_size.x), position.y) == positions_tab[i]) :
			neightbours += 1;
		# Lewo
		if(Vector2((position.x - tile_size.x), position.y) == positions_tab[i]) :
			neightbours += 1;
		# Góra
		if(Vector2(position.x, (position.y-tile_size.y)) == positions_tab[i]) :
			neightbours += 1;
		# Dół 
		if(Vector2(position.x, (position.y+tile_size.y)) == positions_tab[i]) :
			neightbours += 1;
	# Jeżeli jest jeden sąsiad to możemy wygenerować płytkę, w przeciwnym razie 
	# należy wylosować pozycję jeszcze raz
	if(neightbours == 1) : return true;
	else : return false;

# Ponowne generowanie planszy
func generate_board_again() :
	# Usuwamy poprzednie płytki
	for i in world.get_children() :
		if(i.name != "Bowl") : i.queue_free();
	# Czyścimy zmienne
	end = false;
	positions_tab.clear();
	czy_bylo_zero = false;
	first = true;
	niebedeliczyl = 0;
	tiles_counter = 1
	zakrety = 0
	# Generujemy ponownie planszę
	generateBoard();

# W przypadku gdy gracz przejdzie do kolejnego poziomu, generujemy nową planszę
func _on_next_level() :
	if(VariableManager.level_counter < 4) :
		SignalManager.add_coin.emit(5)
	elif(VariableManager.level_counter >= 4 and VariableManager.level_counter < 7) :
		SignalManager.add_coin.emit(10)
	else :
		SignalManager.add_coin.emit(15)
	
	if(VariableManager.level_counter%3==0) :
		SignalManager.add_fishes.emit()
	
	VariableManager.level_counter += 1
	SignalManager.calculate_score.emit(zakrety)
	generate_board_again()

# W przypadku gdy gracz chce zrestować grę (zagraj ponownie/restart) również
# generujemy nową planszę
