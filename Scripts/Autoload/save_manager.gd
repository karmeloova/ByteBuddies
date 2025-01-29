extends Node
var save_game;
var save_path = "user://GameSave.save"

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
#MAM rysunek jest
var sleeping = {
	"name" : "sleeping",
	1 : false,
	10 : false,
	25 : false,
	50 : false,
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

var save_data = {
	"hungry" : 100,
	"play" : 100,
	"scratch" : 100,
	"sleep" : 100,
	"clean" : 100,
	"coins" : 0,
	"exp" : 0,
	"level" : 0,
	"snack_navigator_high_score" : 0,
	"cat_jump_high_score" : 0,
	"pet_code_high_score" : 0,
	"fruit_catcher_high_score" : 0,
	"cat_jump_achievementes" : cat_jump,
	"snack_navigator_achievementes" : snack_navigator,
	"fruit_catcher_achievementes" : fruit_catcher,
	"pet_code_achievementes" : pet_code,
	"eating_achievementes" : eating,
	"playing_games_achievementes" : playing_games,
	"scratching_achievementes" : scratching,
	"sleeping_achievementes" : sleeping,
	"cleaning_achievementes" : cleaning,
	"first_start" : true,
	"cat_name" : "",
	"fishes" : 0,
	"audio_volumes" : [1,1,1],
	"full_screen" : true,
	"resolution" : 0
}

# Called when the node enters the scene tree for the first time.
func _ready():
	if not FileAccess.file_exists(save_path) :
		create_save();
	read_data();
	# Wczytywanie zmiennych do gry
	VariableManager.needs["hungry"] = save_data["hungry"];
	VariableManager.needs["play"] = save_data["play"];
	VariableManager.needs["scratch"] = save_data["scratch"];
	VariableManager.needs["sleep"] = save_data["sleep"];
	VariableManager.needs["clean"] = save_data["clean"];
	VariableManager.coins = save_data["coins"];
	LevelManager.exp = save_data["exp"];
	LevelManager.level_number = save_data["level"]
	VariableManager.snack_navigator_high_score = save_data["snack_navigator_high_score"]
	VariableManager.cat_jump_high_score = save_data["cat_jump_high_score"]
	VariableManager.pet_code_high_score = save_data["pet_code_high_score"]
	VariableManager.fruit_catcher_high_score = save_data["fruit_catcher_high_score"]
	VariableManager.first_start = save_data["first_start"]
	VariableManager.cat_name = save_data["cat_name"]
	VariableManager.fishes = save_data["fishes"]
	VariableManager.volumes_levels = save_data["audio_volumes"]
	VariableManager.is_full_screen = save_data["full_screen"]
	VariableManager.resolution = save_data["resolution"]
	
	Achievements.cat_jump = save_data["cat_jump_achievementes"]
	Achievements.snack_navigator = save_data["snack_navigator_achievementes"]
	Achievements.fruit_catcher = save_data["fruit_catcher_achievementes"]
	Achievements.pet_code = save_data["pet_code_achievementes"]
	Achievements.eating = save_data["eating_achievementes"]
	Achievements.playing_games = save_data["playing_games_achievementes"]
	Achievements.scratching = save_data["scratching_achievementes"]
	Achievements.sleeping = save_data["sleeping_achievementes"]
	Achievements.cleaning = save_data["cleaning_achievementes"]
	
func create_save():
	# Otwieramy plik do zapisu
	save_game = FileAccess.open(save_path, FileAccess.WRITE);
	save_game.store_var(save_data); # Zapisujemy domyślne parametry
	save_game.close(); # Zamykamy plik
	
func read_data():
	save_game = FileAccess.open(save_path, FileAccess.READ);
	save_data = save_game.get_var(); # Pobieranie danych z pliku i przypisanie do słownika
	save_game.close();
	
func save(parametrName, parametr) :
	save_data[parametrName] = parametr;
	# Otwieramy plik do zapisu
	save_game = FileAccess.open(save_path, FileAccess.WRITE);
	save_game.store_var(save_data); # Zapisujemy domyślne parametry
	save_game.close(); # Zamykamy plik
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save("hungry", VariableManager.needs["hungry"]);
		save("play", VariableManager.needs["play"]);
		save("scratch", VariableManager.needs["scratch"]);
		save("sleep", VariableManager.needs["sleep"]);
		save("clean", VariableManager.needs["clean"]);
		save("coins", VariableManager.coins)
		save("exp", LevelManager.exp)
		save("level", LevelManager.level_number)
		save("snack_navigator_high_score", VariableManager.snack_navigator_high_score)
		save("cat_jump_high_score", VariableManager.cat_jump_high_score)
		save("pet_code_high_score", VariableManager.pet_code_high_score)
		save("fruit_catcher_high_score", VariableManager.fruit_catcher_high_score)
		save("cat_jump_achievementes", Achievements.cat_jump)
		save("snack_navigator_achievementes", Achievements.snack_navigator)
		save("fruit_catcher_achievementes", Achievements.fruit_catcher)
		save("pet_code_achievementes", Achievements.pet_code)
		save("eating_achievementes", Achievements.eating)
		save("playing_games_achievementes", Achievements.playing_games)
		save("scratching_achievementes", Achievements.scratching)
		save("sleeping_achievementes", Achievements.scratching)
		save("cleaning_achievementes", Achievements.cleaning)
		save("first_start", VariableManager.first_start)
		save("cat_name", VariableManager.cat_name)
		save("fishes", VariableManager.fishes)
		save("audio_volumes", VariableManager.volumes_levels)
		save("full_screen", VariableManager.is_full_screen)
		save("resolution", VariableManager.resolution)

#ścieżka do pliku - C:\Users\xxfea\AppData\Roaming\Godot\app_userdata\ByteBuddies
