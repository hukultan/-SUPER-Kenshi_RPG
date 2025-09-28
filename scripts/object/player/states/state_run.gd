class_name State_Run
extends State

# WARNING: This currently does not do anything, this is WIP.

@export var run_speed_multiplier: float = 2.0

func _enter() -> void:
	pass

func _exit() -> void:
	pass

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

func _handle_input(_event: InputEvent) -> State:
	return null
