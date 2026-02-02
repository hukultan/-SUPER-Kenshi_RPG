class_name State_Idle
extends State

@export var walk: State_Walk

func enter() -> void:
	EncounterController.is_moving = false
	actor.update_animation(&"idle")

func on_direction_changed(new_dir: Vector2) -> State:
	if new_dir != Vector2.ZERO:
		EncounterController.is_moving = true
		return walk
	return null

func get_velocity(_direction: Vector2) -> Vector2:
	return Vector2.ZERO

func on_movement(_direction: Vector2) -> void:
	actor.set_direction()
