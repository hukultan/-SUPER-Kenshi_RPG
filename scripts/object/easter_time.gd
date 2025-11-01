extends Control

@onready var audio_scream_player: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	await get_tree().create_timer(1.3).timeout
	Quit.quit()
