class_name State
extends Node

static var player_ref: Player

## When it starts executing
func _ready() -> void:
	pass

## When it enters the scene 
func _enter() -> void:
	pass

## When the state isnt needed and exit the scene
func _exit() ->  void:
	pass

## What happens every frame
func process_frame(_delta: float) -> State:
	return null

## What happens every synced physics frame 
func process_physics(_delta: float) -> State:
	return null

## When input is detected by the state
func _handle_input(_event: InputEvent) -> State:
	return null
