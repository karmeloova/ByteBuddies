extends Resource

class_name Plan

@export var plan_name : String
@export var res_name : String
@export var booster_category : MyEnums.BoosterCategory
@export var booster_description : String
@export var required_level : Level
@export var price : int
@export var needed_code_elements : Array[CodeElement]
@export var correct_booster : Array[CorrectCodeElement]
@export var games_duration : int
@export var multiplier : int
