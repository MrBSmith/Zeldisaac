extends Node

# warnings-disable

signal spawn_item(item_data, pos)
signal spawn_special_item(item_scene, pos)

signal object_collected(obj)
signal nb_coins_changed(nb_coins)

signal character_hp_changed(hp)
signal actor_died(actor)

signal room_finished()

signal obstacle_destroyed(obstacle)
