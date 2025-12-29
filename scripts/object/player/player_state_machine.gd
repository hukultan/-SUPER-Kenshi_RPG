class_name StateMachine
extends Node

var states: Array[State] = []
var previous_state: State
var current_state: State
var actor: CharacterBody2D

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func initialize(_actor: CharacterBody2D) -> void:
	actor = _actor
	states.clear()
	for child: Node in get_children():
		if child is State:
			var s: State = child
			s.actor = actor
			states.append(s)

	if states.size() > 0:
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func change_state(new_state: State) -> void:
	if new_state == null or new_state == current_state:
		return
	if current_state:
		current_state.exit()
	previous_state = current_state
	current_state = new_state
	current_state.enter()
