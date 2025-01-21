extends Node2D
var current_booster : Plan
var instruction_tab : Array[String]
var code_field_scene = load("res://Scenes/Prefabs/CodeElement.tscn")
@onready var code_field_node = $CodeInputNode
var code_field_instance
var enter_size = 40
var tab_size = 40
var previous_size
var previous_position
var space = 5
var enter : bool
var tab_count = 0
var next_pos = Vector2.ZERO
var is_booster_correct = true
var check_counter = 0
var ins_counter = 0

func _ready():
	SignalManager.start_build_booster.connect(_on_start_build_booster)
	SignalManager.check_if_is_good.connect(_on_check_if_is_good)

func _on_start_build_booster(plan : Plan) :
	$".".visible = true
	current_booster = plan
	instruction_tab = current_booster.correct_booster
	set_booster_template()

func set_booster_template() :
	for i in range(0, instruction_tab.size()) :
		if(instruction_tab[i]=="enter") :
			if(tab_count > 0) : next_pos.x = 0 + tab_size*tab_count
			else : next_pos.x = 0
			next_pos.y = previous_position.y + enter_size
			continue
		if(instruction_tab[i]=="tab") :
			tab_count += 1
			next_pos.x = 0 + tab_size*tab_count
			continue
		if(instruction_tab[i]=="deletetab") :
			tab_count -= 1
			continue
		
		code_field_instance = code_field_scene.instantiate()
		code_field_instance.set_size_and_text(instruction_tab[i])
		code_field_instance.set_pos(next_pos)
		previous_position = code_field_instance.get_pos()
		previous_size = code_field_instance.get_my_size()
		code_field_node.add_child(code_field_instance)
		next_pos.x = previous_position.x+previous_size+space
		next_pos.y = previous_position.y
		ins_counter += 1
	
	#set_neighbours()

func _on_button_pressed():
	SignalManager.check_booster_build.emit()

func _on_check_if_is_good(is_good : bool) :
	check_counter += 1
	if(is_booster_correct) : is_booster_correct = is_good
	if(check_counter == ins_counter) : 
		if(is_booster_correct) : 
			$UseButton.visible = true
			check_counter = 0
		else : 
			print("Nie udało się poprawnie zbudować boostera. Popraw go.")
			check_counter = 0

func set_neighbours() :
	for i in code_field_node.get_child_count() :
		if(i+1 < code_field_node.get_child_count()) :
			code_field_node.get_child(i).get_child(0).focus_neighbor_next = NodePath(code_field_node.get_child(i+1).get_child(0).get_path())
		if(i-1 >= 0) :
			code_field_node.get_child(i).get_child(0).focus_neighbor_previous = NodePath(code_field_node.get_child(i-1).get_child(0).get_path())

func _on_use_button_pressed():
	SignalManager.use_booster.emit(current_booster)
