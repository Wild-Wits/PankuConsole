extends HBoxContainer

@export var item_list : OptionButton
@export var add_button : Button

var _item_skillcard_descriptors : Array[HeroSkillCardDescriptor]

func _ready():
	populate_item_list()
	add_button.pressed.connect(_on_add_button_pressed)
	
func populate_item_list():
	item_list.clear()
	_item_skillcard_descriptors.assign(ItemsLibrary.get_items_skillcard_descriptors())
	for descriptor:HeroSkillCardDescriptor in _item_skillcard_descriptors:
		if not descriptor.skill_normal:
			continue
		item_list.add_item(tr(descriptor.skill_normal.name))
		
func _on_add_button_pressed():
	var selected_item_idx = item_list.selected
	var playable_card = ItemsLibrary.get_item_matching_descriptor(_item_skillcard_descriptors[selected_item_idx])
	GameState.group_inventory.add_child(playable_card)
