extends Node


signal pp_changed
#signal enemy_killed
#signal display_text(p_text: String, p_requires_input: bool)
#signal text_finished
enum {
	FIGHT, ACT, ITEM, SPARE, DEFEND,
}
const YELLOW := Color("#ffff00")
const GREEN := Color("#00ff00")
const CENTER := Vector2(308.0, 171.0)
var pp : float = 0.0:
	set(p_pp):
		pp = minf(p_pp, 250.0)
		pp_changed.emit()


var pp_coefficient := 1
var displaying_text := false

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscrn"): 
			if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			else:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	pass


func change_to_scene(scene_path: String, fade : bool = true) -> void:
	if fade:
		PostProcessing.fade_out(0.1)
		get_tree().paused = true
		await PostProcessing.fade_finished
		get_tree().change_scene_to_file(scene_path)
		PostProcessing.fade_in(0.5)
		await PostProcessing.fade_finished
		get_tree().paused = false
	else:
		get_tree().change_scene_to_file(scene_path)

func wait_time(time: float) -> Signal:
	return get_tree().create_timer(time).timeout
