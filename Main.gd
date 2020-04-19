extends Node

signal fuel_added

export (PackedScene) var Fuel
export (PackedScene) var Torch

var fuel_collected = 0
var seconds = 0
var torch_time_left = 100
export (float) var MAX_TORCH_TIME
export (float) var TORCH_BURN_SPEED
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
				emit_signal("fuel_added")
		if Input.is_action_just_pressed("ui_focus_next") and fuel_collected > 0:
			fuel_collected -= 1
			var torch = Torch.instance()
			add_child(torch)
			torch.position = $Player.position
		if Input.is_action_just_pressed("ui_focus_prev") and fuel_collected > 0:
			print("Reset player torch")
			fuel_collected -= 1
			torch_time_left = MAX_TORCH_TIME
		update_fuelcount(fuel_collected)
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



func _on_Fire_game_over():
	game_over = true
	$SecondTimer.stop()
	$HUD/FuelCount.hide()
	$Player/Camera2D.current = false
	$Fire/Camera2D.current = true
	
	var result = "After 3,487 years"
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


func _on_TorchTimer_timeout():
	torch_time_left = max(0, torch_time_left-TORCH_BURN_SPEED)
	var scale_factor = torch_time_left/MAX_TORCH_TIME
	$Player/TorchLight.texture_scale = scale_factor
	print(scale_factor)
	
	
