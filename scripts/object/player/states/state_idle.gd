class_name State_Idle
extends State


func _enter() -> void:
	player_ref.update_animation("blush")
	pass

func _exit() -> void:
	pass

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

func _handle_input(_event: InputEvent) -> State:
	return null
