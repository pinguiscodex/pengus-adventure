extends Sprite2D

@onready var player_stands_in_door = false

func _ready() -> void:
	visible = false


# Door Interaction Key
var original_position = Vector2(352.0, 450.0)

func _on_door_body_entered(body: Node2D) -> void:
	if body.name == "penguin":
		visible = true
		player_stands_in_door = true
		start_wiggle()

func _on_door_body_exited(body: Node2D) -> void:
	visible = false
	player_stands_in_door = false
	position = original_position

func start_wiggle() -> void:
	await _wiggle_while_player_in_door()

func _wiggle_while_player_in_door() -> void:
	while player_stands_in_door:
		position = original_position + Vector2(0, -2)
		await get_tree().create_timer(0.1).timeout
		position = original_position + Vector2(0, -4)
		await get_tree().create_timer(0.1).timeout
		position = original_position + Vector2(0, -6)
		await get_tree().create_timer(0.1).timeout
		position = original_position + Vector2(0, -4)
		await get_tree().create_timer(0.1).timeout
		position = original_position + Vector2(0, -2)
		await get_tree().create_timer(0.1).timeout
	position = original_position
