extends State
class_name EnemyMoveState

func update(delta: float) -> void:
	owner.move_along_path(delta)
