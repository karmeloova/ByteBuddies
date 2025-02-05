extends Node

var needs = {
	"hungry" : 0,
	"play" : 0,
	"scratch" : 0,
	"sleep" : 0,
	"clean" : 0
}

var food_list : Array[Food_Resource]
var first_start : bool = true
var cat_name : String
var tutorial : bool = true

var is_playing : bool = false
var is_mouse_moving = false

var hungry_points_in_bowl : int = 0
var code_pet_start_pos : Vector2
var code_pet_score : int = 0

var tile_size;
var start_position;
var level_counter = 1;
var lines_couner = 0;
var tiles_counter = 0;
var execute_counter = 0;

var code;

var coins : int = 0
var fishes : int = 0

var is_soap_on_cat = false

#------------- MINI-GAMES ---------------

#------------- CAT JUMP ----------------

var platform_size
var player_size
var moved : bool = false
var camerapos = Vector2.ZERO

#------------- SHOP ------------------

var food_item : Food_Resource

#------------- LEVEL -----------------
var current_exp : int = 0
var can_be_promoted : bool = true

#----------- HIGH-SCORES ------------
var snack_navigator_high_score : int = 0
var cat_jump_high_score : int = 0
var pet_code_high_score : int = 0
var fruit_catcher_high_score : int = 0

#--------- ANIMAL NEEDS COUNTERS -------------
var eat_counter : int = 0
var play_counter : int = 0
var sleep_counter : int = 0
var clean_counter : int = 0
var scratch_counter : int = 0

#-------- SETTINGS ---------------------------
var volumes_levels = [1,1,1]
var resolution = 0
var is_full_screen = true
var mute_check_boxes = [false, false, false]

#----------- RESOURCES -----------------------
var food_resource : Array[storage_resource]
var plans_resource : Array[storage_resource]
var parts_resource : Array[storage_resource]

var current_plan : Plan
var plan_parts = []

#------------- BOOSTER LIVES -----------------
var try_to_build_booster = false
var booster_lives = 3
