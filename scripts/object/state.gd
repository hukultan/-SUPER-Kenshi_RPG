class_name State
extends Node

var actor: CharacterBody2D

# Called when the state becomes active
func enter() -> void:
	pass

# Called when the state stops being active
func exit() -> void:
	pass

# Optional: input-driven transition
func handle_input(_event: InputEvent) -> State:
	return null

# Event-driven transition hook (direction changes)
func on_direction_changed(_direction: Vector2) -> State:
	return null

# Movement update per frame (update animations, sprite flip)
func on_movement(_direction: Vector2) -> void:
	pass

# Return velocity for the actor
func get_velocity(_direction: Vector2) -> Vector2:
	return Vector2.ZERO
