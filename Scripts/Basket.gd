extends Area2D
var speed = 400;
var color = 0;
var isCollLeft = false
var isCollRight = false

var baskets = [load("res://Images/basket.png"), load("res://Images/basket2.png"), load("res://Images/basket3.png"), load("res://Images/basket4.png")]

func _process(delta):
	if(Input.is_action_pressed("ui_right") and not(isCollRight) and not(Input.is_action_pressed("ui_left"))) : 
		position.x += speed*delta;
		if(isCollLeft) : isCollLeft = false;
	if(Input.is_action_pressed("ui_left") and not(isCollLeft) and not(Input.is_action_pressed("ui_right"))) : 
		position.x -= speed*delta;
		if(isCollRight) : isCollRight = false; #warunek, który mówi o tym, że dotknęliśmy ściany i skoro chcemy poruszać się w drugą stronę to musimy uaktywnić opcje poruszania się
	
	match color:
		0: 
			$BasketPicture.texture = baskets[0]
			$Label.text = "float, double"
		1: 
			$BasketPicture.texture = baskets[1]
			$Label.text = "int"
		2: 
			$BasketPicture.texture = baskets[2]
			$Label.text = "string"
		3: 
			$BasketPicture.texture = baskets[3]
			$Label.text = "Char"

func _input(event):
	if(Input.is_key_pressed(KEY_1)) : color = 0;
	if(Input.is_key_pressed(KEY_2)) : color = 1;
	if(Input.is_key_pressed(KEY_3)) : color = 2;
	if(Input.is_key_pressed(KEY_4)) : color = 3;
	SignalManager.basketColor.emit(color)

func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if(area.name == "Left") : isCollLeft = true;
	if(area.name == "Right") : isCollRight = true;

