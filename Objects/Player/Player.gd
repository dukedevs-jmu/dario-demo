extends CharacterBody2D

# Using @export var allows you to change a variable inside the 2D view! 
# Check the player node in the level!
@export var SPEED = 220.0
@export var JUMP_VELOCITY = -240.0

var score = 0

# Get the gravity from the project settings.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumped = false
var reset_position = Vector2(0, 64)

# Activates the second this scene is loaded in game.
func _ready():
	# Set restart point
	update_reset_position(global_position)

# Remember that physics process is called every frame!
# By default, Godot processes at 60 fps, regardless of hardware speed.
func _physics_process(delta):
	# Apply gravity.
	velocity.y += gravity * delta

	# Get the input direction (if any) and handle the movement/deceleration.
	# You can define unique inputs by going to the Input Map tab of Project Settings!
	var direction = Input.get_axis("left", "right")
	if direction:
		# lerp allows us to linearly interpolate (accelerate) to the desired speed.
		velocity.x = lerp(velocity.x, direction * SPEED, 0.025)
		# Use $ to directly refer to a node!
		$Sprite2D.scale.x = direction
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.2)
	
	# Handle jump.
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
			$Jump.play()
	
	# If the player falls a certain distance, send them back to the start.
	if global_position.y > 64:
		reset_player()
		$Sprite2D.scale.x = 1
		$Crush.play()
	
	update_animation()
	move_and_slide()

# Update player's respawn point.
# Requires a position, or Vector2(), argument.
func update_reset_position(pos):
	reset_position = pos

# Send player to start if they get hurt.
func reset_player():
	global_position = reset_position
	
# Bounce player up when landing on an enemy.
func bounce():
	$Crush.play()
	velocity.y = -200

func update_animation():
	# Handle animations.
	if is_on_floor():
		# Check if absolute value of run speed is decently fast!
		if abs(velocity.x) > 20:
			$AnimationPlayer.play("run")
		else:
			$AnimationPlayer.play("idle")
	else:
		$AnimationPlayer.play("jump")
