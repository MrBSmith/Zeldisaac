extends Object
class_name ItemAmount

var amount : int = 0
var item : ItemData = null

func _init(_amount: int, _item: ItemData) -> void:
	amount = _amount
	item = _item
