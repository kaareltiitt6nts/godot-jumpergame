extends CharacterBody2D
class_name Player

var interactiblesInRange : Array = []
var moveDir : Vector2 = Vector2.ZERO

@export var gravity : float = 700
@export var acceleration : float = 1500
@export var airAcceleration : float = 200
@export var friction : float = 8
@export var airFriction : float = 2
@export var jumpPower : float = 200

@export var interactArrow : Node

func isDown(inputId) -> bool:
	return Input.is_action_pressed(inputId)

func isJustPressed(inputId) -> bool:
	return Input.is_action_just_pressed(inputId)

func jump() -> void:
	if (is_on_floor()):
		addVelocity(Vector2.UP * jumpPower)

func hasInteractibles() -> bool:
	return interactiblesInRange.size() > 0

func interact():
	if (hasInteractibles()):
		interactiblesInRange[0].emit_signal("interact")

func addVelocity(dir : Vector2) -> void:
	velocity += dir

func setVelocity(dir : Vector2) -> void:
	velocity = dir

func _physics_process(delta: float) -> void:
	if (isJustPressed("up")): ## ülesnool
		jump()
	if (isDown("right")): ## paremnool
		moveDir.x += 1
	if (isDown("left")): ## vasaknool
		moveDir.x -= 1
	if (isJustPressed("interact")): ## enter
		interact()
	
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
