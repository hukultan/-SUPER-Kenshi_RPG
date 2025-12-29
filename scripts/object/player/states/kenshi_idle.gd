class_name KenshiIdle
extends State_Idle

@export var blush: State_Blush

func handle_input(_event: InputEvent) -> State:
	if _event.is_action_pressed("special_action") and is_instance_valid(blush):
		return blush
	return null
