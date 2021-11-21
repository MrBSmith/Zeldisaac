extends Node2D

var coin_scene = preload("res://Scenes/InteractiveObjects/Coin/Coin.tscn")


func _ready() -> void:
	var __ = EVENTS.connect("spawn_coin", self, "_on_EVENTS_spawn_coin")



func _spawn_coin(pos: Vector2) -> void:
	var coin = coin_scene.instance()
	
	coin.set_position(pos)
	owner.add_child(coin)



func _on_EVENTS_spawn_coin(pos: Vector2) -> void:
	_spawn_coin(pos)
