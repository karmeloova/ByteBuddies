extends Node2D

func _on_information_button_mouse_entered():
	$Information.visible = true
	if($"../CodeFeedNode".visible) :
		$"../CodeFeedNode/Information".visible = true
	elif($"../NormalFeed".visible) :
		$"../NormalFeed/Information".visible = true
	$InformationButton.modulate = Color("b2b2b2")
	$Icon.modulate = Color("b2b2b2")

func _on_information_button_mouse_exited():
	$Information.visible = false
	$InformationButton.modulate = Color("ffffff")
	if($"../CodeFeedNode".visible) :
		$"../CodeFeedNode/Information".visible = false
	elif($"../NormalFeed".visible) :
		$"../NormalFeed/Information".visible = false
	$Icon.modulate = Color("ffffff")
