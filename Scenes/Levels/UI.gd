extends Control
class_name UI

func _ready() -> void:
	var __ = EVENTS.connect("menu_focus_mode", self, "_on_EVENTS_menu_focus_mode")


func _on_EVENTS_menu_focus_mode(menu_focus_mode: bool) -> void:
	get_tree().paused = menu_focus_mode
