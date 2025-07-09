extends Sprite2D

@onready var play: TextureButton = get_node("../play")
@onready var settings: TextureButton = get_node("../settings")
@onready var quit: TextureButton = get_node("../quit")
@onready var close: TextureButton = $close
@onready var vsync_toggle = $vsync_toggle
@onready var fps_toggle = $fps_toggle


func _ready() -> void:
	visible = false
	close.visible = false
	vsync_toggle.visible = false
	# Set initial checkbox state based on current VSync mode
	vsync_toggle.button_pressed = DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_ENABLED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


# Settings Window handling
func _on_settings_pressed() -> void:
	visible = true
	close.visible = visible
	vsync_toggle.visible = visible
	play.visible = false
	settings.visible = false
	quit.visible = false

func _on_close_pressed() -> void:
	play.visible = true
	settings.visible = true
	quit.visible = true
	visible = false
	close.visible = visible
	vsync_toggle.visible = visible


# Settings
func _on_vsync_toggled(pressed: bool) -> void:
	if pressed:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		GlobalSettings.config.set_value("graphics", "vsync", true)
		GlobalSettings.save_settings()
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		GlobalSettings.config.set_value("graphics", "vsync", false)
		GlobalSettings.save_settings()

func _on_fps_toggle_pressed(pressed: bool) -> void:
	if pressed:
		GlobalSettings.config.set_value("graphics", "show_fps", true)
		GlobalSettings.save_settings()
	else:
		GlobalSettings.config.set_value("graphics", "show_fps", false)
		GlobalSettings.save_settings()
