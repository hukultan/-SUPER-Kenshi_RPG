extends Control


@onready var node_3d: Node3D = %Node3D
@onready var margin_container: MarginContainer = $MarginContainer
@onready var idk: Player = %IDK
@onready var back_menu_button: Button = $BackMenuButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 

func _on_play_button_pressed() -> void:
	# When we ambataplay
	# Hide the menu
	margin_container.hide() 
	# Hide the 3D title thing and stop it from running
	node_3d.hide()
	node_3d.process_mode = node_3d.PROCESS_MODE_DISABLED
	# Show hidden things
	if back_menu_button.hidden: back_menu_button.show()
	if idk.hidden: idk.show()
	# I dont know why i wrote this but it ties the entire project
	# If you delete the entire thing will become unplayable and it will ruin your /
	# premature career, wanna know? just hit CTRL + V when you play it
	DisplayServer.clipboard_set("Kenshi is a cutie gooner")

func _on_quit_button_pressed() -> void:
	# Play the quit sequence also the audio yeah i forgor
	$QuitAudio.play()
	# stop everything to process so youy cant escape the impending doom
	node_3d.process_mode = node_3d.PROCESS_MODE_DISABLED
	margin_container.process_mode = margin_container.PROCESS_MODE_DISABLED
	# When the aduio finishes it will do some funny stuff
	await $QuitAudio.finished
	# funny link that opens your broser automatically
	OS.shell_open("https://www.youtube.com/watch?v=X2WH8mHJnhM&list=RDX2WH8mHJnhM")
	# free robucks 100% true not fake wont close the program trust bro
	Quit.quit()

func _on_youtube_button_pressed() -> void:
	# Send the poor soul who touches this button to hell
	OS.shell_open("https://www.youtube.com/@ilovekenshi")


func _on_back_menu_button_pressed() -> void:
	# Hide previusly shown things to not break the main menu
	idk.hide()
	back_menu_button.hide()
	# Show and process again hidden stuff
	if margin_container.hidden: margin_container.show()
	node_3d.show()
	node_3d.process_mode = node_3d.PROCESS_MODE_INHERIT
