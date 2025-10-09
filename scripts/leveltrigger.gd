extends Interactible

@export var nextLevel : PackedScene
@export var deletePlayer : bool = false

var player_in_area = false


func _on_body_entered(body: CharacterBody2D) -> void:
	super._on_body_entered(body)
	
	if body.is_in_group("player"):
		player_in_area = true
		print("Vajuta ENTER, et siseneda teisele korrusele")
	
func _on_body_exited(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		player_in_area =false

func _process(delta: float) -> void:
	if player_in_area and Input.is_action_just_pressed("ui_accept"):
		_on_interact(null)
		
func _on_interact(_player : Player) -> void:
	Levelmanager.loadLevel(nextLevel, deletePlayer)
