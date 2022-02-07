extends StaticBody2D

onready var animated_sprite = $AnimatedSprite
onready var collision_shape = $CollisionShape2D

enum STATE {
	IDLE,
	BREAKING,
	BROKEN
}

var state : int = STATE.IDLE


func destroy() -> void:
	if state != STATE.IDLE:
		return
	
	EVENTS.emit_signal("obstacle_destroyed", self)
	
	state = STATE.BREAKING
	animated_sprite.play("Break")
	$DropperBehaviour.drop_item()



func _on_AnimatedSprite_animation_finished() -> void:
	if animated_sprite.get_animation() == "Break":
		state = STATE.BROKEN
		collision_shape.set_disabled(true)
