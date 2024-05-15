extends Node
var save_game;
var save_path = "user://GameSave.save"
var save_data = {
	"hungry" : 0
}

# Called when the node enters the scene tree for the first time.
func _ready():
	if not FileAccess.file_exists(save_path) :
		create_save();
	read_data();
	VariableManager.hungry = save_data["hungry"];

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_save():
	# Otwieramy plik do zapisu
	save_game = FileAccess.open(save_path, FileAccess.WRITE);
	save_game.store_var(save_data); # Zapisujemy domyślne parametry
	save_game.close(); # Zamykamy plik
	
func read_data():
	save_game = FileAccess.open(save_path, FileAccess.READ);
	save_data = save_game.get_var(); # Pobieranie danych z pliku i przypisanie do słownika
	save_game.close();
	
func save(parametrName, parametr) :
	save_data[parametrName] = parametr;
	# Otwieramy plik do zapisu
	save_game = FileAccess.open(save_path, FileAccess.WRITE);
	save_game.store_var(save_data); # Zapisujemy domyślne parametry
	save_game.close(); # Zamykamy plik
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save("hungry", VariableManager.hungry);
