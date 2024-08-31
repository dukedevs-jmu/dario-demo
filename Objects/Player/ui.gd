extends CanvasLayer

var score = 0

# Handle changing score and updating the HUD.
func add_score(points):
	score += points
	$Control/Score.text = str(score)

func coin_collected():
	add_score(100)
	$Pickup.play()
