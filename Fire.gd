extends Light2D

signal game_over

export (float) var MAX_OFFSET
export (float) var FLICKER_CHANGE
export (float) var BURN_SPEED
var flicker_offset = Vector2()
var fuel_left = 1.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var scale_factor = min(3.0, 1.0*fuel_left + 0.5)
	scale = Vector2(scale_factor, scale_factor)
	energy = min(1.2, fuel_left)
	$FireCrackle.volume_db = min( 18.0, (fuel_left-1.0)*20.0 )


func _on_FlickerTimer_timeout():
	flicker_offset.x = rand_range(-MAX_OFFSET,MAX_OFFSET)
	flicker_offset.y = rand_range(-MAX_OFFSET,MAX_OFFSET)
	
	offset = flicker_offset


func _on_BurnTimer_timeout():
	fuel_left *= (1.0-BURN_SPEED)
	if fuel_left <= 0.5:
		energy = 0.5
		$BurnTimer.stop()
		$FireCrackle.stop()
		$AnimatedSprite.hide()
		emit_signal("game_over")

func _on_Fuel_added():
	fuel_left += 0.3
	$FuelAddEffect.play()
	

	
