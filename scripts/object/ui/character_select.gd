extends Control

@export var spawn_point: Marker2D
@export var entities: Array[PackedScene]
@export var menu_scene: PackedScene

@export var character_selection_panel: PanelContainer #= $CharacterSelectionPanel
@export var canvas_layer : CanvasLayer
@export var back_button: Button
@export var character_container: VBoxContainer
@export var kenshi_button: Button


func _ready() -> void:
	if not back_button.pressed.is_connected(_on_back_button_pressed):
		back_button.pressed.connect(_on_back_button_pressed)
	if not kenshi_button.pressed.is_connected(_on_kenshi_button_pressed):
		kenshi_button.pressed.connect(_on_kenshi_button_pressed)
	PostProcessing.fade_out(0.0)
	await PostProcessing.fade_finished
	PostProcessing.fade_in(0.6)


func _on_back_button_pressed() -> void:
	PostProcessing.fade_out(0.3)
	if canvas_layer.visible: 
		canvas_layer.hide()
	await PostProcessing.fade_finished
	get_tree().change_scene_to_packed(menu_scene)


func _on_kenshi_button_pressed() -> void:
	_spawn_entity(entities[0])


func _spawn_entity(entity: PackedScene) -> void:
	var child_node : CharacterBody2D = entity.instantiate()
	spawn_point.add_child(child_node)
	if character_selection_panel.visible: 
		character_selection_panel.hide()
