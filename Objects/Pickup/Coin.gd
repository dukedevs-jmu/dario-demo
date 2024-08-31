extends Area2D

# Set by level script
var score_manager

# Listens for a signal, then triggers.
# (Shown with green arrow and box on left of line)
func _on_body_entered(body):
	score_manager.coin_collected()
	queue_free()
