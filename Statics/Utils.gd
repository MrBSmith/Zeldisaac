extends Node
class_name Utils

enum ROTATION {
	FORWARD,
	CLOCKWISE,
	CONTER_CLOCKWISE
}

const DIRECTIONS_4 : Dictionary = {
	"Right": Vector2.RIGHT,
	"Down": Vector2.DOWN,
	"Left": Vector2.LEFT,
	"Up": Vector2.UP,
}

const DIRECTIONS_8 : Dictionary = {
	"Right": Vector2.RIGHT,
	"DownRight": Vector2(1, 1),
	"Down": Vector2.DOWN,
	"DownLeft": Vector2(-1, 1),
	"Left": Vector2.LEFT,
	"UpLeft": Vector2(-1, -1),
	"Up": Vector2.UP,
	"UpRight": Vector2(1, -1)
}


static func rdm_4_dir() -> Vector2:
	var rdm_id = randi() % DIRECTIONS_4.size()
	return DIRECTIONS_4.values()[rdm_id]


static func rdm_8_dir() -> Vector2:
	var rdm_id = randi() % DIRECTIONS_8.size()
	return DIRECTIONS_8.values()[rdm_id]


static func fetch(node: Node, wanted_class: String) -> Array:
	var array = []
	for child in node.get_children():
		if child.is_class(wanted_class):
			array.append(child)
	return array


static func get_adjacents(cell: Vector2) -> PoolVector2Array:
	var adjacents = PoolVector2Array()
	for dir in DIRECTIONS_4.values():
		adjacents.append(cell + dir)
	
	return adjacents

