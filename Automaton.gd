extends Node
class_name CellularAutomata

var max_steps : int = 0
var nb_steps : int = 0
var last_direction = Vector2.ZERO

export var cell = Vector2.INF setget set_cell

signal moved(cell)
signal arrived

class WeightedCell:
	var cell: Vector2
	var weight : float
	
	func _init(c: Vector2, w: float) -> void:
		cell = c
		weight = w


func is_class(value: String) -> bool: return value == "CellularAutomata" or .is_class(value)


func set_cell(value: Vector2) -> void:
	if value != cell:
		cell = value
		emit_signal("moved", cell)


func step(accessible_cells: Array) -> void:
	if accessible_cells.empty():
		emit_signal("arrived")
		return
	
	nb_steps += 1
	
	var new_cell = choose_cell(accessible_cells)
	last_direction = new_cell - cell
	
	set_cell(new_cell)
	
	if nb_steps >= max_steps:
		emit_signal("arrived")


func choose_cell(accessible_cells) -> Vector2:
	var weighted_cells = pondarate_accessible_cells(accessible_cells)
	var weight_sum : float = 0.0
	
	for w_cell in weighted_cells:
		weight_sum += w_cell.weight
	
	var rdm_value = rand_range(0.0, weight_sum)
	var weighted_cell = find_weighted_cell(rdm_value, weighted_cells)
	
	return weighted_cell.cell


func pondarate_accessible_cells(accessible_cells: Array) -> Array:
	var array = []
	
	for adj_cell in accessible_cells:
		var dir = adj_cell - cell
		
		var weight = 0.5 if dir == last_direction else 1.0 
		var weighted_cell = WeightedCell.new(adj_cell, weight)
		array.append(weighted_cell)
	
	return array



func find_weighted_cell(weight_value: float, weighted_cell_array: Array) -> WeightedCell:
	var weight_sum = 0.0
	for w_cell in weighted_cell_array:
		weight_sum += w_cell.weight
		if weight_value <= weight_sum:
			return w_cell
	return null
