extends Area2D

signal collected

func _ready():
	pass # Replace with function body.

func _on_Fuel_body_entered(body):
	emit_signal("collected")
	queue_free()

func _on_Fuel_collected():
	print("Ooops!")
