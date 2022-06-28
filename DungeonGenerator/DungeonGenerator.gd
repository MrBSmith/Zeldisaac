extends Node2D
class_name DungeonGenerator

enum CELL_TYPE{
	EMPTY,
	WALL
}

export var delay_btw_steps = 0.5

onready var automatas_array : Array = Utils.fetch(self, "CellularAutomata")

export var grid_size = Vector2(7, 7)
var grid : Array

var generation_ungoing : bool = false

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
	init_grid()
	
	generate_automatas([Vector2(0, 3)])
	
	while(!automatas_array.empty()):
		if delay_btw_steps > 0.0:
			yield(get_tree().create_timer(delay_btw_steps), "timeout")

		for automata in automatas_array:
			var adjacents_cells = get_reachable_cells(automata.cell)
			automata.step(adjacents_cells)
	
	generation_ungoing = false


func generate_automatas(start_cell_array: PoolVector2Array) -> void:
	automatas_array = []
	var max_steps = int(grid_size.x * grid_size.y / 3)
	
	for cell in start_cell_array:
		var automata = CellularAutomata.new()
		
		add_child(automata)
		
		if !automata.is_inside_tree():
			yield(automata, "ready")
		
		automata.max_steps = max_steps
		
		var __ = automata.connect("moved", self, "_on_automata_moved")
		automata.connect("arrived", self, "_on_automata_arrived", [automata])
		
		automata.set_cell(cell)
		
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
