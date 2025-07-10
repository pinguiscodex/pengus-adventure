extends Node

const save_location = "user://settingsjson"

var contents_to_save: Dictionary = {
	"vsync": true,
	"show_fps": false
}

func _ready() -> void:
	_load()

func _save():
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_var(contents_to_save.duplicate())
	file.close()

func _load():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location, FileAccess.READ)
		var data = file.get_var()
		file.close()

		var save_data = data.duplicate()
		contents_to_save.vsync = save_data.vsync
		contents_to_save.show_fps = save_data.show_fps
