extends Area2D



func _on_body_entered(body):
	if not body.is_on_floor() and body.velocity.y > 0:
		body.velocity.y = -320
