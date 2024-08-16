extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -550.0
var max_height = 0;
var start_position = Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	VariableManager.moved = false
	start_position = position
	VariableManager.player_size = $Sprite2D.scale.x
	
	SignalManager.restartGame.connect(_on_restart_game)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func _on_area_2d_area_entered(area):
	if not VariableManager.moved :
		VariableManager.moved = true

func _on_visible_on_screen_notifier_2d_screen_exited():
	SignalManager.loseGame.emit()

func _on_restart_game() :
	position = start_position
	VariableManager.moved = false
