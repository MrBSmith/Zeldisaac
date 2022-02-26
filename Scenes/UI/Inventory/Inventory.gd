extends Control
class_name Inventory

var hidden := true setget set_hidden, is_hidden

onready var item_list = $Panel/VBoxContainer/ItemList
onready var data_manager = $DataManager
onready var tween = $Tween
onready var hidden_position = Vector2(GAME.window_size.x, margin_top)
onready var visible_position = hidden_position - Vector2(rect_size.x + margin_left, 0)

signal cancel()
signal confirm()
signal hidden_changed()

#### ACCESSORS ####

func set_hidden(value: bool) -> void:
	if value != hidden:
		hidden = value
		emit_signal("hidden_changed", hidden)
func is_hidden() -> bool: return hidden


#### BUILT-IN ####

func _ready() -> void:
	var __ = connect("hidden_changed", self, "_on_hidden_changed")
	__ = EVENTS.connect("object_collected", self, "_on_EVENTS_object_collected")


#### LOGIC ####

func _animation(appear: bool) -> void:
	var from = rect_position
	var to = visible_position if appear else hidden_position
	
	tween.interpolate_property(self, "rect_position", from, to, 0.5, Tween.TRANS_CUBIC)
	tween.start()


func use_item(item_data: ItemData) -> void:
	data_manager.remove_item(item_data)


#### INPUTS ####

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("inventory") && !tween.is_active():
		set_hidden(!hidden)
	
	if hidden:
		return
	
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("confirm")
	
	elif Input.is_action_just_pressed("ui_cancel"):
		emit_signal("cancel")


#### SIGNAL RESPONSES ####

func _on_hidden_changed(_value: bool) -> void:
	_animation(!hidden)


func _on_ItemList_use_item_query(item_data: ItemData) -> void:
	use_item(item_data)


func _on_EVENTS_object_collected(obj: Object) -> void:
	if obj is Item:
		data_manager.append_item(obj.item_data)
