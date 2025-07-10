extends Node

var vsync: bool = true
var show_fps: bool = false
var config: ConfigFile = ConfigFile.new()

func _ready() -> void:
	load_settings()

func save_settings():
	# Save current variable values into config
	config.set_value("graphics", "vsync", vsync)
	config.set_value("graphics", "show_fps", show_fps)

	var err = config.save("user://settings.cfg")
	if err != OK:
		print("Failed to save settings:", err)

func load_settings():
	var err = config.load("user://settings.cfg")
	if err != OK:
		print("No settings file found or error loading:", err)
	
	# Load values or fallback to defaults
	vsync = config.get_value("graphics", "vsync", true)
	show_fps = config.get_value("graphics", "show_fps", false)

	print("VSync:", vsync, " Show FPS:", show_fps)
