extends Label

func _ready():
	SignalManager.set_cat_name.connect(_on_set_cat_name)
	_on_set_cat_name()

func _on_set_cat_name() :
	if(VariableManager.cat_name.length() > 0) :
		text = VariableManager.cat_name
