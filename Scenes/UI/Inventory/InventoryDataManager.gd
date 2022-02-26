extends Node
class_name InventoryDataManager

var item_array : Array = []

signal item_added(item_amount)
signal item_removed(item_amount)

#### BUILT-IN ####



#### LOGIC ####

func append_item(item: ItemData, amount: int = 1) -> void:
	var item_amount_id = _find_item_id(item)
	var item_amount = null
	
	if item_amount_id == -1:
		item_amount = ItemAmount.new(amount, item)
		item_array.append(item_amount)
	else:
		item_amount = item_array[item_amount_id]
		item_amount.amount += amount
	
	emit_signal("item_added", item_amount)


func remove_item(item: ItemData, amount: int = 1) -> void:
	var item_amount_id = _find_item_id(item)
	
	if item_amount_id == -1:
		push_error("%s could not be removed from the list. No itemAmount corresponding was found" % item.item_name)
	else:
		var item_amount = item_array[item_amount_id]
		item_amount.amount -= amount
		emit_signal("item_removed", item_amount)
		
		if item_array[item_amount_id].amount <= 0:
			item_array.remove(item_amount_id)


# Finds the position of the ItemAmount corresponding to the given item in the item_array
# and returns its id, if no ItemAmount corresponds to it return -1
func _find_item_id(item: ItemData) -> int:
	for i in range(item_array.size()):
		var item_amount = item_array[i]
		if item_amount.item == item:
			return i
	return -1


func _print_inventory() -> void:
	print("--- INVENTORY CONTENT ---")
	print(" ")
	
	for item_amount in item_array:
		print(item_amount.item.item_name + " : " + String(item_amount.amount))
	
	print(" ")
	print("------")


#### INPUTS ####


#### SIGNAL RESPONSES ####

