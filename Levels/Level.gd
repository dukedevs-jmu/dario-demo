extends Node2D

@export var sky_color = Color(0.333, 0.771, 1)

func _ready():
	# Set default background to sky_color
	RenderingServer.set_default_clear_color(sky_color)
	
	
	# Provide what manages the score to coins and enemies.
	# Make sure to put new coins and enemies under their proper nodes!
	
	for coin in $Coins.get_children():
		coin.score_manager = $UI
	
	for enemy in $Enemies.get_children():
		enemy.score_manager = $UI
