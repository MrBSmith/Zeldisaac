extends Actor
class_name Character

#### ACCESSORS ####


#### BUILT-IN ####


func _input(_event: InputEvent) -> void:
	# Update the direction
	var dir = Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)
	
	set_moving_direction(dir.normalized())
	
	# Update the state based on the input
	if Input.is_action_just_pressed("ui_accept"):
		set_state(STATE.ATTACK)
	
	if state != STATE.ATTACK:
		if moving_direction == Vector2.ZERO:
			set_state(STATE.IDLE)
		else:
			set_state(STATE.MOVE)


#### LOGIC ####


func _interaction_attempt() -> bool:
	var bodies_array = attack_hit_box.get_overlapping_bodies()
	var attempt_success = false
	
	for body in bodies_array:
		if body.has_method("interact"):
			body.interact()
			attempt_success = true
	
	return attempt_success


#### SIGNAL RESPONSES ####



func _on_state_changed() -> void:
	if state == STATE.ATTACK:
		if _interaction_attempt():
			set_state(STATE.IDLE)
	
	._on_state_changed()



