extends Node2D

## File path to next level as a string.
@export var next_level = ""

# Hide and stop player from moving on collision.
func _on_area_2d_body_entered(body):
	body.set_physics_process(false)
	body.hide()
	
	# Exit timer
	$ExitTimer.start()


func _on_exit_timer_timeout():
	# If no level provided, default to level 1.
	if next_level == "":
		next_level = "res://Levels/Levels/Level1.tscn"
	get_tree().change_scene_to_file(next_level)
