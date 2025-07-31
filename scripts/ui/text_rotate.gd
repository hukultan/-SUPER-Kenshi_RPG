extends MeshInstance3D


func _process(delta: float) -> void:
	# Rotate the model every frame to get that kool effect
	self.rotate_y(0.16 * delta)
	pass
