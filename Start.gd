extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$MusicDelayTimer.start()
	$Menu/StartButton.show()
	$Menu/StartButton.modulate = Color(1,1,1,1)
	$Menu/InfoButton.show()
	$Menu/InfoButton.modulate = Color(1,1,1,1)
	$Menu/ControlsButton.show()
	$Menu/ControlsButton.modulate = Color(1,1,1,1)
	$Menu/IntroText.hide()
	$Menu/IntroText.modulate = Color(1,1,1,0)
	$MainTheme.volume_db = -3

func _on_StartButton_pressed():
	$AnimationPlayer.play("fade")


func _on_MusicDelayTimer_timeout():
	$MainTheme.play()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade":
		var _scene = get_tree().change_scene("res://Main.tscn")


func _on_InfoButton_pressed():
	$Menu/InfoPanel.popup_centered()


func _on_ControlsButton_pressed():
	$Menu/ControlsPanel.popup_centered()
