extends Node

signal fuel_added

export (PackedScene) var Fuel
var fuel_collected = 0;

func _ready():
	randomize()
	
	var fuel_spawn_number = rand_range(100, 400)
	for _i in range(fuel_spawn_number):
		var fuel = Fuel.instance()
		add_child(fuel)
		fuel.position = Vector2(rand_range(-2000, 2000), rand_range(-2000,2000))
		fuel.connect("collected", self, "_on_Fuel_collected")

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") and fuel_collected > 0:
		if $Player.position.distance_to($Fire.position) < 70:
			fuel_collected -= 1
			update_fuelcount(fuel_collected)
			emit_signal("fuel_added")

func _on_Fuel_collected():
	fuel_collected += 1
	update_fuelcount(fuel_collected)

func _on_Fuel_consumed():
	fuel_collected -= 1
	update_fuelcount(fuel_collected)
	
func update_fuelcount(fuel_amount):
	$HUD/FuelCount.text = "Fuel: " + String(fuel_amount)
	print($HUD/FuelCount.text)
