extends Control

@export var spawn_point: Marker2D
@export var entities: Array[PackedScene]

@onready var character_selection_panel: PanelContainer = $CharacterSelectionPanel


func _ready() -> void:
	PostProcessing.fade_out(0.0)
	await PostProcessing.fade_finished
	PostProcessing.fade_in(0.6)
	pass


func _on_back_button_pressed() -> void:
	PostProcessing.fade_out(0.4)
	if $"../CanvasLayer".visible: $"../CanvasLayer".hide()
	await PostProcessing.fade_finished
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	PostProcessing.fade_out(0.2)


func _on_kenshi_button_pressed() -> void:
	_spawn_entity(entities[0])

func _on_human_button_pressed() -> void:
	_spawn_entity(entities[1])

func _spawn_entity(entity: PackedScene) -> void:
	var child_node := entity.instantiate()
	spawn_point.add_child(child_node)
	if character_selection_panel.visible: character_selection_panel.hide()
