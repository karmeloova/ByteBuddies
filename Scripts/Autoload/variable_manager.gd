extends Node

var needs = {
	"hungry" : 0,
	"play" : 0,
	"scratch" : 0,
	"sleep" : 0,
	"clean" : 0
}

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

#------------- MINI-GAMES ---------------

#------------- CAT JUMP ----------------

var platform_size
var player_size
var moved : bool = false

#------------- SHOP ------------------

var food_item : Food_Resource

#------------- LEVEL -----------------
var current_exp : int = 0
var can_be_promoted : bool = true

#----------- HIGH-SCORES ------------
var snack_navigator_high_score : int = 0
var cat_jump_high_score : int = 0
var pet_code_high_score : int = 0
