extends Node

var vsync: bool = true
var show_fps: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_settings()

func save_settings():
	var config = ConfigFile.new()

	# Save to disk (in user://)
	var err = config.save("user://settings.cfg")
	if err != OK:
		print("Failed to save settings:", err)

func load_settings():
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err != OK:
		print("No settings file found or error loading:", err)
		config.set_value("graphics", "vsync", true)
		config.set_value("graphics", "show_fps", false)
		save_settings()
		return
	# Load values or fallback to default if not found
	vsync = config.get_value("graphics", "vsync", true)
	show_fps = config.get_value("graphics", "show_fps", false)
	print("VSync: ",vsync, "Show FPS: ", show_fps)

	if vsync:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
