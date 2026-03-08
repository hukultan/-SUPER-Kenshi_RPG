extends Node2D

@onready var pp: Sprite2D = $PP
@onready var fill: Sprite2D = $Fill
@onready var pp_max: Sprite2D = $PPMax
@onready var number: Label = $Number
@onready var percent: Label = $Number/Percent




func _ready() -> void:
	Global.pp_changed.connect(set_pp)


func set_pp() -> void:
	fill.material.set_shader_parameter("fill", Global.pp / 250.0)
	if is_equal_approx(Global.pp, 250.0):
		number.visible = false
		pp_max.visible = true
	else:
		number.visible = true
		pp_max.visible = false
		number.text = str(floori(Global.pp / 2.5))
