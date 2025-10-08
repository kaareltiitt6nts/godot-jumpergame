extends CanvasLayer
class_name UIController

@export var notificationScene : PackedScene
@onready var notifications : Control = $Notifications

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
