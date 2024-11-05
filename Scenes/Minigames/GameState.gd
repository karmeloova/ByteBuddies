extends Node2D
var score = 0
var money = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Score.text = "Wynik: " + str(score)
	$Money.text = "Kasa: " + str(money)
	SignalManager.calculate_score.connect(_on_calculate_score)
	SignalManager.add_coin.connect(_on_add_coin)
	SignalManager.save_data.connect(_on_save_data)

func _on_calculate_score(lines) :
	# Punkty za długość kodu
	if(VariableManager.lines_couner <= lines+1) :
		score += 20
	elif(VariableManager.lines_couner - (lines+1) <= 5) :
		score += randi_range(10, 19)
	elif(VariableManager.lines_couner - (lines+1) <= 10) :
		score += randi_range(1,9)
	
	# Punkty za ilość wykonań
	if(VariableManager.execute_counter == 1) :
		score += 15
	elif(VariableManager.execute_counter <= (VariableManager.tiles_counter-1)/2) :
		score += 10
	else :
		score += 5
	
	update_score()

func update_score() :
	$Score.text = "Wynik: " + str(score)

func _on_add_coin(value) :
	money += value
	$Money.text = "Kasa: " + str(money)

func _on_save_data() :
	if(score > VariableManager.snack_navigator_high_score) :
		VariableManager.snack_navigator_high_score = score
	VariableManager.coins += money
