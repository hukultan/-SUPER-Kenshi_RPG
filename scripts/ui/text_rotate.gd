extends MeshInstance3D

# some strings that will appear in the texxt mesh
var random_text: PackedStringArray = ["idk what to type", "rpg about kenshi yeey", \
"Dev build!", "Viva el trp!!1", "homero va sa recoltalrte?", "DESTROY THIS FUCKING PROGRAM", \
"Minian (its not a typo thast the name)", "Kenshi say gex", \
"Oh hi! Welcome to my game (this is totally not a baldi reference)", "Dos equipos son uno rojo y otro azul",\
"guys pls stop slaving me i already did a lot for this", "get me out of the basement", "banana", "Black man twerking",\
"Heres your progress now let me see my family",]
const ROTATE_SPEED: float = 0.16

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
	pass
	
