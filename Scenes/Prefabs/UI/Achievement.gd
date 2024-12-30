extends Node2D

enum AchievementsCat {cat_jump, snack_navigator, fruit_catcher, pet_code, eating, playing_games,
scratching, sleeping, cleaning}

enum AchievementNumber {first, second, third, fourth, fifth}

var achievements_names = {
	AchievementsCat.cat_jump: "cat_jump",
	AchievementsCat.snack_navigator: "snack_navigator",
	AchievementsCat.fruit_catcher: "fruit_catcher",
	AchievementsCat.pet_code: "pet_code",
	AchievementsCat.eating: "eating",
	AchievementsCat.playing_games: "playing_games",
	AchievementsCat.scratching: "scratching",
	AchievementsCat.sleeping: "sleeping",
	AchievementsCat.cleaning: "cleaning"
}

var achievements_colors = [Color("569DAA"), Color("E76F51"), Color("8A9A5B"), Color("855C9C"), Color("DDA448")]


var achievements_images = [load("res://Images/UI/Achievmentes/CatJump.png"), load("res://Images/UI/Achievmentes/SnackNavigator.png"), load("res://Images/UI/Achievmentes/FruitCatcher.png"),
load("res://Images/UI/Achievmentes/CodePet.png"), load("res://Images/UI/Achievmentes/Eating.png"),
load("res://Images/UI/Achievmentes/Playing_minigames.png"), load("res://Images/UI/Achievmentes/Scratching.png"),
load("res://Images/UI/Achievmentes/Sleeping.png"), load("res://Images/UI/Achievmentes/Cleaning.png")]

var is_unlocked : bool = false
@export var how_many_points : int
@export var achivement_category : AchievementsCat = AchievementsCat.cat_jump
@export var achievement_number : AchievementNumber = AchievementNumber.first
var categories

# Called when the node enters the scene tree for the first time.
func _ready():
	categories = Achievements.category_tab
	SignalManager.check_achievements_unlocked.connect(is_achievement_unlocked)
	$AchievementImage.texture = achievements_images[achivement_category]
	is_achievement_unlocked()
	$Label.text = str(how_many_points)

func is_achievement_unlocked() :
	for cat in categories :
		if(cat["name"] == achievements_names[achivement_category]) :
			if(cat[how_many_points] == true) :
				$Lock.visible = false
				set_colors()

func set_colors() :
	$AchievementImage.modulate = achievements_colors[achievement_number]
	$Frame.modulate = achievements_colors[achievement_number]
	$Label.modulate = achievements_colors[achievement_number]
