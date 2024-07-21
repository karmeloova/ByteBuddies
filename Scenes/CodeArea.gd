extends Node2D

var code;

func _on_execute_button_pressed():
	$CodeField.editable = false;
	VariableManager.code = $CodeField.text;
	SignalManager.code_to_make.emit();

func _on_restart_button_pressed():
	$CodeField.clear();
	$CodeField.editable = true;
	SignalManager.restart_button.emit();
