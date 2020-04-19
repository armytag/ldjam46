extends Light2D

export (float) var BURN_SPEED
var time_left = 100

func _ready():
	time_left = 100


func _on_BurnTimer_timeout():
	time_left -= BURN_SPEED;
	var scale_factor = time_left/100.0
	scale = Vector2(scale_factor, scale_factor)
	if time_left <= 0:
		queue_free()
