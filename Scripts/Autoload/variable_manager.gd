extends Node

var needs = {
	"hungry" : 0,
	"play" : 0,
	"scratch" : 0,
	"sleep" : 0,
	"clean" : 0
}

var hungry_points_in_bowl : int = 0

var tile_size;
var start_position;

var code;

var coins : int = 0

#------------- MINI-GAMES ---------------

#------------- CAT JUMP ----------------

var platform_size
var player_size
var moved : bool = false

#------------- SHOP ------------------

var food_item : Food_Resource
