extends ItemList
class_name InventoryItemList

var selected_item_id := -1 setget set_selected_item_id, get_selected_item_id

signal selected_item_id_changed(id)

#### ACCESSORS ####

func set_selected_item_id(value: int) -> void:
	if value == -1:
		selected_item_id = value
	else:
		selected_item_id = wrapi(value, 0, get_item_count())
	
	emit_signal("selected_item_id_changed", selected_item_id)
func get_selected_item_id() -> int: return selected_item_id


#### BUILT-IN ####

func _ready() -> void:
	var __ = connect("selected_item_id_changed", self, "_on_selected_item_id_changed")



#### LOGIC ####


func navigate_up() -> void:
	set_selected_item_id(wrapi(selected_item_id - 1, 0, get_item_count()))


func navigate_down() -> void:
	set_selected_item_id(selected_item_id + 1)


func _update_selected_item() -> void:
	if selected_item_id == -1:
		unselect_all()
	else:
		select(selected_item_id)


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



#### SIGNAL RESPONSES ####

func _on_selected_item_id_changed(_id: int) -> void:
	_update_selected_item()


func _on_Inventory_hidden_changed(hidden: bool) -> void:
	if !hidden:
		if get_item_count() >= 1:
			set_selected_item_id(0)
	else:
		set_selected_item_id(-1)
