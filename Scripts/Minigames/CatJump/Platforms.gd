extends Node2D
@onready var platforms_node = self;

var Platform = preload("res://Scenes/Prefabs/Platform.tscn");

var platform_instance;

var platform_size
var player_size;
var y_distance;
var last_position = Vector2(0,0)
var random_x_position: int = 0
var margin: int = 50;
var direction: int = 0;
var count_platforms : int = 0
var generated : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	player_size = VariableManager.player_size
	y_distance = 150-player_size/2
	
	platform_instance = Platform.instantiate();
	platforms_node.add_child(platform_instance);
	platform_size = VariableManager.platform_size
	random_x_position = randi_range(margin+platform_size/2, 1152-platform_size/2-margin)
	
	platform_instance.position = Vector2(random_x_position, 598-y_distance)
	last_position = platform_instance.position;
	platform_size = VariableManager.platform_size
	
	SignalManager.add_platform.connect(_on_add_platform)
	
	generate_board();

func generate_board() -> void:
	while count_platforms < 5 :
		# Losujemy po której stronie ma się pojawić platforma 
		if(generate_platform()) :
			count_platforms += 1
		if(count_platforms % 3 == 0) : 
			SignalManager.generate_coin.emit(last_position, platform_size)

func _on_add_platform() -> void:
	generated = false
	while not generated :
		if(generate_platform()) :
			count_platforms += 1
			generated = true;
	if(count_platforms % 3 == 0) : SignalManager.generate_coin.emit(last_position, platform_size)
	
func generate_platform() -> bool:
	direction = randi_range(0,1)
	match direction :
		0: random_x_position = randi_range(-platform_size/2, -325 - platform_size/2)
		1: random_x_position = randi_range(platform_size/2, 325+platform_size/2)
		
	if((last_position.x + random_x_position - platform_size > 0 and direction == 0)
	or (last_position.x + random_x_position + platform_size < 1152 and direction == 1)) :
		platform_instance = Platform.instantiate()
		platforms_node.call_deferred("add_child", platform_instance)
		platform_size = VariableManager.platform_size
		
		platform_instance.position = Vector2(last_position.x+random_x_position,
									 last_position.y - y_distance)
									
		last_position = platform_instance.position;
		return true
	return false


