extends Interactible

func _on_body_entered(_body: CharacterBody2D) -> void:
	## kui on vaja säilitada funktsiooni algne loogika, hetkel ei ole.
	super._on_body_entered(_body)

func _on_interact() -> void:
	queue_free()
