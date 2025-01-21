extends Node2D

var cat_name : String = ""

func _on_texture_button_mouse_entered():
	$AcceptButton.modulate = Color("b2b2b2")

func _on_texture_button_mouse_exited():
	$AcceptButton.modulate = Color("ffffff")

func _on_texture_button_pressed():
	cat_name = $EnterCatName.text
	if(cat_name.length() > 20) :
		$Warningtext.text = "Imię nie może być dłuższe niż 20 znaków"
		$Warningtext.visible = true
	elif(cat_name.length() < 1):
		$Warningtext.text = "Imię nie może być krótsze niż 1 znak"
		$Warningtext.visible = true
	else :
		VariableManager.cat_name = cat_name
		get_tree().paused = false
		SignalManager.set_cat_name.emit()
		visible = false
