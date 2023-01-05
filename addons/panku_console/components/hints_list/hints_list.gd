extends ScrollContainer

signal hint_button_clicked(idx:int)

const hint_pck = preload("res://addons/panku_console/components/hints_list/hint.tscn")

@onready var container = $VBoxContainer

@export var blur_hint := false

var hints_count = 0

var disable_buttons := false

var selected:int = 0:
	set(v):
		if !container: return
		if v < container.get_child_count():
			if selected < container.get_child_count():
				container.get_child(selected).set_highlight(false)
			container.get_child(v).set_highlight(true)
			selected = v

		#follow selected
		var bar = get_v_scroll_bar()
		if bar.visible:
			var a = bar.max_value
			var b = bar.value
			var c = bar.page
			var d = bar.max_value / hints_count
			var l = d * selected
			var r = d * (selected + 1)
			if b > l: b = l
			if b + c < r: b = r - c
			bar.value = b

func set_hints(texts:Array, icons:Array):
	hints_count = texts.size()
	for i in range(texts.size()):
		var h
		if i < container.get_child_count():
			h = container.get_child(i)
			h.show()
		else:
			h = hint_pck.instantiate()
			container.add_child(h)
			h.blur.visible = blur_hint;
			h.set_meta("idx", i)
			h.button_down.connect(func(): _on_btn_clicked(i))
		h.label.text = texts[i]
		if i < icons.size():
			h.icon2.texture = icons[i]
		else:
			h.icon2.texture = null
		h.set_highlight(false)
	if texts.size() < container.get_child_count():
		for i in range(texts.size(), container.get_child_count()):
			container.get_child(i).hide()

func _on_btn_clicked(i:int):
	if !disable_buttons:
		hint_button_clicked.emit(i)
