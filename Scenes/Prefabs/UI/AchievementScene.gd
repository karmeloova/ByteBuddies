extends Node2D
var index = 0
var start_pos
var achievements;
var money_prizes
var achievements_numbers;

var achievements_colors = [Color("ffffff"), Color("569DAA"), Color("E76F51"), Color("8A9A5B"), Color("855C9C"), Color("DDA448")]

var achievements_cloros_dic = {
	0 : achievements_colors[0],
	1 : achievements_colors[1],
	2 : achievements_colors[2],
	3 : achievements_colors[3],
	4 : achievements_colors[4],
	5 : achievements_colors[5]
}

var achievements_images = [load("res://Images/UI/Achievmentes/CatJump.png"), 
load("res://Images/UI/Achievmentes/SnackNavigator.png"), 
load("res://Images/UI/Achievmentes/FruitCatcher.png"),
load("res://Images/UI/Achievmentes/CodePet.png"), load("res://Images/UI/Achievmentes/Eating.png"),
load("res://Images/UI/Achievmentes/Playing_minigames.png"), load("res://Images/UI/Achievmentes/Scratching.png"),
load("res://Images/UI/Achievmentes/Sleeping.png"), load("res://Images/UI/Achievmentes/Cleaning.png")]

var achievements_images_dic = {
	"cat_jump" : achievements_images[0],
	"snack_navigator" : achievements_images[1],
	"fruit_catcher" : achievements_images[2],
	"pet_code" : achievements_images[3],
	"eating" : achievements_images[4],
	"playing_games" : achievements_images[5],
	"scratching": achievements_images[6],
	"sleeping" : achievements_images[7],
	"cleaning" : achievements_images[8]
}

func _ready():
	visible = false
	start_pos = position
	SignalManager.show_achievement_screen.connect(_on_show_achievement_screen)
	SignalManager.reoder_child.connect(_on_reorder_child)

func _on_show_achievement_screen(camera, unlocked_achievmentes, money, numbers) :
	achievements = unlocked_achievmentes;
	index = achievements.size() - 1
	money_prizes = money
	achievements_numbers = numbers
	find_achievement(achievements)
	var screen_size = get_viewport().size
	if(camera != null) : position = Vector2(camera.position.x-screen_size.x/2+10, camera.position.y-screen_size.y+35)
	else : position = start_pos
	visible = true;

func _on_button_pressed():
	index -= 1
	if(index < 0) :
		visible = false
		Achievements.clear_achievmentes()
	else :
		find_achievement(achievements)

func _on_button_mouse_entered():
	$Exit.modulate = Color("b2b2b2")

func _on_button_mouse_exited():
	$Exit.modulate = Color("ffffff")

func find_achievement(unlocked_achievmentes) :
	var loop_ind = 0;
	for key in unlocked_achievmentes :
		if(loop_ind == index) :
			set_new_achievement(key, unlocked_achievmentes[key], money_prizes[index], achievements_numbers[index])
			break
		else : loop_ind += 1

func set_new_achievement(key, value, prize, number) :
	for i in key.length() :
		if(key[i] == "0" || key[i]=="1" || key[i] == "2" || key[i]=="3" || key[i]=="4" || key[i]=="5" || key[i]=="6" || key[i]=="7" || key[i]=="8" || key[i]=="9" ) :
			key[i] = ""
	$AchievementImage/Label.text = str(value)
	$AchievementImage/AchievementImage.texture = achievements_images_dic[key]
	$AchievementImage.modulate = achievements_cloros_dic[number]
	$MoneyText.text = str(prize)

func _on_reorder_child() :
	call_deferred("reorder")
	
func reorder() :
	get_parent().move_child(self, get_parent().get_child_count() - 1)
