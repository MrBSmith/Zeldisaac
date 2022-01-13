extends YSort

onready var pathfinder = $Tilemap/Pathfinder

func _ready() -> void:
	var __ = EVENTS.connect("actor_died", self, "_on_EVENTS_actor_died")
	
	var enemies_array = get_tree().get_nodes_in_group("Enemy")
	
	for enemy in enemies_array:
		enemy.pathfinder = pathfinder


func _on_EVENTS_actor_died(actor: Actor) -> void:
	if actor is Enemy:
		var enemies_array = get_tree().get_nodes_in_group("Enemy")
		
		if enemies_array == [actor]:
			EVENTS.emit_signal("room_finished")
