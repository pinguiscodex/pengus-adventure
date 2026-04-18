## Visual indicator for interaction prompts (e.g., E key icon).
## This script handles the wiggle animation when the indicator is shown.
## The InteractionZone script controls visibility by calling:
## - _on_player_entered() - shows and starts wiggle animation
## - _on_player_exited() - hides and stops wiggle animation
extends Sprite2D

var original_position: Vector2
var is_wiggling: bool = false


func _ready() -> void:
	visible = false
	original_position = position


## Called by InteractionZone when player enters the interaction area
func _on_player_entered() -> void:
	visible = true
	start_wiggle()


## Called by InteractionZone when player exits the interaction area
func _on_player_exited() -> void:
	stop_wiggle()
	visible = false
	position = original_position


func start_wiggle() -> void:
	if is_wiggling:
		return
	is_wiggling = true
	_wiggle_loop()


func stop_wiggle() -> void:
	is_wiggling = false
	position = original_position


func _wiggle_loop() -> void:
	while is_wiggling and visible:
		position = original_position + Vector2(0, -2)
		await get_tree().create_timer(0.1).timeout
		if not is_wiggling: break
		
		position = original_position + Vector2(0, -4)
		await get_tree().create_timer(0.1).timeout
		if not is_wiggling: break
		
		position = original_position + Vector2(0, -6)
		await get_tree().create_timer(0.1).timeout
		if not is_wiggling: break
		
		position = original_position + Vector2(0, -4)
		await get_tree().create_timer(0.1).timeout
		if not is_wiggling: break
		
		position = original_position + Vector2(0, -2)
		await get_tree().create_timer(0.1).timeout
	
	position = original_position
