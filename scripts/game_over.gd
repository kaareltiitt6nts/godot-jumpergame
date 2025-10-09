extends Node2D

@export var exit_url : String = "https://www.voco.ee"

func _ready() -> void:
	Levelmanager.deleteLevel()

func _on_play_button_pressed() -> void:
	print("Restarting game...")
	queue_free()
	get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")


func _on_homepage_button_pressed() -> void:
	print("Opening URL: ", exit_url)
	OS.shell_open(exit_url)
