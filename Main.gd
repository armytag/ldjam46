extends Node

signal fuel_added

export (PackedScene) var Fuel
var fuel_collected = 0
var seconds = 0
var game_over = false
var ready_to_restart = false


func _ready():
	randomize()
	$HUD/FuelCount.show()
	$HUD/Result.hide()
	$HUD/Restart.hide()
	
	var fuel_spawn_number = rand_range(100, 400)
	for _i in range(fuel_spawn_number):
		var fuel = Fuel.instance()
		add_child(fuel)
		fuel.position = Vector2(rand_range(-2000, 2000), rand_range(-2000,2000))
		while fuel.position.distance_to($Fire.position) < 500:
			fuel.position = Vector2(rand_range(-2000, 2000), rand_range(-2000,2000))
		fuel.connect("collected", self, "_on_Fuel_collected")

func _process(_delta):
	if not game_over:
		if Input.is_action_just_pressed("ui_select") and fuel_collected > 0:
			if $Player.position.distance_to($Fire.position) < 100:
				fuel_collected -= 1
				update_fuelcount(fuel_collected)
				emit_signal("fuel_added")
	elif ready_to_restart:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().reload_current_scene();


func _on_Fuel_collected():
	fuel_collected += 1
	update_fuelcount(fuel_collected)

func _on_Fuel_consumed():
	fuel_collected -= 1
	update_fuelcount(fuel_collected)
	
func update_fuelcount(fuel_amount):
	$HUD/FuelCount.text = "Fuel: " + String(fuel_amount)
	print($HUD/FuelCount.text)



func _on_Fire_game_over():
	game_over = true
	$SecondTimer.stop()
	$HUD/FuelCount.hide()
	$Player/Camera2D.current = false
	$Fire/Camera2D.current = true
	
	var result = "After 2,487 years"
	result += "\n"
	if seconds >= 60:
		var minutes = floor(seconds/60)
		result += ", " + String(minutes)
		if minutes == 1:
			result  + " minute, "
		else:
			result += " minutes, "
	result += "and " + String(seconds%60) + " seconds\n"
	result += "\n\nthe sacred flame has finally \ngone out\n"
	$HUD/Result.text = result
	$HUD/Result.show()
	
	$RestartTimer.start()


func _on_SecondTimer_timeout():
	seconds += 1


func _on_RestartTimer_timeout():
	$HUD/Restart.show()
	ready_to_restart = true
