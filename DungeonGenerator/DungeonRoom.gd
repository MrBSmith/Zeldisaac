extends Resource
class_name DungeonRoom

export var color : Color
export var cell := Vector2.INF
export var matrix : Array

#### ACCESSORS ####

func is_class(value: String): return value == "DungeonRoom" or .is_class(value)
func get_class() -> String: return "DungeonRoom"


#### BUILT-IN ####



#### VIRTUALS ####



#### LOGIC ####

func is_cell_inside(c: Vector2) -> bool:
	for j in range(matrix.size()):
		for i in range(matrix[j].size()):
			if c.is_equal_approx(cell + Vector2(i, j)):
				return true
	return false


#### INPUTS ####



#### SIGNAL RESPONSES ####
