extends Node2D

@export var firstLevel : PackedScene

func _on_play_button_pressed() -> void:
	queue_free()
	Levelmanager.loadLevel(firstLevel)

func _on_homepage_button_pressed() -> void:
	OS.shell_open("https://www.voco.ee")
