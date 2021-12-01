extends Label
class_name StateLabel

func _ready() -> void:
	yield(get_parent(), "ready")
	var __ = get_parent().connect("state_changed", self, "_on_StateMachine_state_changed")
	
	_update_text(get_parent().current_state)


func _update_text(state: Node) -> void:
	set_text(state.name)



func _on_StateMachine_state_changed(state: Node) -> void:
	_update_text(state)
