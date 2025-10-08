extends Interactible

func _on_body_entered(body: CharacterBody2D) -> void:
	if body is Player:
		body.resetToSafePosition()
		body.takeDamage(1)
