extends StaticBody2D

onready var state_machine = $StateMachine
onready var animated_sprite = $AnimatedSprite


func interact() -> void:
	if state_machine.get_state_name() == "Idle":
		state_machine.set_state("Open")
		animated_sprite.play("Open")


func _spawn_content() -> void:
	EVENTS.emit_signal("spawn_coin", position)


func _on_AnimatedSprite_animation_finished() -> void:
	state_machine.set_state("Opened")
	_spawn_content()
