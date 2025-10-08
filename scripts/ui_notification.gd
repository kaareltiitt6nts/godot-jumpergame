extends PanelContainer
class_name UiNotification

signal finished

@export var onscreenPos : Vector2 = Vector2(170, 20)
@export var offscreenPos : Vector2 = Vector2(170, -100)
@export var lifetime : float = 4
@export var inTime : float = 0.5
@export var outTime : float = 0.5

@onready var label : Label = $Label
@onready var soundPlayer : AudioStreamPlayer2D = $NotificationSound

func setLabel(text : String):
	label.text = text

func _ready() -> void:
	position = offscreenPos
	soundPlayer.play()
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", onscreenPos, inTime)
	tween.tween_interval(lifetime)
	tween.tween_property(self, "position", offscreenPos, outTime)
	tween.tween_callback(_on_tween_finished)

func _on_tween_finished() -> void:
	queue_free()
	emit_signal("finished")
