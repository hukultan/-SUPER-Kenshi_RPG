class_name State_Run
extends State

@export var run_multiplier: float = 2.5
@export var walk: State_Walk
@export var idle: State_Idle

func enter() -> void:
	actor.update_animation("walk")

func on_direction_changed(new_dir: Vector2) -> State:
	if new_dir == Vector2.ZERO:
		return idle
	return null

func get_velocity(_direction: Vector2) -> Vector2:
	return _direction * walk.move_speed * run_multiplier

func on_movement(_direction: Vector2) -> void:
	if _direction != Vector2.ZERO and actor.set_direction():
		actor.update_animation("walk")

func handle_input(_event: InputEvent) -> State:
	if Input.is_action_just_released("run"):
		return walk
	return null
