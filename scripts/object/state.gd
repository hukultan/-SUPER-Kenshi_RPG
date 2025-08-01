class_name State
extends Node

static var player_ref: Player


func _ready() -> void:
	pass

func _enter() -> void:
	pass

func _exit() ->  void:
	pass

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

func _handle_input(_event: InputEvent) -> State:
	return null
