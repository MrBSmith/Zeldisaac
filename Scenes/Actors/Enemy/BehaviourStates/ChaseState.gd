extends State
class_name ChaseState


func enter_state() -> void:
	owner.state_machine.set_state("Move")


func update(_delta: float) -> void:
	owner.update_move_path(owner.target.global_position)
