extends Button

@export var main_menu_scene: String = "res://scenes/new_main.tscn"

func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	if main_menu_scene != null:
		AudioManager.play_sound(AudioManager.game_audio.sound_1)
		Global.change_to_scene(main_menu_scene, true)
