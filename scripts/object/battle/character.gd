extends Node2D
class_name Character

enum Animations {
	IDLE, PREP_ATTACK, PREP_ACT, PREP_ITEM, PREP_SPARE, ATTACK, ACT, USE_ITEM, SPARE, DEFEND, FAINT, REVIVE
}

@export var title := ""
@export var weapon: Equippable
@export var armors: Array[Equippable]
@export var current_hp := 100
@export var max_hp := 1
@export var strength := 0:
	get():
		var equipped_strength := 0 if !weapon else weapon.attack
		for armor: Equippable in armors:
			equipped_strength += armor.attack
		return strength + equipped_strength
@export var defense := 0:
	get():
		var equipped_defense := 0 if !weapon else weapon.defense
		for armor: Equippable in armors:
			equipped_defense += armor.defense
		return defense + equipped_defense
@export var magic := 0:
	get():
		var equipped_magic := 0 if !weapon else weapon.magic
		for armor: Equippable in armors:
			equipped_magic += armor.magic
		return magic + equipped_magic
@export var uses_magic := false
@export_color_no_alpha var main_color := Color.WHITE
@export_color_no_alpha var icon_color := Color.GRAY
@export var icon: Texture2D = preload("res://textures/battle/character/sample_char_icon.png")

@export_node_path("Sprite2D") var main_sprite
var sprite: Sprite2D
var mat: ShaderMaterial
var alive := true
var defending := false
var shake := 0.0

## The list of default spells the character can use. Only for characters with do_magic set to true.
@export var spells: Array[Spell] = []

signal health_changed(p_new_health: int)
signal act_finished
signal spell_finished
signal item_used
signal spare_finished
signal faint_finished

func _ready() -> void:
	if !main_sprite:
		return
	sprite = get_node(main_sprite)
	mat = ShaderMaterial.new()
	mat.shader = preload("res://shaders/new_shader.gdshader")
	sprite.material = mat
	await get_tree().create_timer(randf_range(0.0, 0.6)).timeout
	do_animation(Animations.IDLE)

func swap_armor(p_id: int, p_armor: Equippable) -> void:
	if armors.size() < 2:
		armors.resize(2)
	armors[p_id] = p_armor

func shake_sprite(p_amount: float) -> void:
	shake = p_amount

func do_animation(_p_animation: Animations) -> Signal:
	return get_tree().create_timer(0.1).timeout
