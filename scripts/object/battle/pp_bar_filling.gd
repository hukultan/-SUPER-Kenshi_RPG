extends Node2D

func _ready() -> void:
	Global.pp_changed.connect(set_pp)

func set_pp() -> void:
	$BG.material.set_shader_parameter("fill", Global.pp / 250.0)
	if is_equal_approx(Global.pp, 250.0):
		$Number.visible = false
		$PPMax.visible = true
	else:
		$Number.visible = true
		$PPMax.visible = false
		$Number.text = str(floori(Global.pp / 2.5))
