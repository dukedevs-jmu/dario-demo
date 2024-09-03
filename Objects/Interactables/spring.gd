extends Area2D



func _on_body_entered(body):
	
	# Check if player is in the air and falling.
	if not body.is_on_floor() and body.velocity.y > 0:
		body.velocity.y = -360
		$AnimationPlayer.play("activate")
		$Sound.play()
