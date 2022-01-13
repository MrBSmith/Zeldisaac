extends State

export var min_wait_time : float = 0.8
export var max_wait_time : float = 1.2

signal wait_time_finished

func _ready() -> void:
	var __ = $Timer.connect("timeout", self, "_on_Timer_timeout")


func enter_state() -> void:
	if !is_instance_valid(owner):
		return
	
	if owner.state_machine != null:
		owner.state_machine.set_state("Idle")
	
	var wait_time = rand_range(min_wait_time, max_wait_time)
	$Timer.start(wait_time)


func _on_Timer_timeout() -> void:
	emit_signal("wait_time_finished")
