extends Node2D
class_name Coin

onready var coin_sprite = $CoinSprite
onready var shadow_sprite = $ShadowSprite
onready var animation_player = $AnimationPlayer
onready var timer = $Timer


#### ACCESSORS ####

func is_class(value: String): return value == "Coin" or .is_class(value)
func get_class() -> String: return "Coin"


#### BUILT-IN ####

func _ready() -> void:
	animation_player.play("Wave")




#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####




func _on_AnimatedSprite_animation_finished() -> void:
	if coin_sprite.get_animation() == "Rotation":
		coin_sprite.play("Idle")
		shadow_sprite.play("Idle")
		timer.start()


func _on_Timer_timeout() -> void:
	if $CollectableBehaviour.state_machine.get_state_name() == "Idle":
		coin_sprite.play("Rotation")
		shadow_sprite.play("Rotation")

