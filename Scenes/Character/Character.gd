extends KinematicBody2D

onready var animated_sprite = get_node("AnimatedSprite")
onready var attack_area = get_node("AttackArea")
onready var attack_hit_box = get_node("AttackArea/Attack_HitBox")

enum STATE {
	IDLE,
	MOVE,
	ATTACK
}

var dir_dict: Dictionary = {
	"Left": Vector2.LEFT,
	"Right": Vector2.RIGHT,
	"Up": Vector2.UP,
	"Down": Vector2.DOWN
}

var speed = 300.0

var state : int = STATE.IDLE setget set_state
var state_name = "Idle"

var facing_direction = Vector2.DOWN setget set_facing_direction
var moving_direction = Vector2.ZERO setget set_moving_direction

var attack_hit_box_offset : float = 20.0

signal state_changed(state)
signal facing_direction_changed(dir)
signal moving_direction_changed(dir)

#### ACCESSORS ####

func set_state(value: int) -> void:
	if value != state:
		state = value
		emit_signal("state_changed", state)

func set_facing_direction(value: Vector2) -> void:
	if facing_direction != value:
		facing_direction = value
		emit_signal("facing_direction_changed", facing_direction)

func set_moving_direction(value: Vector2) -> void:
	if value != moving_direction:
		moving_direction = value
		emit_signal("moving_direction_changed", moving_direction)


#### BUILT-IN ####

func _process(_delta: float) -> void:
	var __ = move_and_slide(moving_direction * speed)


func _input(_event: InputEvent) -> void:
	var dir = Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)
	
	set_moving_direction(dir.normalized())
	
	if Input.is_action_just_pressed("ui_accept"):
		set_state(STATE.ATTACK)
		
	elif moving_direction != Vector2.ZERO:
		set_state(STATE.MOVE)
	
	else:
		if state == STATE.MOVE:
			set_state(STATE.IDLE)


#### LOGIC #### 

func _attack_effect() -> void:
	var bodies_array = attack_area.get_overlapping_bodies()
	for body in bodies_array:
		_interact_with(body)


func _interact_with(obj: Node2D) -> void:
	if obj == self:
		return
	
	if obj.has_method("interact"):
		obj.interact()


func _update_animation() -> void:
	var dir_index = dir_dict.values().find(facing_direction)
	var dir_name = dir_dict.keys()[dir_index]
	animated_sprite.play(state_name + dir_name)


#### SIGNAL RESPONSES ####

func _on_AnimatedSprite_animation_finished() -> void:
	if state == STATE.ATTACK:
		set_state(STATE.IDLE)


func _on_state_changed(character_state: int) -> void:
	match(character_state):
		STATE.IDLE: state_name = "Idle"
		STATE.MOVE: state_name = "Move"
		STATE.ATTACK: 
			state_name = "Attack"
			_attack_effect()
	
	_update_animation()


func _on_facing_direction_changed(dir: Vector2) -> void:
	attack_hit_box.position = dir * attack_hit_box_offset
	
	if dir == Vector2.LEFT or dir == Vector2.RIGHT:
		attack_hit_box.set_rotation_degrees(90)
	else:
		attack_hit_box.set_rotation_degrees(0)
	
	_update_animation()


func _on_moving_direction_changed(dir: Vector2) -> void:
	if dir == facing_direction or dir == Vector2.ZERO:
		return
	
	var sign_dir = Vector2(sign(dir.x), sign(dir.y))
	
	if sign_dir == dir:
		set_facing_direction(dir)
	else:
		if sign_dir.x == facing_direction.x:
			set_facing_direction(Vector2(sign_dir.x, 0))
		else:
			set_facing_direction(Vector2(0, sign_dir.y))
