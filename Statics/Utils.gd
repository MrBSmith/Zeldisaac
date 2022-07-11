extends Object
class_name Utils

const DIRECTIONS_4 = {
	"Up": Vector2.UP,
	"Right": Vector2.RIGHT,
	"Down": Vector2.DOWN,
	"Left": Vector2.LEFT
}


static func get_adjacents_cell(cell: Vector2) -> Array:
	var adjacents = []
	for dir in DIRECTIONS_4.values():
		adjacents.append(cell + dir)
	
	return adjacents
