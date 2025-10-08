extends CharacterBody2D

@export var speed : float = 40
@export var edgeWaitTime : float = 2

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

@onready var rayCasts : Node2D = $Raycasts
@onready var rightEdgeCheck : RayCast2D = $Raycasts/RightEdge
@onready var leftEdgeCheck : RayCast2D = $Raycasts/LeftEdge

@onready var topCollider : Area2D = $Colliders/TopCollider
@onready var sideCollier : Area2D = $Colliders/SideCollider
@onready var playerCollider : CollisionShape2D = $CollisionShape2D

@onready var deathSoundPlayer : AudioStreamPlayer2D = $DeathSound

var direction : int = 1
var waitTimer : float = 0
var canMove : bool = true

func _physics_process(delta):
	var edgeCheckToUse : RayCast2D = rightEdgeCheck if direction == 1 else leftEdgeCheck
	
	if (!canMove):
		waitTimer += delta
		
		if (waitTimer >= edgeWaitTime):
			waitTimer = 0
			direction *= -1
			canMove = true
		
		return
	
	velocity.x = direction * speed
	
	if (!is_on_floor()):
		velocity.y += 500 * delta
	else:
		velocity.y = 0
	
	sprite.scale.x = direction
	
	move_and_slide()
	
	if (!edgeCheckToUse.is_colliding() && is_on_floor()):
		canMove = false
		velocity.x = 0
	
	if (is_on_wall()):
		direction *= -1

func _on_top_collider_body_entered(body: Node2D) -> void:
	if (body is Player):
		body.jump(false)
		deathSoundPlayer.play()
		$AnimatedSprite2D.visible = false
		topCollider.queue_free()
		sideCollier.queue_free()
		playerCollider.queue_free()
		deathSoundPlayer.finished.connect(queue_free)

func _on_side_collider_body_entered(body: Node2D) -> void:
	if body is Player:
		var dirToPlayer : Vector2 = (body.position - position).normalized()
		dirToPlayer.y = 0
		var force : Vector2 = dirToPlayer * 250 + Vector2.UP * 70
		
		body.setVelocity(force)
		body.takeDamage(1)
