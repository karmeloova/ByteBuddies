extends Node2D
var fruit = preload("res://fruits.tscn");
@onready var world = get_node("/root/World/FruitNode");
var howMany = 0;
var lose = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.fruitColl.connect(_on_fruitColl);
	$FruitTimer.start(2);

func _on_fruit_timer_timeout():
	var fruitinstance = fruit.instantiate();
	if(howMany < 5) :
		world.add_child(fruitinstance);
		fruitinstance.position.x = randi_range(0, 1000);
		howMany += 1;
	$FruitTimer.start(2);

func _on_fruitColl(what) :
	howMany -= 1;
	if(what==0) : SignalManager.add_point.emit();
	if(what==1) : SignalManager.loseLife.emit(); #W momencie zderzenia z podłogą gracz traci życie
