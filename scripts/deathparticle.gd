extends Node2D

@onready var particle : CPUParticles2D = $CPUParticles2D

func _ready() -> void:
	particle.emitting = true

func _on_cpu_particles_2d_finished() -> void:
	queue_free()
