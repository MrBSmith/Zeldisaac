extends Node2D
class_name DungeonGenerator


enum CELL_TYPE {
	EMPTY,
	WALL
}

onready var automatas_array : Array = Utils.fetch(self, "CellularAutomata")
onready var tilemap = $TileMap
export var room_types : Array = []

export var delay_btw_steps = 0.5
export var grid_size = Vector2(10, 10)

var grid : Array

var generation_ungoing : bool = false

var dungeon_cells = []
var free_cells = []
var cell_distance_array = []
var rooms_array = []
var doors_array = []

var entry_cell := Vector2.INF
var exit_cell := Vector2.INF

class CellDistance:
	var cell := Vector2.INF
	var dist : int = -1
	
	func _init(_cell: Vector2, _dist: int) -> void:
		cell = _cell
		dist = _dist


#### ACCESSORS ####

func is_class(value: String): return value == "DungeonGenerator" or .is_class(value)
func get_class() -> String: return "DungeonGenerator"


#### BUILT-IN ####

func _ready() -> void:
	for room_type in room_types:
		room_type.read_matrix_texture()
	
	generate_dungeon()


#### VIRTUALS ####



#### LOGIC ####


func find_path_to_exit(cell: Vector2 = exit_cell, path: Array = [exit_cell]) -> Array:
	var adjacents = Utils.get_adjacents(cell)
	var cell_dist_array = []
	
	for cell_dist in cell_distance_array:
		if cell_dist.cell in adjacents:
			cell_dist_array.append(cell_dist)
	
	var closest_cell = find_smallest_dist_cell(cell_dist_array)
	 
	path.append(closest_cell)
	
	if closest_cell != entry_cell:
		var __ = find_path_to_exit(closest_cell, path)
	else:
		path.invert()
	
	return path


func find_smallest_dist_cell(cell_dist_array: Array) -> Vector2:
	var smallest_dist = INF
	var closest_cell = Vector2.INF
	for cell_dist in cell_dist_array:
		if cell_dist.dist < smallest_dist:
			smallest_dist = cell_dist.dist
			closest_cell = cell_dist.cell
	return closest_cell


func generate_dungeon() -> void:
	generation_ungoing = true
	cell_distance_array = []
	
	init_grid()
	
	while(get_dungeon_depth() < 6 or cell_distance_array.empty()):
		init_grid()
		doors_array = []
		rooms_array = []
		free_cells = []
		automatas_array = []
		cell_distance_array = []
		dungeon_cells = []
		entry_cell = rdm_border_grid_cell()
		generate_automata(entry_cell, 5, 4)
		
		while(!automatas_array.empty()):
			if delay_btw_steps > 0.0:
				yield(get_tree().create_timer(delay_btw_steps), "timeout")

			for automata in automatas_array:
				var adjacents_cells = get_reachable_cells(automata.cell)
				automata.step(adjacents_cells) 
		
		compute_cell_distances(entry_cell)
	
	free_cells = Array(dungeon_cells)
	update_cell_distance_display()
	place_entry_and_exit()
	
	place_every_rooms()
	update_room_display()
	
	var path = find_path_to_exit()
	
	place_doors_along_path(path)
	place_rooms_doors()
	update_doors_display()
	
	generation_ungoing = false


func place_doors_along_path(path: Array) -> void:
	var previous_room = null
	
	for i in range(path.size()):
		var cell = path[i]
		var current_room = cell_get_room(cell)
		
		if previous_room != null && current_room != previous_room:
			place_door(path[i - 1], cell)
		
		previous_room = current_room


func place_rooms_doors() -> void:
	var ordered_rooms_dict = order_rooms_by_nb_adj_rooms()
	
	var ordered_keys = order_int_array(ordered_rooms_dict.keys())
	
	for nb_adj in ordered_keys:
		for room in ordered_rooms_dict[nb_adj]:
			var doors = room_get_doors(room)
			
			if doors.size() >= nb_adj:
				continue
			
			var adj_rooms_array = room_get_adjacents_rooms(room)
			adj_rooms_array.shuffle()
			
			# Remove already connected rooms
			var nb_adjs_rooms = adj_rooms_array.size()
			for i in range(nb_adjs_rooms):
				var id = nb_adjs_rooms - 1 - i
				
				var adj_room = adj_rooms_array[id]
				
				if are_rooms_connected(room, adj_room):
					adj_rooms_array.remove(id)
			
			
			var nb_doors_to_place = int(clamp(2 - doors.size(), 0, 2))
			
			# Place missing doors
			for _i in range(nb_doors_to_place):
				if adj_rooms_array.empty():
					break
				
				var adj_room = adj_rooms_array.pop_front()
				
				place_door_between_rooms(room, adj_room)


func place_door_between_rooms(room1: DungeonRoom, room2: DungeonRoom) -> void:
	if !room1.is_room_adjacent(room2):
		push_error("The given rooms arn't adjacents: cannot add a door between it")
		return
	
	var potential_doors = room1.get_potential_door_slots(room2)
	potential_doors.shuffle()

	var rdm_door = potential_doors[0]
	doors_array.append(rdm_door)


