class_name State_Run
extends State

# ATTENTION: Thanks for your attention :) 
# Btw this actually works, now just saying. 

# This value is used for increasing the player's velocity
# It actually multiplies to the walking speed so be mindful \
# when setting the values for this, it is reccomended to leave it at 2.5
@export_range(1.5, 100.0, 0.5) var run_speed: float = 2.5
@onready var walk: State_Walk = %Walk

func _enter() -> void:
	pass

func _exit() -> void:
	pass

func process_frame(_delta: float) -> State:
	if player_ref.direction == Vector2.ZERO: return walk
	player_ref.velocity = player_ref.direction * walk.move_speed * run_speed
	if player_ref.set_direction(): player_ref.update_animation("walk")
	return null

func process_physics(_delta: float) -> State:
	return null

func _handle_input(event: InputEvent) -> State:
	if event.is_action_released("run"): return walk
	return null
