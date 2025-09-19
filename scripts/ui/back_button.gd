extends Control


func _on_button_pressed() -> void:
	PostProcessing.fade_out()
	await PostProcessing.fade_finished
	get_tree().change_scene_to_file("res://scenes/main.tscn")