func are_rooms_connected(room1: DungeonRoom, room2: DungeonRoom) -> bool:
	for door in doors_array:
		if (room1.is_cell_inside(door.from) or room1.is_cell_inside(door.to)) && \
			(room2.is_cell_inside(door.from) or room2.is_cell_inside(door.to)):
			return true
	return false


func room_get_doors(room: DungeonRoom) -> Array:
	var room_doors = []
	for door in doors_array:
		if room.is_cell_inside(door.from) or room.is_cell_inside(door.to):
			room_doors.append(door)
	return room_doors


func order_int_array(array: Array) -> Array:
	var ordered_array = array.duplicate()
	
	for value in array:
		if ordered_array.empty():
			ordered_array.append(value)
			continue
		
		for i in range(ordered_array.size()):
			var ordered_value = ordered_array[i]
			if value < ordered_value:
				ordered_array.insert(i, value)
	
	return ordered_array


func place_door(from: Vector2, to: Vector2) -> void:
	var door = DungeonDoor.new(from, to)
	doors_array.append(door)


func order_rooms_by_nb_adj_rooms() -> Dictionary:
	var ordered_rooms_dict = {}
	
	for room in rooms_array:
		var nb_adjs = room_get_adjacents_rooms(room).size()
		
		if ordered_rooms_dict.has(nb_adjs):
			ordered_rooms_dict[nb_adjs].append(room)
		else:
			ordered_rooms_dict[nb_adjs] = [room]
	
	return ordered_rooms_dict


func room_get_adjacents_rooms(room: Object) -> Array:
	var adjacents_rooms = []
	
	for r in rooms_array:
		if r == room:
			continue
		
		if r.is_room_adjacent(room):
			adjacents_rooms.append(r)
	
	return adjacents_rooms


func update_doors_display() -> void:
	Utils.clear($Doors)
	
	for door in doors_array:
		var color_rect = ColorRect.new()
		var door_rect_size = Vector2.ONE * 4
		
		var cell_size = tilemap.cell_size * tilemap.scale
		var pos = ((door.to + door.from) / 2.0) * cell_size + (cell_size / 2.0)
		
		color_rect.set_size(door_rect_size)
		color_rect.set_position(pos)
		color_rect.color = Color.black
		$Doors.add_child(color_rect)


func cell_get_room(cell: Vector2) -> DungeonRoom:
	for room in rooms_array:
		if room.is_cell_inside(cell):
			return room
	return null


func get_dungeon_depth() -> int:
	var max_depth = 0
	for cell_dist in cell_distance_array:
		if cell_dist.dist > max_depth:
			max_depth = cell_dist.dist
	return max_depth


func place_entry_and_exit() -> void:
	for child in $EntryExitCells.get_children():
		child.queue_free()
	
	var furtherest_cells = get_furtherest_cells()
	exit_cell = furtherest_cells[randi() % furtherest_cells.size()]
	
	var entry_tile_id = tilemap.tile_set.find_tile_by_name("Entry")
	var exit_tile_id = tilemap.tile_set.find_tile_by_name("Exit")
	
	tilemap.set_cellv(entry_cell, entry_tile_id)
	tilemap.set_cellv(exit_cell, exit_tile_id)


func place_every_rooms() -> void:
	for room in room_types:
		var room_matrix = room.matrix
		var room_slot_cells_array = find_room_slots(room_matrix)
		room_slot_cells_array.shuffle()
		
		for _i in range(room_slot_cells_array.size()):
			var room_slot_cell = room_slot_cells_array.pop_front()
			
			if !can_place_room(room_slot_cell, room_matrix):
				continue
			
			place_room(room_slot_cell, room)


func update_room_display() -> void:
	Utils.clear($Rooms)
	
	for room in rooms_array:
		for room_cell in room.get_cells():
			var color_rect = ColorRect.new()
			color_rect.set_frame_color(room.color)
			color_rect.color.a = 0.4
			
			color_rect.set_position(room_cell * tilemap.cell_size * tilemap.scale)
			color_rect.set_size(tilemap.cell_size * tilemap.scale)
			
			$Rooms.add_child(color_rect)


func place_room(cell: Vector2, room_type: DungeonRoom) -> void:
	var room = room_type.duplicate()
	room.cell = cell
	room.matrix = room_type.matrix
	
	rooms_array.append(room)
	
	for room_cell in room.get_cells():
		if room_cell in free_cells:
			free_cells.erase(room_cell)


func find_room_slots(room_matrix: Array) -> Array:
	var possible_cells = []
	
	for cell in free_cells:
		if can_place_room(cell, room_matrix):
			possible_cells.append(cell)
	
	return possible_cells


func can_place_room(cell: Vector2, room_matrix: Array) -> bool:
	for j in range(room_matrix.size()):
		for i in range(room_matrix[j].size()):
			if room_matrix[j][i] == 0:
				continue
			
			var room_cell = cell + Vector2(i, j)
			if not room_cell in free_cells:
				return false
	return true


