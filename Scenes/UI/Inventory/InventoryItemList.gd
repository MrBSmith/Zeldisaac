extends ItemList
class_name InventoryItemList


func update_item_display(item_amount: ItemAmount) -> void:
	var item_id = _find_item_in_list(item_amount)
	var item_text = "%s : %d" % [item_amount.item.item_name, item_amount.amount]
	
	if item_id == -1:
		add_item(item_text, item_amount.item.inventory_texture)
		item_id = get_item_count() - 1
		set_item_metadata(item_id, item_amount)
	
	else:
		if item_amount.amount <= 0:
			remove_item(item_id)
		else:
			set_item_text(item_id, item_text)


func _find_item_in_list(item_amount: ItemAmount) -> int:
	for i in range(get_item_count()):
		if item_amount == get_item_metadata(i):
			return i
	return -1


func _on_InventoryDataManager_item_added(item_amount: ItemAmount) -> void:
	update_item_display(item_amount)


func _on_InventoryDataManager_item_removed(item_amount: ItemAmount) -> void:
	update_item_display(item_amount)
