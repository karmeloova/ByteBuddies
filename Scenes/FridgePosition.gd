extends Control
var food : Food_Resource
var food_to_save : storage_resource
var food_count : int
@export_category("Food Resource Info")
@export var food_name : Label
@export var food_hungry_points : Label
@export var food_count_label : Label

func _on_add_to_bowl_pressed():
	SignalManager.add_to_bowl.emit(food_hungry_points.text)
	decrease_food_count()
	if(food_count==0) :
		SignalManager.remove_from_fridge.emit(food)

func add_to_frigde_ui(item : Food_Resource) :
	food = item
	food_name.text = food.food_name
	food_hungry_points.text = "+" + str(food.hungry_points) + "%"
	increase_food_count()
	
func increase_food_count() :
	food_count += 1
	food_count_label.text = str(food_count)
	found_correct_food(1)

func decrease_food_count() :
	food_count -= 1
	food_count_label.text = str(food_count)
	found_correct_food(-1)

func found_correct_food(number : int) :
	if(VariableManager.food_resource.size() > 0) :
		for foods in VariableManager.food_resource :
			if(foods.item == food) :
				foods.amount += number
				if(foods.amount == 0) : 
					VariableManager.food_resource.erase(foods)
					for i in VariableManager.food_resource :
						print(i.item.food_name)
						print(i.amount)
				return

	food_to_save = storage_resource.new()
	food_to_save.item = food
	food_to_save.amount = food_count
	VariableManager.food_resource.append(food_to_save)

func load_food_resources(item : Food_Resource, amount : int) :
	food_count = amount
	food = item
	food_name.text = food.food_name
	food_hungry_points.text = "+" + str(food.hungry_points) + "%"
	food_count_label.text = str(food_count)
