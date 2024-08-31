extends CharacterBody2D

# Basic funny enemy guy.

const SPEED = 20.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Movement direction
var direction = -1
var dead = false

# Set by the level script
var score_manager

# Do this to refer to nodes by a variable name!
@onready var detect_floor = $Sprite2D/DetectFloor

func _physics_process(delta):
	# Apply gravity.
	velocity.y += gravity * delta
	
	# Check if there's a ledge or a wall up ahead using raycasts.
	if not detect_floor.is_colliding() or $Sprite2D/DetectWall.is_colliding():
		# Reverse current direction
		direction *= -1
		$Sprite2D.scale.x = direction
	
	# Handle movement.
	if not dead:
		velocity.x = direction * SPEED
	else:
		velocity.x = 0
	move_and_slide()

# Handle when the player jumps on this enemy.
func _on_detect_player_body_entered(body):
	# Check if player is in the air and falling.
	if not body.is_on_floor() and body.velocity.y > 0:
		body.bounce()
		score_manager.add_score(100)
		dead = true
		$AnimationPlayer.play("die")

# When animation finishes, delete this node. 
# "idle" won't trigger this since it loops.
func _on_animation_player_animation_finished(anim_name):
	# Deletes this node, along with its children
	queue_free()
