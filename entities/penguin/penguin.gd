extends CharacterBody2D

const SPEED: float = 300.0
const SLIDE_SPEED: float = 550.0
const JUMP_VELOCITY: float = -400.0
const DAMPING: float = 1000.0  # Higher = quicker slowdown

@onready var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim: AnimationPlayer = get_node("AnimationPlayer")
@onready var sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")

var is_sliding: bool = false
var slide_queued: bool = false
var slide_direction: int = 0
var jump_requested: bool = false

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	elif not jump_requested:
		velocity.y = 0.0  # Optional reset to prevent float buildup

	# Jump
	if Input.is_action_just_pressed("ui_up") and is_on_floor() and not is_sliding and not jump_requested:
		jump_requested = true
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")

	if is_on_floor() and not Input.is_action_pressed("ui_up"):
		jump_requested = false

	# Input direction
	var direction := Input.get_axis("ui_left", "ui_right")

	# Handle sprite flipping
	if direction == -1:
		sprite.flip_h = true
	elif direction == 1:
		sprite.flip_h = false

	# Slide
	if Input.is_action_just_pressed("ui_slide") and is_on_floor() and not is_sliding:
		is_sliding = true
		slide_queued = true
		anim.play("Slide")
		slide_direction = direction if direction != 0 else (-1 if sprite.flip_h else 1)

	# Cancel slide if released
	if is_sliding and Input.is_action_just_released("ui_slide"):
		is_sliding = false
		slide_queued = false

	# Handle slide movement
	if is_sliding:
		if not slide_queued:
			anim.play("is_sliding")
		velocity.x = slide_direction * SLIDE_SPEED
	else:
		# Regular horizontal movement
		if direction != 0:
			velocity.x = direction * SPEED
			if velocity.y == 0:
				anim.play("Run")
		else:
			# Smooth deceleration using move_toward
			velocity.x = move_toward(velocity.x, 0.0, DAMPING * delta)
			if velocity.y == 0:
				anim.play("Idle")

	# Falling animation
	if velocity.y > 0 and not is_sliding:
		anim.play("Fall")

	# Final movement
	move_and_slide()

func _on_void_body_entered(body: Node2D) -> void:
	position = Vector2(110, 323)

func _ready() -> void:
	anim.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Slide" and is_sliding:
		slide_queued = false
