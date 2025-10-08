extends Control

@export var exit_url : String = "https://www.voco.ee"

func _ready() -> void:
	Levelmanager.deleteLevel()

func _on_exit_button_pressed() -> void:
	print("Opening URL: ", exit_url)
	OS.shell_open(exit_url)

func _on_restart_button_pressed() -> void:
	print("Restarting game...")
	queue_free()
	get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")
