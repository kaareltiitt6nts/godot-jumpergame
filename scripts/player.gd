extends CharacterBody2D
class_name Player

var interactiblesInRange : Array = []
var moveDir : Vector2 = Vector2.ZERO

@export var gravity : float = 2000
@export var playerSpeed : float = 30
@export var friction : float = 25
@export var jumpPower : float = 400

@export var interactArrow : Node

func _ready() -> void:
	for interactible in get_tree().get_nodes_in_group("interactible"):
		interactible.connect("player_entered", _on_interactible_entered)
		interactible.connect("player_exited", _on_interactible_exited)

func isDown(inputId) -> bool:
	return Input.is_action_pressed(inputId)

func isJustPressed(inputId) -> bool:
	return Input.is_action_just_pressed(inputId)

func jump() -> void:
	if (is_on_wall_only()):
		velocity += Vector2.UP * jumpPower + Vector2.LEFT * 1000
		pass
	
	if (is_on_floor()):
		velocity += Vector2.UP * jumpPower

func hasInteractibles() -> bool:
	return interactiblesInRange.size() > 0

func interact():
	if (hasInteractibles()):
		interactiblesInRange[0].emit_signal("interact")

func _process(delta: float) -> void:
	if (isJustPressed("up")): ## ülesnool
		jump()
	if (isDown("right")): ## paremnool
		moveDir += Vector2.RIGHT
	if (isDown("left")): ## vasaknool
		moveDir += Vector2.LEFT
	if (isJustPressed("interact")): ## enter
		interact()
	
	var horizontalSpeed : Vector2 = moveDir * playerSpeed
	var verticalSpeed : Vector2 = Vector2.DOWN * gravity * delta
	
	velocity += horizontalSpeed + verticalSpeed
	
	if (is_on_wall_only()):
		var wallNormal = get_wall_normal()
		var wallDot = wallNormal.dot(moveDir)
		var movingToWall = wallDot == -1
		
		if (movingToWall):
			velocity.y = minf(velocity.y, 10)
	
	interactArrow.visible = hasInteractibles()
	
	move_and_slide()
	
	moveDir = Vector2.ZERO;
	velocity.x = lerpf(velocity.x, 0, friction * delta)

func _on_interactible_entered(interactible: Interactible):
	print(interactible)
	interactiblesInRange.append(interactible)

func _on_interactible_exited(interactible: Interactible):
	print(interactible)
	interactiblesInRange.erase(interactible)
