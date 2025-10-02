extends Area2D
class_name Interactible

signal interact
signal player_entered(interactible: Interactible)
signal player_exited(interactible: Interactible)

func _ready() -> void:
	monitoring = true
	add_to_group("interactible")
	
	connect("interact", _on_interact)
	
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_interact() -> void:
	pass

func _on_body_entered(_body: CharacterBody2D) -> void:
	if _body.is_in_group("player"):
		emit_signal("player_entered", self)

func _on_body_exited(_body: CharacterBody2D) -> void:
	if _body.is_in_group("player"):
		emit_signal("player_exited", self)
