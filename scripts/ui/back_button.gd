extends Control


const KENSHI := preload("uid://dmftsli26rx26")
const HUMAN := preload("uid://bj33lek3nolv5")

@onready var character_selection_panel: PanelContainer = $CharacterSelectionPanel


func _on_back_button_pressed() -> void:
	PostProcessing.fade_out(0.3)
	await PostProcessing.fade_finished
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_kenshi_button_pressed() -> void:
	_spawn_entity(KENSHI)

func _on_human_button_pressed() -> void:
	_spawn_entity(HUMAN)

func _spawn_entity(entity: PackedScene) -> void:
	var child_node := entity.instantiate()
	$"../../SpawnPoint".add_child(child_node)
	if character_selection_panel.visible: character_selection_panel.hide()
