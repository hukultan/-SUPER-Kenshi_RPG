extends MeshInstance3D

## Do you want the mesh to change color?
@export var color_enabled: bool = true
# the rotation speed for the rotating animation
const ROTATE_SPEED: float = 0.16
# some strings that will appear in the texxt mesh
var random_text: Array[StringName] = ["idk what to type", "rpg about kenshi yeey", \
"Dev build!", "Viva el trp!!1", "homero va sa recoltalrte?", "DESTROY THIS FUCKING PROGRAM", \
"Minian (its not a typo thast the name)", "Kenshi say gex", \
"Oh hi! Welcome to my game (this is totally not a baldi reference)", "Dos equipos son uno rojo y otro azul",\
"guys pls stop slaving me i already did a lot for this", "get me out of the basement", "banana", "Black man twerking",\
"Heres your progress now let me see my family",]
var tween: Tween 

func _ready() -> void:
	# get the mesh resource
	var text_mesh := self.mesh
	# set a random string from the variable and set it to the mesh
	text_mesh.text = random_text[randi() % random_text.size()]
	pass

func _process(delta: float) -> void:
	# Rotate the model every frame to get that kool effect
	await get_tree().physics_frame
	self.rotate_y(ROTATE_SPEED * delta)
	_change_material_color(0.5)
	pass

func _change_material_color(time_speed: float) -> void:
	if tween: tween.kill()
	var material := self.get_active_material(0)
	if material == null: 
		printerr("Material "+str(material)+" of mesh "+self.get_name()+" is null!")
		return
	if !color_enabled:
		material.albedo_color = Color.WHITE
		material.resource_local_to_scene = false
		return
	elif material != null:
		tween = create_tween()
		var rand_color: Color = Color(randf(), randf(), randf(), 1.0) 
		tween.tween_property(material, "albedo_color", rand_color, time_speed).set_trans(Tween.TRANS_LINEAR)
