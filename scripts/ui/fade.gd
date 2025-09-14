extends Node2D


signal fade_finished
@onready var canvas_modulate: CanvasModulate = $CanvasModulate

func fade_out() -> void:
	var tween := get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(canvas_modulate, "color", Color.BLACK, 0.8)
	tween.finished.connect(fade_finished.emit)

func fade_in() -> void:
	var tween := get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(canvas_modulate, "color", Color.WHITE, 0.8)
	tween.finished.connect(fade_finished.emit)
