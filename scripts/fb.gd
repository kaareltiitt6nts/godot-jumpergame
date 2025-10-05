extends CharacterBody2D


const SPEED = 25.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	# LISAKOMMENTAAR: Sinu kood lisab siin iga kaader gravitatsiooni. 
	# See on mängija koodi jaoks õige, aga mitte hõljuva vaenlase jaoks!
	
	velocity.y += gravity * delta # Üks taane
	velocity.x = -SPEED           # Üks taane
		
	update_animation()            # Üks taane
	move_and_slide()              # Üks taane

func update_animation():
	animated_sprite_2d.play("default")
