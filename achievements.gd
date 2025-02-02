extends Node
#MAM rysunek jest
var cat_jump = {
	"name" : "cat_jump",
	20 : false,
	50 : false,
	100 : false,
	200: false,
	300: false
}
#MAM rysunek jest
var snack_navigator = {
	"name" : "snack_navigator",
	100 : false,
	250 : false,
	400 : false,
	550 : false,
	700 : false
}
#MAM rysunek jest
var fruit_catcher = {
	"name" : "fruit_catcher",
	25 : false,
	50 : false,
	100 : false,
	150 : false,
	200 : false
}
#MAM rysunek jest
var pet_code = {
	"name" : "pet_code",
	30 : false,
	60 : false,
	100 : false,
	150 : false,
	200 : false
}
#MAM rysunek jest
var eating = {
	"name" : "eating",
	1 : false,
	10 : false,
	25 : false,
	50 : false,
	75 : false
}
#MAM rysunek jest 
var playing_games = {
	"name" : "playing_games",
	1 : false,
	10 : false,
	25 : false,
	50 : false,
	75 : false
}
#MAM rysunek jest
var scratching = {
	"name" : "scratching",
	1 : false,
	10 : false,
	25 : false,
	50 : false,
	75 : false
}
#MAM rysunek jestS
var sleeping = {
	"name" : "sleeping",
	1 : false,
	10 : false,
	25 : false,
	75 : false
}

#MAM rysunek jest
var cleaning = {
	"name" : "cleaning",
	1 : false,
	10 : false,
	25 : false,
	50 : false,
	75 : false
}

var category_tab : Array
var unlocked_achievements : Dictionary
var unlocked_achievements_during_game : bool
var cam

var money_prizes = [0, 50, 100, 150, 200, 250]
var ach_numbers = [0, 1, 2, 3, 4, 5]
var money : Array[int]
var numbers : Array[int]

func _ready():
	SignalManager.unlock_achievement.connect(_on_unlock_achievement)
	SignalManager.loseGame.connect(_on_lose_game)
	
	category_tab.append(sleeping)
	category_tab.append(cat_jump)
	category_tab.append(snack_navigator)
	category_tab.append(fruit_catcher)
	category_tab.append(pet_code)
	category_tab.append(eating)
	category_tab.append(playing_games)
	category_tab.append(scratching)
	category_tab.append(cleaning)
	
func _on_unlock_achievement(points, category : String, camera) :
	for cat in category_tab:
		if(category == cat["name"]) :
			check_achievements(cat, points, camera)

func check_achievements(category, points, camera) :
	var index : int = 0;
	for points_to_unlock in category :
		if(index > 0) :
			if(points_to_unlock <= points && category[points_to_unlock] != true) :
				var str = category["name"] + str(index)
				VariableManager.coins += money_prizes[index]
				SignalManager.change_money.emit()
				money.append(money_prizes[index])
				numbers.append(ach_numbers[index])
				unlocked_achievements[str] = points_to_unlock
				category[points_to_unlock] = true;
		index += 1
	if(unlocked_achievements.size() > 0) : SignalManager.check_achievements_unlocked.emit()
	call_deferred("test_playing_game",camera)

func _on_lose_game() :
	if(unlocked_achievements_during_game && unlocked_achievements.size() > 0) :
		SignalManager.show_achievement_screen.emit(cam, unlocked_achievements, money, numbers)
		unlocked_achievements_during_game = false

func test_playing_game(camera) :
	if(unlocked_achievements.size() > 0 && !VariableManager.is_playing) :
		if(unlocked_achievements_during_game) : unlocked_achievements_during_game = false
		SignalManager.show_achievement_screen.emit(camera, unlocked_achievements, money, numbers)
	else :
		unlocked_achievements_during_game = true
		cam = camera

func clear_achievmentes() :
	unlocked_achievements.clear()
