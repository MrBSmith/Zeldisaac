extends Control
class_name Inventory

onready var item_list = $Panel/VBoxContainer/ItemList
onready var tween = $Tween
onready var panel = $Panel
onready var hidden_position = rect_position
onready var visible_position = hidden_position - panel.rect_size * Vector2.RIGHT

var hidden := true setget set_hidden, is_hidden

signal hidden_changed(value)


#### ACCESSORS ####

func set_hidden(value: bool) -> void:
	if value != hidden:
		hidden = value
		emit_signal("hidden_changed", hidden)
func is_hidden() -> bool: return hidden


#### BUILT-IN ####

func _ready() -> void:
	var __ = connect("hidden_changed", self, "_on_hidden_changed")



#### LOGIC ####

func _animation(appear: bool) -> void:
	var from = rect_position
	var to = visible_position if appear else hidden_position
	
	tween.interpolate_property(self, "rect_position", from, to, 0.7, Tween.TRANS_CUBIC)
	tween.start()


#### INPUTS ####

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("inventory"):
		set_hidden(!hidden)
	
	if hidden:
		return
	
	if Input.is_action_just_pressed("ui_up"):
		item_list.navigate_up()
	
	if Input.is_action_just_pressed("ui_down"):
		item_list.navigate_down()



#### SIGNAL RESPONSES ####

func _on_hidden_changed(_value: bool) -> void:
	_animation(!hidden)
	get_tree().paused = !hidden
