extends Area2D
var speed = 200;
var what = 0;
var color = 0;
var fruitImage = 0;

var floatFruit = [load("res://Images/avocadoandhalf.png"), load("res://Images/coconutandhalf.png"), load("res://Images/cut_avocado.png"), load("res://Images/cut_coconut.png"), load("res://Images/cut_green_apple.png"), load("res://Images/cut_lemon.png"), load("res://Images/cut_orange.png"), load("res://Images/cut_pear.png"), load("res://Images/cut_red_apple.png"), load("res://Images/cut_strawberry.png"), load("res://Images/cut_watermelon.png"), load("res://Images/green_appleandhalf.png"), load("res://Images/lemonandhalf.png"), load("res://Images/orangeandhalf.png"), load("res://Images/peachandhalf.png"), load("res://Images/pearandhalf.png"), load("res://Images/red_appleandhalf.png"), load("res://Images/strawberryandhalf.png"), load("res://Images/watermelonandhalf.png")]
var intFruit = [load("res://Images/avocado.png"), load("res://Images/bananas.png"), load("res://Images/cherry.png"), load("res://Images/coconut.png"), load("res://Images/grapes.png"), load("res://Images/green_apple.png"), load("res://Images/lemon.png"), load("res://Images/orange.png"), load("res://Images/peach.png"), load("res://Images/pear.png"), load("res://Images/red_apple.png"), load("res://Images/strawberry.png"), load("res://Images/watermelon.png")]
var stringFruit = ["Awokado", "Banan", "Wiśnia", "Kokos", "Winogrona", "Jabłko", "Cytryna", "Pomarańcza", "Brzoskwinia", "Gruszka", "Truskawka", "Arbuz"]
var charFruit = ["jablko==banan", "wisna==wisna", "kokos==winogrona", "jablko!=cytryna", "winogorno<jablko", "brzoskwinia==gruszka", "arbuz==jablko", "arbuz>jablko", "truskawka!=pomarancza", "winogrono!=jablko"]

# Called when the node enters the scene tree for the first time.
func _ready():
	color = randi_range(0,3)
	match color:
		0: 
			fruitImage = randi_range(0, floatFruit.size()-1);
			$FruitSprite.texture = floatFruit[fruitImage];
			$CollisionShape2D.shape.size = Vector2(floatFruit[fruitImage].get_size().x, 75)
		1: 
			fruitImage = randi_range(0, intFruit.size()-1);
			$FruitSprite.texture = intFruit[fruitImage]; 
			$CollisionShape2D.shape.size = Vector2(intFruit[fruitImage].get_size().x, 75)
		2: 
			$Label.text = stringFruit[randi_range(0,stringFruit.size()-1)]
		3: 
			$Label.text = charFruit[randi_range(0,charFruit.size()-1)]
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += speed*delta;

func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	match area.name :
		"Basket": what = 0; #Kolizja z koszykiem (graczem)
		"Floor": what = 1; #Kolizja z podłogą (gracz nie zdążył)
	SignalManager.fruitColor.emit(color);
	SignalManager.fruitColl.emit(what);
	queue_free();
