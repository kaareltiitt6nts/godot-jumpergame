extends Interactible

@export var nextLevel : PackedScene
@export var deletePlayer : bool = false

func _on_interact(_player : Player) -> void:
	Levelmanager.loadLevel(nextLevel, deletePlayer)
