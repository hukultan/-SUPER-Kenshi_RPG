extends Control


@onready var node_3d: Node3D = %Node3D
@onready var margin_container: MarginContainer = $MarginContainer
@onready var kenshi: Player = %kenshi

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_play_button_pressed() -> void:
	margin_container.hide()
	if $BackMenuButton.hidden: $BackMenuButton.show()
	if kenshi.hidden: kenshi.show()
	node_3d.hide()
	node_3d.process_mode = node_3d.PROCESS_MODE_DISABLED
	DisplayServer.clipboard_set("Kenshi is a cutie gooner")

func _on_quit_button_pressed() -> void:
	$QuitAudio.play()
	node_3d.process_mode = node_3d.PROCESS_MODE_DISABLED
	margin_container.process_mode = margin_container.PROCESS_MODE_DISABLED
	await $QuitAudio.finished
	OS.shell_open("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
	get_tree().quit()

func _on_texture_button_pressed() -> void:
	OS.shell_open("https://www.youtube.com/@ilovekenshi")

func _on_back_menu_button_pressed() -> void:
	kenshi.hide()
	$BackMenuButton.hide()
	if margin_container.hidden: margin_container.show()
	node_3d.process_mode = node_3d.PROCESS_MODE_INHERIT
	node_3d.show()
