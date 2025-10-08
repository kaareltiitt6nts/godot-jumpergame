extends Interactible
@onready var interactSound : AudioStreamPlayer2D = $AudioStreamPlayer2D
#coin collection fixed yipeee
func _on_body_entered(body: CharacterBody2D) -> void:
	super._on_body_entered(body)
	
	if body is Player:
		_collect_coin(body)

func _collect_coin(player: Player) -> void:
	var fact = Facts.getRandomFact()
	
	if fact:
		player.ui.createNotification(fact)
	
	$Sprite2D.visible = false
	$CollisionShape2D.disabled = true
	
	interactSound.play()
	interactSound.finished.connect(queue_free)
