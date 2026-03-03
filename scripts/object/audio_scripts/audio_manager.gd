extends Node

const POOL_SIZE: int = 5

@export var game_audio: GameAudio
@export_category("Components")
@export var music_player: AudioStreamPlayer
@export var effects_pool: Node2D

var sfx_players: Array[AudioStreamPlayer] = []


func _ready() -> void:
	for i: int in range(0, POOL_SIZE):
		var player := AudioStreamPlayer.new()
		effects_pool.add_child(player)
		sfx_players.append(player)


func play_sound(setting: AudioSetting) -> void:
	var player: AudioStreamPlayer = get_next_sfx_player()
	player.stream = setting.source
	player.volume_db = setting.volume_db
	player.bus = &"SFX"
	player.play()


func get_next_sfx_player() -> AudioStreamPlayer:
	for player: AudioStreamPlayer in sfx_players:
		if not player.playing:
			return player
	
	var player:= AudioStreamPlayer.new()
	player.set_meta(&"temp", true)
	player.finished.connect(on_player_finished.bind(player))
	
	effects_pool.add_child(player)
	return player



func on_player_finished(player: AudioStreamPlayer) -> void:
	if player.has_meta(&"temp"):
		player.queue_free()



func play_music(path: String) -> void:
	game_audio.main_music.source = ResourceLoader.load(path) as AudioStream
	music_player.stream = game_audio.main_music.source
	music_player.volume_db = game_audio.main_music.volume_db
	music_player.play()


func stop_music() -> void:
	if music_player:
		music_player.stop()
