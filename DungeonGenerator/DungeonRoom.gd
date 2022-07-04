extends Resource
class_name DungeonRoom

export var color : Color
export var cell := Vector2.INF
export var texture_matrix : Texture
var matrix : Array

#### ACCESSORS ####

func is_class(value: String): return value == "DungeonRoom" or .is_class(value)
func get_class() -> String: return "DungeonRoom"


#### BUILT-IN ####



#### VIRTUALS ####



#### LOGIC ####

func read_matrix_texture() -> void:
	matrix = []
	var image = texture_matrix.get_data()
	image.lock()
	
	for j in range(texture_matrix.get_size().x):
		matrix.append([])
		
		for i in range(texture_matrix.get_size().y):
			var pixel = image.get_pixel(j, i)
			matrix[j].append(int(pixel.r == 0))


func get_cells() -> Array:
	var cells = []
	for j in range(matrix.size()):
		for i in range(matrix[j].size()):
			cells.append(cell + Vector2(i, j))
	return cells


func is_cell_inside(c: Vector2) -> bool:
	return c in get_cells()


func is_room_adjacent(room: Object) -> bool:
	for c in room.get_cells():
		if is_cell_adjacent(c):
			return true
	return false


func is_cell_adjacent(c: Vector2) -> bool:
	for room_cell in get_cells():
		if Utils.are_cells_adjacents(room_cell, c):
			return true
	return false


func get_potential_door_slots(room: DungeonRoom) -> Array:
	var array = []
	for c in get_cells():
		for room_c in room.get_cells():
			if Utils.are_cells_adjacents(c, room_c):
				array.append(DungeonDoor.new(c, room_c))
	return array


#### INPUTS ####



#### SIGNAL RESPONSES ####
