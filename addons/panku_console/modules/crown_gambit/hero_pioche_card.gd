extends VBoxContainer

@export var hero : Character.Heroes = Character.Heroes.NONE
@export var skill_list : OptionButton
@export var add_button : Button

var _skillcard_descriptors : Array[HeroSkillCardDescriptor] = []

func _ready():
	populate_cards()
	add_button.pressed.connect(_on_add_button_pressed)

func populate_cards():
	skill_list.clear()
	_skillcard_descriptors.assign(
		HeroSkillsLibrary.get_hero_skillcard_descriptors(hero).filter(
			func(descriptor):
				return is_instance_valid(descriptor.skill_normal)))
	# Sort skills alphabetically
	_skillcard_descriptors.sort_custom(func(a,b):
		return tr(a.skill_normal.name).to_lower() < tr(b.skill_normal.name).to_lower())
	for descriptor:HeroSkillCardDescriptor in _skillcard_descriptors:
		skill_list.add_item(tr(descriptor.skill_normal.name))

func _on_add_button_pressed():
	var selected_item_idx = skill_list.selected
	var descriptor := _skillcard_descriptors[selected_item_idx]
	var playable_card := HeroSkillsLibrary.get_skillcard_matching_descriptor(descriptor)
	var hero := GameState.get_hero_by_id(hero)
	var has_card_in_deck := false
	for _playable_card:SkillTreePlayableCard in hero.deck.get_active_skill_cards():
		if _playable_card.hero_skillcard_descriptor.is_equivalent_to(descriptor):
			has_card_in_deck = true
			break
	if not has_card_in_deck:
		hero.deck.add_child(playable_card.duplicate())
		hero.deck_updated.emit()
	hero.main.add_child(playable_card)
	hero.hand_updated.emit()
