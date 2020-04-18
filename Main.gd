extends Node

var fuel = 0;

func _ready():
	pass

func _on_Fuel_collected():
	fuel += 1
	$FuelCount.text = "Fuel: " + String(fuel)
