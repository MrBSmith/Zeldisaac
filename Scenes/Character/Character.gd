extends KinematicBody2D

onready var animated_sprite = get_node("AnimatedSprite")

enum STATE {
	IDLE,
	MOVE,
	ATTACK
}

var speed = 300.0
var facing_direction = Vector2.DOWN
var moving_direction = Vector2.ZERO

var dir_string = ""
var state : int = STATE.IDLE

signal state_changed(state)


func set_state(value: int) -> void:
	if value != state:
		state = value
		emit_signal("state_changed", state)


func _process(_delta: float) -> void:
	move_and_slide(moving_direction * speed)


func _input(_event: InputEvent) -> void:
	moving_direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	moving_direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	if moving_direction != Vector2.ZERO:
		facing_direction = moving_direction
	
	moving_direction = moving_direction.normalized()
	
	var dir = moving_direction if state == STATE.MOVE else facing_direction
	
	match(dir):
		Vector2.LEFT: dir_string = "Left"
		Vector2.RIGHT: dir_string = "Right"
		Vector2.UP: dir_string = "Up"
		Vector2.DOWN: dir_string = "Down"
	
	if Input.is_action_just_pressed("ui_accept"):
		set_state(STATE.ATTACK)
		
	elif moving_direction != Vector2.ZERO:
		set_state(STATE.MOVE)
	
	else:
		if state == STATE.MOVE:
			set_state(STATE.IDLE)



func _on_AnimatedSprite_animation_finished() -> void:
	if state == STATE.ATTACK:
		set_state(STATE.IDLE)



func _on_state_changed(character_state: int) -> void:
	var state_name = ""
	
	match(character_state):
		STATE.IDLE: state_name = "Idle"
		STATE.MOVE: state_name = "Move"
		STATE.ATTACK: state_name = "Attack"
	
	animated_sprite.play(state_name + dir_string)
