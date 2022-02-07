extends Node2D
class_name Item

export var item_data : Resource = null setget set_item_data


func set_item_data(value: Resource) -> void:
	item_data = value
	if item_data != null:
		$Sprite.set_texture(item_data.world_texture)
