extends CharacterBody2D

const SPEED = 300.0
const SLIDE_SPEED = 500.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")

var is_sliding = false
var slide_queued = false
var slide_direction = 0

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if is_sliding and Input.is_action_just_released("ui_slide"):
		is_sliding = false
		slide_queued = false

	if Input.is_action_just_pressed("ui_up") and is_on_floor() and !is_sliding:
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")
		
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
		
	if Input.is_action_just_pressed("ui_slide") and !is_sliding and is_on_floor():
		anim.play("Slide")
		is_sliding = true
		slide_queued = true
		# Use facing direction if no input
		slide_direction = direction if direction != 0 else (-1 if get_node("AnimatedSprite2D").flip_h else 1)

	if is_sliding:
		if slide_queued:
			pass
		else:
			anim.play("is_sliding")
		velocity.x = slide_direction * SLIDE_SPEED
		# Gravity still applies
		if not is_on_floor():
			velocity.y += gravity * delta
		move_and_slide()
		return

	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")
	if velocity.y > 0:
		anim.play("Fall")
	move_and_slide()
	
		
func _on_void_body_entered(body: Node2D) -> void:
	position = Vector2(110, 323)
	
func _ready():
	anim.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(anim_name):
	if anim_name == "Slide" and is_sliding:
		slide_queued = false
