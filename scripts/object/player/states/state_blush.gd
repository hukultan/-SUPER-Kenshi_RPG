class_name State_Blush
extends State

@onready var idle: State_Idle = %Idle

func _enter() -> void:
	player_ref.update_animation("blush")
	pass

func _exit() -> void:
	pass

func process_frame(_delta: float) -> State:
	player_ref.velocity = Vector2.ZERO
	return null

func process_physics(_delta: float) -> State:
	return null

func _handle_input(_event: InputEvent) -> State:
	if _event.is_action_released("special_action"): 
		return idle
	return null
