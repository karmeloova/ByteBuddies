extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -550.0
var max_height = 0;

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	max_height = position.y
	VariableManager.player_size = $Sprite2D.scale.x

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if(position.y < max_height) : max_height = position.y
	#if(position.y < 0) :
		#$Camera2D.enabled = true;

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

