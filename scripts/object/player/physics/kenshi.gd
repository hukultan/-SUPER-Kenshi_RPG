class_name Player
extends CharacterBody2D


var direction : Vector2 = Vector2.DOWN
var cardinal_dir: Vector2 = Vector2.ZERO
# Node path references to make things easier
@export var sprite_frames: AnimatedSprite2D 
@export var state_machine: PlayerStateMachine


func _ready() -> void:
	# Get the initial state and run it in the scene
	state_machine._initialize(self)
	pass

func _process(_delta: float) -> void:
	# Get the directions from key presses
	direction = Input.get_vector("left", "right", "up", "down").normalized()
	pass

func _physics_process(_delta: float) -> void:
	# Move function to process physics every frame
	move_and_slide()

func set_direction() -> bool:
	# The direction starts at Vector2.DOWN
	var new_dir: Vector2 = cardinal_dir
	if direction == Vector2.ZERO:
		return false
	# Look left and right based on scale
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y > 0 else Vector2.DOWN
	if new_dir == cardinal_dir:
		return false
	cardinal_dir = new_dir
	sprite_frames.scale.x = -0.661 if cardinal_dir == Vector2.LEFT else 0.661
	return true

func update_animation(state: String) -> void:
	# Get the name of the animation with a direction
	# To make the animations work, you have to create them from a \
	# sprite sheet and name it one of the directions
	sprite_frames.play(state + "_" + anim_direction())
	pass

func anim_direction() -> String:
	if cardinal_dir == Vector2.DOWN:
		return "down"
	elif cardinal_dir == Vector2.UP:
		return "up"
	else:
		return "side"
