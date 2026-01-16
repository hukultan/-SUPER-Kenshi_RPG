extends MarginContainer


## Plays audio after pressing the quit button
@export var wanna_hear_my_voice: bool = false
## Opens a pop up window using your browser when the program closes
@export var open_browser: bool = false
## Set the scene to change
@export var next_scene: PackedScene = preload("res://scenes/map_test.tscn")

@export var node_3d: Node3D #= %Node3D
@export var quit_button: Button
@export var play_button: Button
@export var youtube_button: TextureButton
@export var quit_audio: AudioStreamPlayer

func _ready() -> void:
	quit_button.pressed.connect(_on_quit_button_pressed)
	play_button.pressed.connect(_on_play_button_pressed)
	youtube_button.pressed.connect(_on_youtube_button_pressed)


func _on_play_button_pressed() -> void:
	if next_scene != null:
		# When we ambataplay
		get_tree().change_scene_to_packed(next_scene)
	else: 
		printerr("The next scene variable is null!")
	
	# I dont know why i wrote this but it ties the entire project
	# If you delete the entire thing will become unplayable and it will ruin your /
	# premature career, wanna know? just hit CTRL + V when you play it
	#DisplayServer.clipboard_set("Kenshi is a cutie gooner")


func _on_quit_button_pressed() -> void:
	if wanna_hear_my_voice:
		# Play the quit sequence also the audio yeah i forgor
		quit_audio.play()
		# stop everything to process so youy cant escape the impending doom
		# When the aduio finishes it will do some funny stuff
		await quit_audio.finished
	node_3d.process_mode = node_3d.PROCESS_MODE_DISABLED
	self.process_mode = self.PROCESS_MODE_DISABLED
	
	if open_browser:
		# funny link that opens your broser automatically
		OS.shell_open("https://www.youtube.com/watch?v=X2WH8mHJnhM&list=RDX2WH8mHJnhM")
	
	# free robucks 100% true not fake wont close the program trust bro
	Quit.quit()


func _on_youtube_button_pressed() -> void:
	# Send the poor soul who touches this button to hell
	OS.shell_open("https://www.youtube.com/@ilovekenshi")
