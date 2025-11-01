extends Node2D


signal fade_finished
@onready var canvas_modulate: CanvasModulate = $CanvasModulate
@onready var world_environment: WorldEnvironment = $WorldEnvironment

func fade_out(time_scale: float) -> void:
	var tween := get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(canvas_modulate, "color", Color.BLACK, time_scale)
	tween.finished.connect(fade_finished.emit)

func fade_in(time_scale: float) -> void:
	var tween := get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(canvas_modulate, "color", Color.WHITE, time_scale)
	tween.finished.connect(fade_finished.emit)

func _unhandled_input(event: InputEvent) -> void:
	var compositor_effect := world_environment.compositor.compositor_effects 
	if event.is_action_pressed("ui_accept") and !compositor_effect[0].enabled:
		compositor_effect[0].enabled = true
	elif event.is_action_pressed("ui_accept") and compositor_effect[0].enabled:
		compositor_effect[0].enabled = false
