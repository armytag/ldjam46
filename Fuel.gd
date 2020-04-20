extends Area2D

signal collected

func _ready():
	pass # Replace with function body.

func _on_Fuel_body_entered(body):
	if body is KinematicBody2D :
		emit_signal("collected")
		queue_free()

