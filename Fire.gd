extends Light2D

export (float) var MAX_OFFSET
export (float) var FLICKER_CHANGE
var offset_from_flicker = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	offset_from_flicker.x += rand_range(-FLICKER_CHANGE, FLICKER_CHANGE)
	offset_from_flicker.y += rand_range(-FLICKER_CHANGE, FLICKER_CHANGE)
	
	if offset_from_flicker.length() > MAX_OFFSET:
		offset_from_flicker = offset_from_flicker.normalized() * MAX_OFFSET
	offset = offset_from_flicker
