extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Group_Inventory.control_group = [$Group_Inventory_AddItem]
	$Group_Inventory.set_group_visibility(false)
	$Hero_Cards.control_group = [$Aliza, $Rollo, $Hael]
	$Hero_Cards.set_group_visibility(false)
