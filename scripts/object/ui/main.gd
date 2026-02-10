extends Node2D

## wanna dissable that annoying pop up at execution of the program?
@export var funi_alert: bool = false
@export var play_button: Button
## Set the scene to change
@export var next_scene: String = "res://scenes/new_map.tscn"

func _ready() -> void:
	# Do the pop-up alert window
	# Why? I dont freakyng know
	if funi_alert:
		if OS.is_debug_build(): OS.alert( \
		"you testing huh?, good luck testing and debugging this", "Developer detected")
		else: 
			OS.alert("👅👅👅👅👅👅👅👅👅👅👅👅👅👅👅👅👅👅👅", "Freak detected!")
	if not play_button.pressed.is_connected(_on_play_button_pressed):
		play_button.pressed.connect(_on_play_button_pressed)


func _on_play_button_pressed() -> void:
	if not next_scene.is_empty():
		# When we ambataplay
		Global.change_to_scene(next_scene, true)
	else: 
		printerr("The next scene variable is null!")
	# I dont know why i wrote this but it ties the entire project
	# If you delete the entire thing will become unplayable and it will ruin your /
	# premature career, wanna know? just hit CTRL + V when you play it
	#DisplayServer.clipboard_set("Kenshi is a cutie gooner")
