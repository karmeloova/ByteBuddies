extends Node2D
var dir = 1;

var necessities = {
	"hungry" : 0,
	"play" : 0,
	"scratch" : 0,
	"sleep" : 0,
	"clean" : 0
}

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.changed_needs.connect(_on_changed_needs)
	$Timer.start(1);
	necessities["hungry"] = $Hungry/TextureProgressBar;
	necessities["play"] = $Play/TextureProgressBar;
	necessities["scratch"] = $Scratch/TextureProgressBar;
	necessities["sleep"] = $Sleep/TextureProgressBar;
	necessities["clean"] = $Cleanliness/TextureProgressBar;
	
	for i in necessities :
		necessities[i].value = VariableManager.needs[i];

func _on_changed_needs() :
	for i in necessities :
		necessities[i].value = VariableManager.needs[i];