func get_furtherest_cells() -> PoolVector2Array:
	var dungeon_depth = get_dungeon_depth()
	var cells_array = PoolVector2Array()
	
	for cell_dist in cell_distance_array:
		if cell_dist.dist == dungeon_depth:
			cells_array.append(cell_dist.cell)
	return cells_array


func compute_cell_distances(cell: Vector2, distance: int = 0) -> void:
	if cell_distance_array.empty():
		cell_distance_append_cell(cell, 0)
	
	distance += 1
	
	var adjacents = Utils.get_adjacents(cell)
	
	for adj in adjacents:
		var tile_id = tilemap.get_cell(adj.x, adj.y)
		
		if tile_id != -1 or !is_inside_grid(adj):
			continue
			
		var cell_dist = get_cell_dist(adj)
		
		if cell_dist == null:
			cell_distance_append_cell(adj, distance)
			compute_cell_distances(adj, distance)
		
		elif cell_dist.dist > distance:
			cell_dist.dist = distance
			compute_cell_distances(adj, distance)


func get_cell_dist(cell: Vector2) -> CellDistance:
	for cell_dist in cell_distance_array:
		if cell_dist.cell.is_equal_approx(cell):
			return cell_dist
	return null


func cell_distance_append_cell(cell: Vector2, dist: int) -> void:
	var cell_dist = CellDistance.new(cell, dist)
	cell_distance_array.append(cell_dist)


func cell_distance_has_cell(cell: Vector2) -> bool:
	for cell_dist in cell_distance_array:
		if cell_dist.cell.is_equal_approx(cell):
			return true
	return false 


func update_cell_distance_display() -> void:
	Utils.clear($CellDistances)
	
	if $CellDistances.get_child_count() > 0:
		var last_child_id = $CellDistances.get_child_count() - 1
		yield($CellDistances.get_child(last_child_id), "tree_exited")
	
	for cell_dist in cell_distance_array:
		var label = Label.new()
		label.set_text(str(cell_dist.dist))
		label.align = Label.ALIGN_CENTER
		var pos = cell_dist.cell * tilemap.cell_size * tilemap.scale
		label.set_position(pos)
		
		$CellDistances.add_child(label)


func rdm_grid_cell() -> Vector2:
	return Vector2(randi() % int(grid_size.x), 
					randi() % int(grid_size.y))


func rdm_border_grid_cell() -> Vector2:
	var rdm_cell = rdm_grid_cell()
	if randi() % 2 == 1:
		rdm_cell.x = randi() % 2 * (grid_size.x - 1)
	else:
		rdm_cell.y = randi() % 2 * (grid_size.y - 1)
	return rdm_cell


func check_dungeon_validity() -> void:
	pass


func generate_automata(start_cell: Vector2, max_steps : int = 15, sub_automatas: int = 0) -> void:
	var automata = CellularAutomata.new()
	automata.max_steps = max_steps
	automata.sub_automatas = sub_automatas
	
	add_child(automata)
	
	if !automata.is_inside_tree():
		yield(automata, "ready")
	
	var __ = automata.connect("moved", self, "_on_automata_moved")
	automata.connect("arrived", self, "_on_automata_arrived", [automata])
	automata.connect("sub_automata_creation", self, "_on_automata_sub_automata_creation")
	
	automata.set_cell(start_cell)
	
	automatas_array.append(automata)


func init_grid() -> void:
	grid = []
	
	for j in range(grid_size.y):
		grid.append([])
		
		for i in range(grid_size.x):
			grid[j].append(1)
			$TileMap.set_cellv(Vector2(i, j), 0)


func get_reachable_cells(cell: Vector2) -> PoolVector2Array:
	var adjacents = PoolVector2Array([])
	for dir in Utils.DIRECTIONS_4.values():
		var adj = cell + dir
		
		if is_inside_grid(adj) && is_cell_wall(adj):
			adjacents.append(adj)
		
	return adjacents


func is_inside_grid(cell: Vector2) -> bool:
	return cell.x >= 0 && cell.x < grid_size.x && \
		cell.y >= 0 && cell.y < grid_size.y


func is_cell_wall(cell: Vector2) -> bool:
	return grid[cell.y][cell.x] == 1


func set_grid_cell(cell: Vector2, cell_type: int) -> void:
	grid[cell.y][cell.x] = cell_type
	$TileMap.set_cellv(cell, cell_type - 1)


#### INPUTS ####


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		generate_dungeon()



#### SIGNAL RESPONSES ####

func _on_automata_moved(cell: Vector2) -> void:
	set_grid_cell(cell, CELL_TYPE.EMPTY)
	
	if not cell in dungeon_cells:
		dungeon_cells.append(cell)


func _on_automata_arrived(automata: CellularAutomata) -> void:
	automatas_array.erase(automata)
	automata.queue_free()


func _on_automata_sub_automata_creation(cell: Vector2, max_steps: int, sub_automatas: int) -> void:
	generate_automata(cell, max_steps, sub_automatas)
