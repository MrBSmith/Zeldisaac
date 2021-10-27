extends StaticBody2D

onready var animated_sprite = $AnimatedSprite

enum STATE{
	IDLE,
	OPEN,
	OPENED
}

var state = STATE.IDLE


func interact() -> void:
	if state == STATE.IDLE:
		state = STATE.OPEN
		animated_sprite.play("Open")


func _on_AnimatedSprite_animation_finished() -> void:
	state = STATE.OPENED
