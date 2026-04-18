extends Node2D


func _ready() -> void:
	SaveLoad.apply_settings()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")


## Called when the player interacts with the door
func _on_door_interacted() -> void:
	# TODO: Implement door interaction logic (e.g., open door, trigger cutscene, etc.)
	print("Door interacted!")
