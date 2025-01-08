extends Resource

class_name Code_Task

enum Difficulty {Easy, Medium, Hard}

@export var description : String
@export var instructions : Array[String]
@export var difficulty : Difficulty = Difficulty.Easy
