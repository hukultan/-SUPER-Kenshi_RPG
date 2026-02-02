extends Node

static var is_moving : bool = false
static var counter_increment : int = 192
static var counter : int = 0
static var random_number : int = 0
static var seconds_counter: float = 0.0
@onready var random_encounter_sound : AudioStreamPlayer
@onready var rng : RandomNumberGenerator 


func _ready() -> void:
	rng = RandomNumberGenerator.new()
	random_encounter_sound = AudioStreamPlayer.new()
	add_child(random_encounter_sound)
	random_encounter_sound.stream = ResourceLoader.load("res://resources/audio/alert.mp3") as AudioStream


func _process(delta: float) -> void:
	seconds_counter += delta
	if is_moving and seconds_counter >= 0.2:
		seconds_counter = 0.0
		counter += counter_increment
		random_number = rng.randi_range(0, 2)
		if random_number < (counter / 256.0) and not Global.in_battle:
			print("fight condition is true!")
			
			counter = 0
			var battle_area : StringName = ""
			var encounter_areas: Array[Node] = get_tree().get_nodes_in_group("encounter_area")
			for area : Area2D in encounter_areas:
				var overlapping_bodies : Array[Node2D] = (area as Area2D).get_overlapping_bodies()
				
				if overlapping_bodies.size() > 0:
					print("FIGHT! (inside battle area)")
					battle_area = area.name
					_start_battle(battle_area)


func _start_battle(battle_area: String) -> void:
	print("Battle Area: " + battle_area)
	random_encounter_sound.play()
	Global.input_enabled = false
	Global.in_battle = true
	var black_img : Sprite2D
	var characters : Array[Node] = get_tree().get_nodes_in_group("characters")
	for character: CharacterBody2D in characters:
		var sprite : AnimatedSprite2D = character.get_node_or_null("AnimatedSprite2D")
		black_img = character.get_node_or_null("%Black")
		sprite.visible = false
	var camera : Camera2D = get_viewport().get_camera_2d()
	var fade_tween : Tween = get_tree().create_tween().set_parallel(true)
	fade_tween.tween_property(black_img, "self_modulate:a", 0.7, 0.5).set_delay(0.1)
	var camera_tween: Tween = get_tree().create_tween().set_parallel(true)
	camera_tween.tween_property(camera, "zoom", Vector2(4.0, 4.0), 0.2)
	camera_tween.chain().tween_property(camera, "zoom", Vector2(1.0, 1.0), 0.2)
	camera_tween.chain().tween_property(camera, "zoom", Vector2(4.0, 4.0), 0.2)
	camera_tween.tween_callback(load_battle_scene.bind("res://scenes/battle/battle_map_selector.tscn"))


func load_battle_scene(path: String) -> void:
	get_tree().call_deferred(&"change_scene_to_file", path)
