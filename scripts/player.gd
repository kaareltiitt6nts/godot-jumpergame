extends CharacterBody2D
class_name Player

var interactiblesInRange : Array = []
var moveDir : Vector2 = Vector2.ZERO
var walkTimer = 0
var safePosition : Vector2 = Vector2.ZERO
var doUpdate : bool = true

@export var gravity : float = 700
@export var acceleration : float = 1500
@export var airAcceleration : float = 200
@export var friction : float = 10
@export var airFriction : float = 3
@export var jumpPower : float = 230
@export var walkSoundGap : float = 0.15

@export var maxLives : int = 3
var currentLives = 3

@onready var playerSprite : Sprite2D = $Sprite2D
@onready var playerCollider : CollisionShape2D = $CollisionShape2D
@onready var floorCheck : RayCast2D = $FloorCheck
@onready var interactArrow : Node = $InteractArrow
@onready var canvasLayer : CanvasLayer = $UI
@onready var heartContainer : HBoxContainer = $UI/HeartContainer
@onready var camera : Camera2D = $Camera2D
@onready var ui : UIController = $UI

@onready var jumpSoundPlayers : Array[Node] = $Sounds/JumpSounds.get_children(false)
@onready var hitSoundPlayer : AudioStreamPlayer2D = $Sounds/PlayerHit
@onready var dieSoundPlayer : AudioStreamPlayer2D = $Sounds/PlayerDie
@onready var walkSoundPlayer : AudioStreamPlayer2D = $Sounds/Walk

@export var uiHeart : PackedScene
@export var uiHeartGray : PackedScene
@export var deathParticle : PackedScene

func isDown(inputId) -> bool:
	return Input.is_action_pressed(inputId)

func isJustPressed(inputId) -> bool:
	return Input.is_action_just_pressed(inputId)

func jump(playSound : bool = true) -> void:
	if (is_on_floor()):
		if playSound:
			var soundPlayer : AudioStreamPlayer2D = jumpSoundPlayers.pick_random()
			soundPlayer.play()
		
		addVelocity(Vector2.UP * jumpPower)

func hasInteractibles() -> bool:
	return interactiblesInRange.size() > 0

func interact():
	if (hasInteractibles()):
		interactiblesInRange[0].emit_signal("interact", self)

func addVelocity(dir : Vector2) -> void:
	velocity += dir

func setVelocity(dir : Vector2) -> void:
	velocity = dir

func die() -> void:
	dieSoundPlayer.play()
	queue_free()
	get_tree().change_scene_to_file("res://scenes/levels/game_over.tscn")

func setPlayerFrozen(state : bool):
	if state:
		playerSprite.modulate.a = 0.5
		velocity = Vector2.ZERO
		doUpdate = false
	else:
		playerSprite.modulate.a = 1
		doUpdate = true

func resetToSafePosition():
	position = safePosition
	setPlayerFrozen(true)
	
	await get_tree().create_timer(1).timeout
	
	setPlayerFrozen(false)

func updateHearts() -> void:
	var hearts : Array[Node] = heartContainer.get_children()
	
	for child in hearts:
		child.queue_free()
	
	var lifeCount = 0
	for i in maxLives:
		lifeCount += 1
		if (lifeCount > currentLives):
			var heart : TextureRect = uiHeartGray.instantiate()
			heartContainer.add_child(heart)
		else:
			var heart : TextureRect = uiHeart.instantiate()
			heartContainer.add_child(heart)

func takeDamage(amount: int) -> void:
	currentLives -= amount
	
	print("took damage. new lives: ", currentLives)
	
	hitSoundPlayer.play()
	
	var particle = deathParticle.instantiate()
	add_child(particle)
	particle.position = position
	
	updateHearts()
	
	if (currentLives <= 0):
		print("died")
		die()

func _ready() -> void:
	Levelmanager.currentPlayer = self
	updateHearts()
	ui.fadeIn(2)

func _process(delta: float) -> void:
	if (doUpdate == false):
		return
	if (currentLives <= 0):
		return
	
	if (isJustPressed("up")): ## ülesnool
		jump()
	if (isDown("right")): ## paremnool
		moveDir.x += 1
		playerSprite.scale.x = 1
	if (isDown("left")): ## vasaknool
		moveDir.x -= 1
		playerSprite.scale.x = -1
	if (isJustPressed("interact")): ## enter
		interact()
	
	if abs(moveDir.x) > 0 && is_on_floor() && velocity.length_squared() > 0:
		if (isJustPressed("left") || isJustPressed("right")):
			walkTimer += walkSoundGap / 2
		
		walkTimer += delta
		playerSprite.position.y = (-walkSoundGap + walkTimer) * 8
		
		if walkTimer > walkSoundGap:
			walkSoundPlayer.pitch_scale = randf_range(0.7, 1.3)
			walkSoundPlayer.play()
			walkTimer = 0
	else:
		playerSprite.position.y = 0
		walkTimer = 0
	
	if floorCheck.is_colliding() && Levelmanager.currentTileMap:
		var collisionPos : Vector2 = floorCheck.get_collision_point()
		var collisionCellPos : Vector2 = Levelmanager.currentTileMap.local_to_map(collisionPos)
		collisionCellPos += Vector2.UP
		safePosition = Levelmanager.currentTileMap.map_to_local(collisionCellPos)
	
	velocity.y += gravity * delta
	
	if (moveDir.x != 0):
		var accel = acceleration if is_on_floor() else airAcceleration
		addVelocity(Vector2(moveDir.x * accel * delta, 0))
	
	var fric = friction if is_on_floor() else airFriction
	velocity.x = lerpf(velocity.x, 0, fric * delta)
	
	move_and_slide()
	interactArrow.visible = hasInteractibles()
	moveDir = Vector2.ZERO

func addInteractibleInRange(interactible: Interactible):
	interactiblesInRange.append(interactible)

func removeInteractibleInRange(interactible: Interactible):
	interactiblesInRange.erase(interactible)
