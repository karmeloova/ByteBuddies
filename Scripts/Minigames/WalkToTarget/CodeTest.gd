extends Node2D
var instruction = "";
var tab_of_instructions = [];
var match_instructions = ["forward", "right", "left", "back"]
var user_code;
var user_code_length;
# Instrukcje bez () oraz liczb - w celu sprawdzenia poprawności
var blank_instruction = ""; 
# 0 - czy jest poprawna instrukcja, 1 - czy ma nawisay, 2 - czy > 0
# ostatni warunek dla niektórych instrukcji
var conditions = [false, false, false]
var brackets = [false, false];
var lines = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.code_to_make.connect(_on_code_to_make);

func _on_code_to_make():
	# Pobieramy kod, który wprowadził użytkownik
	user_code = VariableManager.code;
	user_code_length = VariableManager.code.length();
	
	# Ilość linijek kodu 
	lines = 0;
	
	# Czyszczenie tablicy przed wykonaniem ruchu
	tab_of_instructions = [];
	
	if(user_code[user_code_length-1] != "\n") : 
		user_code = user_code + "\n";
		user_code_length = user_code.length();
		
	for i in range(user_code_length) :
		if(user_code[i] != "\n") : instruction = instruction + user_code[i];
		else : 
			lines += 1;
			# Sprawdzamy, czy instrukcja, którą wyciągneliśmy z kodu jest dobra
			if(checkInstruction(instruction)) : 
				# Jeżeli tak to dodajemy ją tyle razy do tablicy instrukcji
				# ile było kroków
				for j in range(instruction.to_int()) :
					tab_of_instructions.append(blank_instruction);
			else : badCode(conditions, lines)
			instruction = ""

	SignalManager.makeMove.emit(tab_of_instructions)

func checkInstruction(instruction) :
	blank_instruction = "";
	conditions = [false, false, false]
	brackets = [false, false];
	
	# "Wyciągamy" czystą instrukcję bez liczby kroków
	for i in range(instruction.length()) :
		if(instruction[i] != "(" and not brackets[0]) :
			blank_instruction += instruction[i];
		# Sprawdzamy nawiasy
		else : 
			brackets[0] = true;
		if(instruction[i] == ")") : brackets[1] = true;
	
	for i in range(match_instructions.size()) :
		if(blank_instruction == match_instructions[i]) :
			# Gdy znajdziemy taką samą instrukcję to ustawiamy warunek 1 na true
			conditions[0] = true;
			break
	# Gdy posiada oba nawiasy to warunek 2 jest spełniony
	if(brackets[0] and brackets[1]) : conditions[1] = true;
	# Sprawdzamy czy podano liczbę kroków
	if(instruction.to_int() > 0) : conditions[2] = true;

	if(conditions[0] and conditions[1] and conditions[2]) : return true;
	else : return false

# Kod, który będzie się wykonywał w przypadku wykonania złego kodu
func badCode(conditions, lines) :
	if(conditions[0] == false) :
		print("Nie znaleziono instrukcji, podanej w linijce: ", lines)
	if(conditions[1] == false) :
		print("Niepoprawnie użyłeś nawiasów w linijce: ", lines)
	if(conditions[2] == false) :
		print("Nie podałeś liczby kroków, bądź jest ona nieodpowiednia. Linijka: ", lines)
