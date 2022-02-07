extends Node2D
class_name ItemFactory

var item_scene = preload("res://Scenes/InteractiveObjects/Item/Item.tscn")
var coin_scene = preload("res://Scenes/InteractiveObjects/Coin/Coin.tscn")


func _ready() -> void:
	var __ = EVENTS.connect("spawn_coin", self, "_on_EVENTS_spawn_coin")
	__ = EVENTS.connect("spawn_item", self, "_on_EVENTS_spawn_item")


func _spawn_coin(pos) -> void:
	var coin = coin_scene.instance()
	
	coin.set_position(pos)
	owner.add_child(coin)
	

func _spawn_item(item_data: Object, pos: Vector2) -> void:
	var item = item_scene.instance()
	
	item.set_item_data(item_data)
	item.set_position(pos)
	owner.add_child(item)


func _on_EVENTS_spawn_item(item_data: Object, pos: Vector2) -> void:
	if item_data == coin_scene:
		_spawn_coin(pos)
	else:
		_spawn_item(item_data, pos)
