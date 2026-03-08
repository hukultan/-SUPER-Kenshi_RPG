extends Node2D


func _ready() -> void:
	AudioManager.game_audio.main_music.volume_db = -10.0
	AudioManager.play_music("res://resources/audio/music/stub_music.mp3")
