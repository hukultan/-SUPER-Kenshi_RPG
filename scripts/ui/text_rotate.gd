extends MeshInstance3D


func _process(delta: float) -> void:
	# Rotate the model every frame to get that kool effect
	await get_tree().physics_frame
	self.rotate_y(0.20 * delta)
	pass
