class_name State_Walk
extends State

@export var move_speed: float = 250.0
@export var idle: State_Idle
@export var run: State_Run

func enter() -> void:
	actor.update_animation("walk")

func on_direction_changed(new_dir: Vector2) -> State:
	if new_dir == Vector2.ZERO:
		return idle
	return null

func get_velocity(_direction: Vector2) -> Vector2:
	return _direction * move_speed

func on_movement(_direction: Vector2) -> void:
	if _direction != Vector2.ZERO and actor.set_direction():
		EncounterController.is_moving = true
		actor.update_animation("walk")

func handle_input(_event: InputEvent) -> State:
	if Input.is_action_pressed("run"):
		return run
	return null
