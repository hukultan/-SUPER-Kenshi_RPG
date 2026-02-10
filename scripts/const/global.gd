extends Node

signal pp_changed
#signal enemy_killed
var pp : float = 0.0:
	set(p_pp):
		pp = minf(p_pp, 250.0)
		pp_changed.emit()

var pp_coefficient := 1
var in_battle : bool = false
var input_enabled : bool = true

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreen"): 
			if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			else:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	pass


func change_to_scene(scene_path: String, fade : bool = true) -> void:
	if fade:
		PostProcessing.fade_out(0.5)
		get_tree().paused = true
		await PostProcessing.fade_finished
		get_tree().change_scene_to_file(scene_path)
		PostProcessing.fade_in(0.5)
		await PostProcessing.fade_finished
		get_tree().paused = false
	else:
		get_tree().change_scene_to_file(scene_path)
