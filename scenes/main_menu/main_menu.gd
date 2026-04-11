extends Node2D


func _ready() -> void:
	SaveLoad.apply_settings()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world/world.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
