extends Interactible
@onready var interactSound : AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_body_entered(body: CharacterBody2D) -> void:
	if body is Player:
		_collect_coin(body as Player)

func _collect_coin(player: Player) -> void:
	var fact = Facts.getRandomFact()
	
	if fact:
		player.ui.createNotification(fact)
	
	$Sprite2D.visible = false
	$CollisionShape2D.set_deferred("disaled", true)
	
	interactSound.play()
	interactSound.finished.connect(queue_free)
