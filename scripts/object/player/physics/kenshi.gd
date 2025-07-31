class_name Player
extends CharacterBody2D


var direction : Vector2 = Vector2.ZERO
var cardinal_dir: Vector2 = Vector2.DOWN

# Node references to make typing easier
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine


func _ready() -> void:
	# Get the initial state and run it in the scene
	state_machine._initialize(self)
	pass

func _process(_delta: float) -> void:
	# Get the directions from key presses
	direction = Input.get_vector("left", "right", "up", "down")
	pass

func _physics_process(_delta: float) -> void:
	# Move function to process physics every frame
	move_and_slide()


func set_direction() -> bool:
	# The direction starts at Vector2.DOWN
	var new_dir: Vector2 = cardinal_dir
	if direction == Vector2.DOWN:
		return false
	# Look left and right based on scale
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	#
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y > 0 else Vector2.DOWN
	if new_dir == cardinal_dir:
		return false
	cardinal_dir = new_dir
	animated_sprite.scale.x = -1 if cardinal_dir == Vector2.LEFT else 1
	return true

func update_animation(state: String) -> void:
	# Get the name of the animation with a direction
	# To make the animations work, you have to create them from a \
	# sprite sheet and name it one of the directions
	animated_sprite.play(state + "_" + anim_direction())
	pass

func anim_direction() -> String:
	if cardinal_dir == Vector2.DOWN:
		return "down"
	elif cardinal_dir == Vector2.UP:
		return "up"
	else:
		return "side"
