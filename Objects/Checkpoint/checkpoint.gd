extends Node2D

var activated = false

# When a body of the corresponding collision layer touches this area,
# emit a signal and activate.
func _on_detect_player_body_entered(body):
	if not activated:
		activated = true
		
		# In this case, "body" is the player.
		body.update_reset_position(global_position)
		$AnimationPlayer.play("activate")
		$Sound.play()
