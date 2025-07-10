extends Label

func _process(delta: float) -> void:
	SaveLoad._load()
	if SaveLoad.contents_to_save.show_fps:
		visible = true
		text = "FPS: " + str(Engine.get_frames_per_second())
	else:
		visible = false
