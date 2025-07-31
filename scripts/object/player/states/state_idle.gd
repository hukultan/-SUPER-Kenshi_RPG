class_name State_Idle
extends State

@onready var walk: State_Walk = %Walk

func _enter() -> void:
	player_ref.update_animation("idle")
	pass

func _exit() -> void:
	pass

func process_frame(_delta: float) -> State:
	if player_ref.direction != Vector2.ZERO: return walk
	player_ref.velocity = Vector2.ZERO
	return null

func process_physics(_delta: float) -> State:
	return null

func _handle_input(_event: InputEvent) -> State:
	return null
