extends TextureRect

onready var coin_counter = $CoinCounter


func _ready() -> void:
	var __ = EVENTS.connect("nb_coins_changed", self, "_on_EVENTS_nb_coins_changed")



func _on_EVENTS_nb_coins_changed(nb_coins: int) -> void:
	coin_counter.set_text(String(nb_coins))
