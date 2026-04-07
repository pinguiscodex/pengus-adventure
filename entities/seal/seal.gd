extends CharacterBody2D

@export var move_speed: float = 50 # pixels per second
@onready var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var penguin: Node2D = get_node("../penguin")

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0.0

	# Move toward penguin
	if penguin.position.x > position.x:
		velocity.x = move_speed
	elif penguin.position.x < position.x:
		velocity.x = -move_speed
	else:
		velocity.x = 0.0

	move_and_slide()
