extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$MusicDelayTimer.start()

func _on_StartButton_pressed():
	var _scene = get_tree().change_scene("res://Main.tscn")


func _on_MusicDelayTimer_timeout():
	$MainTheme.play()
