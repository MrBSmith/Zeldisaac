extends Behaviour
class_name DropperBehaviour

export var item_drop_weight_array : Array = []


func drop_item() -> void:
	var rdm_value = rand_range(0.0, _compute_total_weight())
	var dropped_item = _find_item_by_weight_value(rdm_value)


	if dropped_item == null:
		return

	elif dropped_item is ItemData:
		EVENTS.emit_signal("spawn_item", dropped_item, object.global_position)

	elif dropped_item is PackedScene:
		EVENTS.emit_signal("spawn_special_item", dropped_item, object.global_position)


func _compute_total_weight() -> float:
	var total_weight : float = 0.0
	for item_weight in item_drop_weight_array:
		total_weight += item_weight.weight

	return total_weight


# Finds the item in the item_drop_weight_array that corresponds to the given random value
# then returns it item_data
func _find_item_by_weight_value(value: float) -> Object:
	var current_total_weight : float = 0.0

	for item_weight in item_drop_weight_array:
		current_total_weight += item_weight.weight

		if value <= current_total_weight:
			return item_weight.item_data

	push_error("The given value %d must be between 0.0 and the total weight of item_drop_weight_array" % value)
	return null
