extends Node2D

var code;
var lines = 0;
var execute_counts = 0;

func _ready():
	$ExecuteButton.disabled = true;
	SignalManager.moveEnd.connect(_on_end_move)
	SignalManager.loseLife.connect(_on_lose_life)
	SignalManager.nextLevel.connect(_on_next_level)

func _on_execute_button_pressed():
	execute_counts += 1
	$CodeField.editable = false;
	lines += $CodeField.get_line_count();
	VariableManager.lines_couner = lines
	VariableManager.code = $CodeField.text;
	SignalManager.code_to_make.emit();

func _on_code_field_text_changed():
	if($CodeField.text.length() > 0) : $ExecuteButton.disabled = false;
	else : $ExecuteButton.disabled = true;

func _on_end_move() :
	$ExecuteButton.disabled = true;
	$PlayerCode.text += $CodeField.text + "\n"
	$CodeField.clear();
	$CodeField.editable = true;

func _on_lose_life() :
	$CodeField.clear();
	$CodeField.editable = true;

func _on_next_level():
	VariableManager.execute_counter = execute_counts;
	execute_counts = 0
	lines = 0
	$PlayerCode.text = ""
