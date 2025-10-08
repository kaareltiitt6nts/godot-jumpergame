extends Node

var currentPlayer : Player
var currentLevel : Node

func deleteLevel():
	if (currentLevel != null):
		currentLevel.queue_free()

func deletePlayer():
	if (currentPlayer != null):
		currentPlayer.queue_free()

func loadLevel(newScene : PackedScene, doDeletePlayer = false):
	if newScene == null:
		push_error("loadLevel(): newScene is null — check your scene reference.")
		return
	
	deleteLevel()
	
	if (doDeletePlayer):
		deletePlayer()
	
	var scene = newScene.instantiate()
	add_child(scene)
	currentLevel = scene

func loadPackedScene(newScene : PackedScene):
	get_tree().change_scene_to_packed(newScene)
