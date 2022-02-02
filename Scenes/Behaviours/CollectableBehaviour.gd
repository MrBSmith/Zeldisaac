extends Behaviour
class_name CollectableBehaviour

signal collected

onready var state_machine = $StateMachine


#### LOGIC ####

func _follow_target(target: Node2D) -> void:
	state_machine.set_state("Follow")
	$StateMachine/Follow.target = target


func collect() -> void:
	state_machine.set_state("Collect")
	emit_signal("collected")
	EVENTS.emit_signal("object_collected", object)
	
	if $AnimationPlayer.has_animation("Collect"):
		$AnimationPlayer.play("Collect")
	else:
		object.queue_free()


#### SIGNAL RESPONSES ####


func _on_FollowArea_body_entered(body: Node) -> void:
	if state_machine.get_state_name() == "Idle":
		_follow_target(body)


func _on_StateMachine_state_changed(new_state: Node) -> void:
	if new_state.name == "Idle":
		for body in $FollowArea.get_overlapping_bodies():
			if body is Character:
				_follow_target(body)


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Collect":
		object.queue_free()
