extends MarginContainer


## Plays audio after pressing the quit button
@export var wanna_hear_my_voice: bool = false
## Opens a pop up window using your browser when the program closes
@export var open_browser: bool = false

@export var node_3d: Node3D #= %Node3D
@export var quit_button: Button
@export var youtube_button: TextureButton
@export var quit_audio: AudioStreamPlayer
@export var menu_music: AudioStreamPlayer

func _ready() -> void:
	if not quit_button.pressed.is_connected(_on_quit_button_pressed):
		quit_button.pressed.connect(_on_quit_button_pressed)
	if not youtube_button.pressed.is_connected(_on_youtube_button_pressed):
		youtube_button.pressed.connect(_on_youtube_button_pressed)




func _on_quit_button_pressed() -> void:
	if wanna_hear_my_voice:
		# Play the quit sequence also the audio yeah i forgor
		quit_audio.play()
		# stop everything to process so youy cant escape the impending doom
		# When the aduio finishes it will do some funny stuff
		await quit_audio.finished
	node_3d.process_mode = node_3d.PROCESS_MODE_DISABLED
	self.process_mode = self.PROCESS_MODE_DISABLED
	menu_music.process_mode = menu_music.PROCESS_MODE_DISABLED
	
	if open_browser:
		# funny link that opens your broser automatically
		OS.shell_open("https://www.youtube.com/watch?v=X2WH8mHJnhM&list=RDX2WH8mHJnhM")
	
	# free robucks 100% true not fake wont close the program trust bro
	Quit.quit()


func _on_youtube_button_pressed() -> void:
	# Send the poor soul who touches this button to hell
	OS.shell_open("https://www.youtube.com/@ilovekenshi")
