extends State
class_name CollectableSpawnState

onready var spawn_duration_timer = $SpawnDurationTimer

const GRAVITY := 40.0

var spawn_v_force : float = -400.0
var spawn_dir_force : float = 200.0
var spawn_dir := Vector2.ZERO
var spawn_dir_velocity := Vector2.ZERO
var damping := 20.0


func _ready() -> void:
	var __ = spawn_duration_timer.connect("timeout", self, "_on_SpawnDurationTimer_timeout")


func enter_state() -> void:
	var rdm_angle = deg2rad(rand_range(0.0, 360.0))
	spawn_dir = Vector2(sin(rdm_angle), cos(rdm_angle))
	spawn_duration_timer.start()


func update(delta: float) -> void:
	spawn_v_force += GRAVITY
	var spawn_v_velocity = Vector2(0.0, spawn_v_force)
	spawn_dir_velocity = spawn_dir * spawn_dir_force
	spawn_dir_velocity = spawn_dir_velocity.clamped(spawn_dir_velocity.length() - damping)
	
	var velocity = spawn_v_velocity + spawn_dir_velocity
	owner.object.position += velocity * delta


func _on_SpawnDurationTimer_timeout() -> void:
	get_parent().set_state("Idle")
