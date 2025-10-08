extends Node

var currentPlayer : Player
var currentLevel : Node
var currentTileMap : TileMapLayer

@onready var playerScene : PackedScene = load("res://scenes/player/player.tscn")

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
	
	if doDeletePlayer:
		deletePlayer()
	
	if currentPlayer == null:
		var player = playerScene.instantiate()
		add_child(player)
	
	var scene = newScene.instantiate()
	add_child(scene)
	currentLevel = scene
	currentTileMap = scene.find_child("TileMapLayer")
	
	var spawnPos : Node2D = currentLevel.find_child("Playerspawn")
	if spawnPos:
		currentPlayer.position = spawnPos.position

func loadPackedScene(newScene : PackedScene):
	get_tree().change_scene_to_packed(newScene)
