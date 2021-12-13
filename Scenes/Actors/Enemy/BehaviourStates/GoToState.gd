extends State


func enter_state() -> void:
	owner.state_machine.set_state("Move")
