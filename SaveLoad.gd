extends Node

const save_location = "user://settings.json"

var contents_to_save: Dictionary = {
	"vsync": true,
	"show_fps": false
}

func _ready() -> void:
	_load()
	apply_settings()

func apply_settings() -> void:
	if contents_to_save.vsync:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func _save() -> void:
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	if file:
		var json_string = JSON.stringify(contents_to_save, "\t")
		file.store_string(json_string)
		file.close()

func _load() -> void:
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location, FileAccess.READ)
		var json_string = file.get_as_text()
		file.close()

		var json = JSON.new()
		var error = json.parse(json_string)
		if error == OK:
			var data = json.data
			if data is Dictionary:
				if data.has("vsync"):
					contents_to_save.vsync = data.vsync
				if data.has("show_fps"):
					contents_to_save.show_fps = data.show_fps
