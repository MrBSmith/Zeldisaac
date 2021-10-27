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
	
	state = STATE.BREAKING
	animated_sprite.play("Break")



func _on_AnimatedSprite_animation_finished() -> void:
	if animated_sprite.get_animation() == "Break":
		state = STATE.BROKEN
		collision_shape.set_disabled(true)
