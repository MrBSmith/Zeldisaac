extends ColorRect

onready var tween = $Tween


func fade(fade_in: bool) -> void:
	var to = 0.5 if fade_in else 0.0
	
	tween.interpolate_property(self, "color:a", color.a, to, 0.5)
	tween.start()



func _on_Inventory_hidden_changed(hidden: bool) -> void:
	fade(!hidden)
