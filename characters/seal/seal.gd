extends CharacterBody2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

@onready var penguin = get_node("../penguin")
func _process(delta: float) -> void:
	if penguin.position.x > position.x:
		position.x += 1
	else:
		position.x -= 1
