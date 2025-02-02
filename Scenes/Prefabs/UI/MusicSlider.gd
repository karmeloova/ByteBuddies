extends HSlider


# Called when the node enters the scene tree for the first time.
func _ready():
	var style = StyleBoxFlat.new()
	style.bg_color = Color(1, 0, 0)  # Czerwony kolor grabbera
	add_theme_stylebox_override("Grabber", style)
