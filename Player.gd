extends KinematicBody2D

export (int) var SPEED
var velocity = Vector2()

func _ready():
	pass
	
func _physics_process(_delta):
	velocity = Vector2()
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
	
	var movement_vector = move_and_slide(velocity)
