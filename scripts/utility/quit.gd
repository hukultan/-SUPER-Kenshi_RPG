extends Node


func quit() -> void:
	# Closes the program
	get_tree().call_deferred("quit")

func _input(event: InputEvent) -> void:
	# Closes the game by being called from a key press
	if event.is_action_pressed("ui_cancel") and OS.is_debug_build():
		# Quits by pressing the Escape key
		quit()
		# Makes life easier and mkaes you not hear my annoying voice \
		# everytime you want to quit the program at testing state
