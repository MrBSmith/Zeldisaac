extends Node
class_name Walker

var max_steps : int = 0
var nb_steps : int = 0

var cell = Vector2.INF setget set_cell

signal moved(cell)
signal arrived

#### ACCESSORS ####

func is_class(value: String): return value == "Walker" or .is_class(value)
func get_class() -> String: return "Walker"


func set_cell(value: Vector2) -> void:
	if value != cell:
		cell = value
		emit_signal("moved", cell)

#### BUILT-IN ####


func _init(_cell: Vector2, _max_steps: int) -> void:
	cell = _cell
	max_steps = _max_steps



func _ready() -> void:
	pass



#### VIRTUALS ####



#### LOGIC ####

func step(accessibles_cells: Array) -> void:
	if accessibles_cells.empty():
		emit_signal("arrived")
		return
	
	nb_steps += 1
	var new_cell = choose_cell(accessibles_cells)
	
	set_cell(new_cell)
	
	if nb_steps >= max_steps:
		emit_signal("arrived")


func choose_cell(accessibles_cells: Array) -> Vector2:
	var rdm_id = randi() % accessibles_cells.size()
	return accessibles_cells[rdm_id]


#### INPUTS ####



#### SIGNAL RESPONSES ####
