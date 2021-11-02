extends Node2D
class_name Coin

enum STATE {
	SPAWN,
	IDLE,
	FOLLOW,
	COLLECT
}

onready var coin_sprite = $CoinSprite
onready var shadow_sprite = $ShadowSprite
onready var collect_sound = $CollectSound
onready var particules = $Particles2D
onready var animation_player = $AnimationPlayer
onready var timer = $Timer

var state = STATE.IDLE

var speed = 400.0
var target : Node2D = null


#### ACCESSORS ####

func is_class(value: String): return value == "Coin" or .is_class(value)
func get_class() -> String: return "Coin"


#### BUILT-IN ####

func _ready() -> void:
	set_process(false)
	animation_player.play("Wave")


func _physics_process(delta: float) -> void:
	if target == null:
		return
	
	var target_pos = target.get_position()
	var dist = position.distance_to(target_pos)
	var spd = speed * delta
	
	if dist < spd:
		position = target_pos
		if state == STATE.FOLLOW:
			collect()
	else:
		position = position.move_toward(target_pos, spd)


#### VIRTUALS ####



#### LOGIC ####

func collect() -> void:
	state = STATE.COLLECT
	collect_sound.play()
	particules.set_emitting(true)
	
	coin_sprite.set_visible(false)
	shadow_sprite.set_visible(false)
	
	yield(collect_sound, "finished")
	
	queue_free()


#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_FollowArea_body_entered(body: Node) -> void:
	if state == STATE.IDLE:
		state = STATE.FOLLOW
		target = body
		set_process(true)


func _on_AnimatedSprite_animation_finished() -> void:
	if coin_sprite.get_animation() == "Rotation":
		coin_sprite.play("Idle")
		shadow_sprite.play("Idle")
		timer.start()


func _on_Timer_timeout() -> void:
	if state == STATE.IDLE:
		coin_sprite.play("Rotation")
		shadow_sprite.play("Rotation")
