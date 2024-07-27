extends Node2D

var code;

func _ready():
	$ExecuteButton.disabled = true;


func _on_execute_button_pressed():
	$CodeField.editable = false;
	VariableManager.code = $CodeField.text;
	SignalManager.code_to_make.emit();

func _on_restart_button_pressed():
	$ExecuteButton.disabled = true;
	$CodeField.clear();
	$CodeField.editable = true;
	SignalManager.restart_button.emit();


func _on_code_field_text_changed():
	if($CodeField.text.length() > 0) : $ExecuteButton.disabled = false;
	else : $ExecuteButton.disabled = true;

