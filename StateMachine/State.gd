extends Node
class_name State

onready var state_machine = get_parent()


func is_class(value: String) -> bool: return value == "State" or .is_class(value)


func enter_state() -> void:
	pass


func exit_state() -> void:
	pass


func update(_delta: float) -> void:
	pass 


#### LOGIC ####


func is_current_state() -> bool:
	return state_machine.get_state() == self
