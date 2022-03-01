extends Control
class_name Veil

onready var tween = $Tween

func _ready() -> void:
	var __ = EVENTS.connect("menu_focus_mode", self, "_on_EVENTS_menu_focus_mode")


func _animation(appear: bool) -> void:
	var from = 0.0 if appear else 0.5
	var to = 0.5 if appear else 0.0
	
	tween.interpolate_property($ColorRect, "color:a", from, to, 0.5)
	tween.start()


func _on_EVENTS_menu_focus_mode(menu_focus_mode: bool) -> void:
	_animation(menu_focus_mode)
