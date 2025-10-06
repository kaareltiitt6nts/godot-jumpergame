extends Area2D
class_name Interactible

signal interact

func _ready() -> void:
	monitoring = true
	add_to_group("interactible")
	
	connect("interact", _on_interact)
	
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_interact() -> void:
	pass

func _on_body_entered(body: CharacterBody2D) -> void:
	if body is Player:
		body.addInteractibleInRange(self)

func _on_body_exited(body: CharacterBody2D) -> void:
	if body is Player:
		body.removeInteractibleInRange(self)
