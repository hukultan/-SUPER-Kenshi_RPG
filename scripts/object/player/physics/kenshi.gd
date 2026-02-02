class_name Player
extends CharacterBody2D

@export var sprite_frames: AnimatedSprite2D
@export var state_machine: StateMachine
@export var facing: FacingDirection

var direction: Vector2 = Vector2.ZERO
var cardinal_dir: int = FacingDirection.Dir.DOWN

func _ready() -> void:
	state_machine.initialize(self)

func _physics_process(_delta: float) -> void:
	if not Global.input_enabled:
		return
	# 1. Read input
	var input_dir: Vector2 = Input.get_vector("left","right","up","down").normalized()

	# 2. Update direction FIRST
	direction = input_dir

	# 3. Ask state if direction causes transition
	var new_state: State = state_machine.current_state.on_direction_changed(direction)
	if new_state:
		state_machine.change_state(new_state)

	# 4. Apply velocity from state
	velocity = state_machine.current_state.get_velocity(direction)
	# 5. Let state update animation / facing
	state_machine.current_state.on_movement(direction)
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if not Global.input_enabled:
		return
	var new_state: State = state_machine.current_state.handle_input(event)
	if new_state:
		state_machine.change_state(new_state)

func set_direction() -> bool:
	if not Global.input_enabled:
		return false
	var new_dir: int = cardinal_dir
	if direction == Vector2.ZERO:
		return false

	if direction.y == 0:
		new_dir = FacingDirection.Dir.LEFT if direction.x < 0 else FacingDirection.Dir.RIGHT
	elif direction.x == 0:
		new_dir = FacingDirection.Dir.UP if direction.y < 0 else FacingDirection.Dir.DOWN

	if new_dir == cardinal_dir:
		return false

	cardinal_dir = new_dir

	# Flip sprite for horizontal movement
	if cardinal_dir == FacingDirection.Dir.LEFT:
		sprite_frames.scale.x = -facing.flip_scale
	elif cardinal_dir == FacingDirection.Dir.RIGHT:
		sprite_frames.scale.x = facing.flip_scale

	return true

func update_animation(state_name: StringName) -> void:
	if not Global.input_enabled:
		return
	var anim_name: StringName = facing.to_anim_name(cardinal_dir, state_name)

	if sprite_frames.sprite_frames.has_animation(anim_name):
		sprite_frames.play(anim_name)
	else:
		sprite_frames.play(state_name)
