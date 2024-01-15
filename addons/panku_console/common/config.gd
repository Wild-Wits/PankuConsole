class_name PankuConfig

const FILE_NAME = "panku_config.cfg"
const FILE_PATH = "user://" + FILE_NAME

static func set_config(config:Dictionary):
	var file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	var content = var_to_str(config)
	file.store_string(content)

static func get_config() -> Dictionary:
	if FileAccess.file_exists(FILE_PATH):
		var file = FileAccess.open(FILE_PATH, FileAccess.READ)
		var content = file.get_as_text()
		var config:Dictionary = str_to_var(content)
		if config: return config
	return {
			"general_settings": {
				"window_blur_effect": true
				},
			"native_logger": {
				"font_size": 14.0,
				"screen_overlay": 1,
				"screen_overlay_alpha": 0.3,
				"screen_overlay_font_size": 13.0
				}
			}

static func get_value(key:String, default:Variant) -> Variant:
	return get_config().get(key, default)
	
static func set_value(key:String, val:Variant) -> void:
	var config = get_config()
	config[key] = val
	set_config(config)
