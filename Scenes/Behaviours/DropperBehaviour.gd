extends Behaviour
class_name DropperBehaviour

export var item_drop_weight_array : Array = [] 
export var max_amount_dropped : int = 1

func drop_item() -> void:
	var rdm_value = rand_range(0.0, _compute_maximum_weight())
	var dropped_item = _find_item_by_weight_value(rdm_value)
	
	EVENTS.emit_signal("spawn_item", dropped_item, object.global_position)


func _compute_maximum_weight() -> float:
	var total_weight : float = 0.0
	for item_weight in item_drop_weight_array:
		total_weight += item_weight.weight
	
	return total_weight


func _find_item_by_weight_value(weight_value: float) -> Object:
	var current_max_weight = 0.0
	
	for item_weight in item_drop_weight_array:
		current_max_weight += item_weight.weight
		
		if weight_value <= current_max_weight:
			return item_weight.item_data
	return null
