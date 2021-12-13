extends YSort

onready var pathfinder = $Tilemap/Pathfinder

func _ready() -> void:
	var enemies_array = get_tree().get_nodes_in_group("Enemy")
	
	for enemy in enemies_array:
		enemy.pathfinder = pathfinder
