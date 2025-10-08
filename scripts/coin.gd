extends Interactible

@onready var interactSound : AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_body_entered(_body: CharacterBody2D) -> void:
	super._on_body_entered(_body)

func _on_interact(player : Player) -> void:
	var fact = Facts.getRandomFact()
	
	if fact:
		player.ui.createNotification(fact)
	
	$Sprite2D.visible = false
	$CollisionShape2D.disabled = true
	
	interactSound.play()
	interactSound.finished.connect(queue_free)
