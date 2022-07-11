extends Node2D
class_name DungeonGenerator

enum CELL_TYPE {
	EMPTY,
	WALL
}

export var grid_size := Vector2(7, 7)
var grid : Array = []

var walker_array = []


#### ACCESSORS ####

func is_class(value: String): return value == "DungeonGenerator" or .is_class(value)
func get_class() -> String: return "DungeonGenerator"


#### BUILT-IN ####

func _ready() -> void:
	_init_grid()
	_update_grid_display()



#### VIRTUALS ####



#### LOGIC ####


func _generate_dungeon() -> void:
	print("Generation started")
	_init_grid()
	_place_walker()
	
	while(!walker_array.empty()):
		for walker in walker_array:
			var accessible_cells = _get_accessible_cells(walker.cell) 
			walker.step(accessible_cells)
	
	_update_grid_display()
	
	print("Generation finished")


func set_cell(cell: Vector2, cell_type: int) -> void:
	grid[cell.x][cell.y] = cell_type


func _init_grid() -> void:
	grid = []
	
	for i in range(grid_size.x):
		grid.append([])
		
		for _j in range(grid_size.y):
			grid[i].append(CELL_TYPE.WALL)


func _update_grid_display() -> void:
	for i in range(grid_size.x):
		for j in range(grid_size.y):
			var cell_type = grid[i][j]
			
			$TileMap.set_cell(i, j, cell_type - 1)


func _place_walker() -> void:
	var rdm_cell = Vector2(randi() % int(grid_size.x),
							randi() % int(grid_size.y))
	
	var walker = Walker.new(rdm_cell, 9)
	walker_array.append(walker)
	add_child(walker)
	
	var __ = walker.connect("moved", self, "_on_walker_moved")
	__ = walker.connect("arrived", self, "_on_walker_arrived", [walker])


func _get_accessible_cells(cell: Vector2) -> Array:
	var adjacents = Utils.get_adjacents_cell(cell)
	var accessibles = []
	
	for adj in adjacents:
		if is_inside_grid(adj) && grid[adj.x][adj.y] == CELL_TYPE.WALL:
			accessibles.append(adj)
	
	return accessibles


func is_inside_grid(cell: Vector2) -> bool:
	return cell.x >= 0 && cell.x < grid_size.x && \
			cell.y >= 0 && cell.y < grid_size.y


#### INPUTS ####


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_generate_dungeon()



#### SIGNAL RESPONSES ####

func _on_walker_moved(cell: Vector2) -> void:
	set_cell(cell, CELL_TYPE.EMPTY)


func _on_walker_arrived(walker: Walker) -> void:
	walker_array.erase(walker)
	walker.queue_free()
