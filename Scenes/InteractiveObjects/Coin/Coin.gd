extends Node2D
class_name Coin

onready var state_machine = $StateMachine
onready var coin_sprite = $CoinSprite
onready var shadow_sprite = $ShadowSprite
onready var collect_sound = $CollectSound
onready var particules = $Particles2D
onready var animation_player = $AnimationPlayer
onready var timer = $Timer


#### ACCESSORS ####

func is_class(value: String): return value == "Coin" or .is_class(value)
func get_class() -> String: return "Coin"


#### BUILT-IN ####

func _ready() -> void:
	animation_player.play("Wave")


func _follow_target(target: Node2D) -> void:
	state_machine.set_state("Follow")
	$StateMachine/Follow.target = target


#### VIRTUALS ####



#### LOGIC ####

func collect() -> void:
	state_machine.set_state("Collect")
	collect_sound.play()
	particules.set_emitting(true)
	
	coin_sprite.set_visible(false)
	shadow_sprite.set_visible(false)
	EVENTS.emit_signal("coin_collected")
	
	yield(collect_sound, "finished")
	
	queue_free()


#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_FollowArea_body_entered(body: Node) -> void:
	if state_machine.get_state_name() == "Idle":
		_follow_target(body)


func _on_AnimatedSprite_animation_finished() -> void:
	if coin_sprite.get_animation() == "Rotation":
		coin_sprite.play("Idle")
		shadow_sprite.play("Idle")
		timer.start()


func _on_Timer_timeout() -> void:
	if state_machine.get_state_name() == "Idle":
		coin_sprite.play("Rotation")
		shadow_sprite.play("Rotation")


func _on_StateMachine_state_changed(new_state: Node) -> void:
	if new_state.name == "Idle":
		for body in $Area2D.get_overlapping_bodies():
			if body is Character:
				_follow_target(body)
