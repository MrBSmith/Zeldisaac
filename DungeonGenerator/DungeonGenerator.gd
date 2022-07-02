extends Node2D
class_name DungeonGenerator

enum CELL_TYPE{
	EMPTY,
	WALL
}

export var delay_btw_steps = 0.5

onready var automatas_array : Array = Utils.fetch(self, "CellularAutomata")
onready var tilemap = $TileMap

export var grid_size = Vector2(10, 10)
var grid : Array

var generation_ungoing : bool = false

var cell_distance_array = []

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
	generate_dungeon()


#### VIRTUALS ####



#### LOGIC ####

func generate_dungeon() -> void:
	generation_ungoing = true
	
	automatas_array = []
	cell_distance_array = []
	init_grid()
	
	while(get_dungeon_depth() < 6):
		init_grid()
		automatas_array = []
		cell_distance_array = []
		entry_cell = rdm_border_grid_cell()
		generate_automata(entry_cell, 5, 4)
		
		while(!automatas_array.empty()):
			if delay_btw_steps > 0.0:
				yield(get_tree().create_timer(delay_btw_steps), "timeout")

			for automata in automatas_array:
				var adjacents_cells = get_reachable_cells(automata.cell)
				automata.step(adjacents_cells)
		
		compute_cell_distances(entry_cell)
	
	update_cell_distance_display()
	place_entry_and_exit()
	
	generation_ungoing = false


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
	clear_cell_distance_display()
	
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


func clear_cell_distance_display() -> void:
	for child in $CellDistances.get_children():
		child.queue_free()


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


func _on_automata_arrived(automata: CellularAutomata) -> void:
	automatas_array.erase(automata)
	automata.queue_free()


func _on_automata_sub_automata_creation(cell: Vector2, max_steps: int, sub_automatas: int) -> void:
	generate_automata(cell, max_steps, sub_automatas)
