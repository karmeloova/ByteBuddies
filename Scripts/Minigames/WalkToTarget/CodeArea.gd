extends Node2D

var code;

func _ready():
	$ExecuteButton.disabled = true;
	SignalManager.moveEnd.connect(_on_end_move)
	SignalManager.loseLife.connect(_on_lose_life)

func _on_execute_button_pressed():
	$CodeField.editable = false;
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
