extends StaticBody2D

enum STATE {
	IDLE,
	BREAKING,
	BROKEN
} 

onready var animated_sprite = $AnimatedSprite
onready var collision_shape = $CollisionShape2D

var state = STATE.IDLE


func interact() -> void:
	if state != STATE.IDLE:
		return
	
	animated_sprite.play("Break")
	state = STATE.BREAKING


func _on_AnimatedSprite_animation_finished() -> void:
	if animated_sprite.animation == "Break":
		state = STATE.BROKEN
		collision_shape.set_disabled(true)
