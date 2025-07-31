class_name PlayerStateMachine
extends Node

var states: Array[State]
var previous_state: State
var current_state: State


func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_DISABLED
	pass

func _process(delta: float) -> void:
	_change_state(current_state.process_frame(delta))
	pass

func _physics_process(delta: float) -> void:
	_change_state(current_state.process_physics(delta))
	pass


func _unhandled_input(event: InputEvent) -> void:
	_change_state(current_state._handle_input(event))
	pass

func _initialize(_player: Player) -> void:
	states = []
	for a in get_children():
		if a is State:
			states.append(a)
	if states.size() > 0:
		states[0].player_ref = _player
		_change_state(states[0])
		self.process_mode = Node.PROCESS_MODE_INHERIT

func _change_state(new_state: State) -> void:
	if new_state == null || new_state == current_state:
		return
	if current_state:
		current_state._exit()
	previous_state = current_state
	current_state = new_state
	current_state._enter()
