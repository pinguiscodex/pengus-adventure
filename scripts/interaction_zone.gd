## A reusable interaction zone (activator) that detects player presence and handles input.
## Attach this to an Area2D node to make it interactive.
## 
## USAGE:
## 1. Add Area2D node to your scene
## 2. Add CollisionShape2D as child (defines the activator zone)
## 3. Attach this script to the Area2D
## 4. Set visual_indicator_path to your E key sprite NodePath
## 5. Connect the 'interacted' signal to your handler
##
## The activator will:
## - Detect when target body enters/exits the collision zone
## - Show/hide the visual indicator (E key icon)
## - Trigger wiggle animation on the indicator
## - Emit 'interacted' signal when player presses E key
extends Area2D

## Signal emitted when player enters the zone
signal player_entered
## Signal emitted when player exits the zone
signal player_exited
## Signal emitted when player presses interact key while in zone
signal interacted

## Name of the body to detect (leave empty to detect any character body)
@export var target_body_name: String = ""

## Whether the zone is currently active and can detect/interact
@export var enabled: bool = true

## Path to the optional visual indicator node (e.g., E key sprite).
## Will be resolved at runtime. The indicator can have _on_player_entered() 
## and _on_player_exited() methods for animation.
@export var visual_indicator_path: NodePath = NodePath("")

var visual_indicator: Node2D = null
var player_in_zone: bool = false


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	# Resolve visual indicator from path
	if visual_indicator_path != NodePath(""):
		visual_indicator = get_node(visual_indicator_path)


func _unhandled_input(event: InputEvent) -> void:
	if not enabled or not player_in_zone:
		return
	
	if event.is_action_pressed("interact"):
		interacted.emit()


func _on_body_entered(body: Node2D) -> void:
	if not enabled:
		return
	
	# Check if this is the target body
	if target_body_name != "" and body.name != target_body_name:
		return
	
	player_in_zone = true
	
	# Control visual indicator
	if visual_indicator:
		visual_indicator.visible = true
		# Call the wiggle animation method if it exists
		if visual_indicator.has_method("_on_player_entered"):
			visual_indicator._on_player_entered()
	
	player_entered.emit()


func _on_body_exited(body: Node2D) -> void:
	if not player_in_zone:
		return
	
	# Check if this is the target body
	if target_body_name != "" and body.name != target_body_name:
		return
	
	player_in_zone = false
	
	# Control visual indicator
	if visual_indicator:
		visual_indicator.visible = false
		# Call the reset method if it exists
		if visual_indicator.has_method("_on_player_exited"):
			visual_indicator._on_player_exited()
	
	player_exited.emit()
