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
	fps_toggle.visible = false
	# Set initial checkbox state based on saved settings
	vsync_toggle.button_pressed = SaveLoad.contents_to_save.vsync
	fps_toggle.button_pressed = SaveLoad.contents_to_save.show_fps

# Settings Window handling
func _on_settings_pressed() -> void:
	visible = true
	close.visible = true
	vsync_toggle.visible = true
	fps_toggle.visible = true
	play.visible = false
	settings.visible = false
	quit.visible = false

func _on_close_pressed() -> void:
	_close_settings()

func _close_settings() -> void:
	play.visible = true
	settings.visible = true
	quit.visible = true
	visible = false
	close.visible = false
	vsync_toggle.visible = false
	fps_toggle.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and visible:
		_close_settings()
		get_viewport().set_input_as_handled()

# Settings
func _on_vsync_toggled(pressed: bool) -> void:
	SaveLoad.contents_to_save.vsync = pressed
	SaveLoad._save()
	if pressed:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func _on_fps_toggle_toggled(pressed: bool) -> void:
	SaveLoad.contents_to_save.show_fps = pressed
	SaveLoad._save()
