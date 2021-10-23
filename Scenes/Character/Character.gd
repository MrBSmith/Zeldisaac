extends KinematicBody2D

onready var animated_sprite = get_node("AnimatedSprite")
onready var attack_area = get_node("AttackArea")
onready var attack_hit_box = get_node("AttackArea/Attack_HitBox")

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
var attack_hit_box_offset : float = 20.0

signal state_changed(state)
signal facing_direction_changed(dir)

func set_state(value: int) -> void:
	if value != state:
		state = value
		emit_signal("state_changed", state)

func set_facing_direction(value: Vector2) -> void:
	if facing_direction != value:
		facing_direction = value
		emit_signal("facing_direction_changed", facing_direction)


func _process(_delta: float) -> void:
	var __ = move_and_slide(moving_direction * speed)


func _input(_event: InputEvent) -> void:
	moving_direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	moving_direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	moving_direction = moving_direction.normalized()
	
	if moving_direction != Vector2.ZERO:
		set_facing_direction(moving_direction)
	
	match(facing_direction):
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


func _attack_effect() -> void:
	var bodies_array = attack_area.get_overlapping_bodies()
	for body in bodies_array:
		_interact_with(body)


func _interact_with(obj: Node2D) -> void:
	if obj == self:
		return
	
	if obj.has_method("interact"):
		obj.interact()


func _on_AnimatedSprite_animation_finished() -> void:
	if state == STATE.ATTACK:
		set_state(STATE.IDLE)


func _on_state_changed(character_state: int) -> void:
	var state_name = ""
	
	match(character_state):
		STATE.IDLE: 
			state_name = "Idle"
		STATE.MOVE: 
			state_name = "Move"
		STATE.ATTACK: 
			state_name = "Attack"
			_attack_effect()
	
	animated_sprite.play(state_name + dir_string)


func _on_facing_direction_changed(dir: Vector2) -> void:
	attack_hit_box.position = dir * attack_hit_box_offset
	
	if dir == Vector2.LEFT or dir == Vector2.RIGHT:
		attack_hit_box.set_rotation_degrees(90)
	else:
		attack_hit_box.set_rotation_degrees(0)
