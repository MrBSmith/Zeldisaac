extends Node

var nb_coins : int = 0 setget set_nb_coins, get_nb_coins


#### ACCESSORS ####

func set_nb_coins(value: int) -> void:
	if value != nb_coins:
		nb_coins = value
		EVENTS.emit_signal("nb_coins_changed", nb_coins)


func get_nb_coins() -> int: return nb_coins



#### BUILT-IN ####


func _ready() -> void:
	randomize()
	
	EVENTS.connect("coin_collected", self, "_on_EVENTS_coin_collected")



#### SIGNAL RESPONSES ####

func _on_EVENTS_coin_collected() -> void:
	set_nb_coins(nb_coins + 1)
