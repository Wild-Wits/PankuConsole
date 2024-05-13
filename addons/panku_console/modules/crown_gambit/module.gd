class_name PankuModuleCrownGambit extends PankuModule

const crown_gambit_scene = preload("./crown_gambit.tscn")

var window: Control

func open_window():
	if window: return
	var ui_instance = crown_gambit_scene.instantiate()
	window = core.windows_manager.create_window(ui_instance)
	window.set_window_title_text("Crown Gambit")
	window.show_window()
	window.window_closed.connect(
		func(): window = null
	)
