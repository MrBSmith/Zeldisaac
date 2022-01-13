extends StaticBody2D
class_name Door

func _ready() -> void:
	var __ = EVENTS.connect("room_finished", self, "_on_EVENTS_room_finished")


func open() -> void:
	$GridSprite.play("Lock", true)
	$DoorSprite.play("Open")
	$CollisionShape2D.set_disabled(true)


func _on_EVENTS_room_finished() -> void:
	open()
