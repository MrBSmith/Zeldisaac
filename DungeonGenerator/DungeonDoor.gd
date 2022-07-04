extends Node
class_name DungeonDoor

var from : Vector2
var to : Vector2


#### ACCESSORS ####

func is_class(value: String): return value == "DungeonDoor" or .is_class(value)
func get_class() -> String: return "DungeonDoor"


#### BUILT-IN ####

func _init(from_cell: Vector2, to_cell: Vector2) -> void:
	from = from_cell
	to = to_cell



#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####
