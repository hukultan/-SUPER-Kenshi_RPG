class_name State_Walk
extends State

@export var move_speed: float = 250.0
@onready var idle: State_Idle = %Idle
@onready var run: State_Run = %Run


func _enter() -> void:
	player_ref.update_animation("walk")
	pass

func _exit() -> void:
	pass

func process_frame(_delta: float) -> State:
	if player_ref.direction == Vector2.ZERO: return idle
	player_ref.velocity = player_ref.direction * move_speed
	if player_ref.set_direction(): player_ref.update_animation("walk")
	return null

func process_physics(_delta: float) -> State:
	return null

func _handle_input(event: InputEvent) -> State:
	if event.is_action_pressed("run"): return run
	return null
