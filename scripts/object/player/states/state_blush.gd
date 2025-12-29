class_name State_Blush
extends State

@export var kenshi_idle: KenshiIdle


func enter() -> void:
	actor.update_animation("blush")

func get_velocity(_direction: Vector2) -> Vector2:
	return Vector2.ZERO

func on_movement(_direction: Vector2) -> void:
	actor.velocity = Vector2.ZERO

func handle_input(event: InputEvent) -> State:
	if event.is_action_released("special_action"):
		return kenshi_idle
	return null
