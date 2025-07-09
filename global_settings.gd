extends Node

var vsync: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_settings()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func save_settings():
	var config = ConfigFile.new()

	# Set your custom settings
	config.set_value("graphics", "vsync", true)
	config.set_value("graphics", "show_fps", false)

	# Save to disk (in user://)
	var err = config.save("user://settings.cfg")
	if err != OK:
		print("Failed to save settings:", err)

func load_settings():
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err != OK:
		print("No settings file found or error loading:", err)
		return
	
	var volume = config.get_value("audio", "master_volume", 1.0)
	var fullscreen = config.get_value("graphics", "fullscreen", false)

	print("Volume:", volume, " Fullscreen:", fullscreen)
