extends "./row_ui.gd"

@export var opt_btn:OptionButton

func update_ui(val):
	opt_btn.select(opt_btn.get_item_index(val))

func is_active():
	return opt_btn.has_focus()

func _ready():
	opt_btn.item_selected.connect(
		func(index:int):
			ui_val_changed.emit(opt_btn.get_item_id(index))
	)
	
	# wtf, transparent background is a mess
	var popup := opt_btn.get_popup()
	popup.transparent_bg = true
	popup.transparent = true

func setup(params := []):
	opt_btn.clear()
	for p in params:
		if ":" in p:
			opt_btn.add_item(str(p.split(":")[0]),int(p.split(":")[1]))
		else:
			opt_btn.add_item(p)
