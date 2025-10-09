extends CanvasLayer
class_name UIController

@export var notificationScene : PackedScene
@onready var notifications : Control = $Notifications
@onready var fadeBlack : TextureRect = $FadeBlack

var notificationQueue : Array[String] = []
var notificationActive = false

func _on_notification_finished() -> void:
	notificationActive = false
	if notificationQueue.size() > 0:
		var notificationText = notificationQueue[0]
		if notificationText:
			createNotification(notificationText)
			notificationQueue.remove_at(0)
			return

func createNotification(text) -> void:
	if notificationActive:
		notificationQueue.push_back(text)
		return
	
	var uiNotification : UiNotification = notificationScene.instantiate()
	notifications.add_child(uiNotification)
	uiNotification.setLabel(text)
	uiNotification.finished.connect(_on_notification_finished)
	notificationActive = true

func fadeIn(time : float):
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD)
	fadeBlack.modulate.a = 1
	tween.tween_property(fadeBlack, "modulate:a", 0, time)

func fadeOut(time : float):
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD)
	fadeBlack.modulate.a = 0
	tween.tween_property(fadeBlack, "modulate:a", 1, time)
