extends ItemList

signal use_item_query(item_data)

#### ACCESSORS ####



#### BUILT-IN ####



#### LOGIC ####


func update_item_display(item_amount: ItemAmount) -> void:
	var item_id = _find_item_in_list(item_amount)
	var item_name = item_amount.item.item_name
	var item_text = "%s : %d" % [item_name, item_amount.amount]
	
	if item_id == -1:
		if item_amount.amount <= 0:
			push_warning("The given item_amount of the item %s has an amount <= 0 but is not in the list" % item_name)
			return
		else:
			add_item(item_text, item_amount.item.inventory_texture)
			item_id = get_item_count() - 1
			set_item_tooltip(item_id, item_amount.item.description)
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


#### INPUTS ####


func _gui_input(event: InputEvent) -> void:
	var selected_items = get_selected_items()
	var index = selected_items[0] if !selected_items.empty() else -1
	
	var event_text = event.as_text()

	if event_text in ["Down", "Up"]:
		if event.is_action_pressed("ui_down"):
			index += 1
		elif event.is_action_pressed("ui_up"):
			index -= 1
		
		index = wrapi(index, 0, get_item_count())
		select(index)
		accept_event()


#### SIGNAL RESPONSES ####


func _on_DataManager_item_added(item_amount) -> void:
	update_item_display(item_amount)


func _on_DataManager_item_removed(item_amount) -> void:
	update_item_display(item_amount)


func _on_Inventory_confirm() -> void:
	for id in get_selected_items():
		var item_amount = get_item_metadata(id)
		var item_data = item_amount.item
		emit_signal("use_item_query", item_data)


func _on_Inventory_animation_finished(hidden: bool) -> void:
	if hidden:
		release_focus()


func _on_Inventory_hidden_changed(hidden: bool) -> void:
	if !hidden && get_item_count() > 0:
		grab_focus()
		select(0)

