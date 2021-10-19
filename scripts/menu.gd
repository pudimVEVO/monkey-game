extends Control

onready var _transition_rect := $SceneTransitionRect


func _on_play_pressed():
	_transition_rect.transition_to("res://scenes/World.tscn")


func _on_settings_pressed():
	pass # Replace  function body.


func _on_quit_pressed():
	get_tree().quit()
