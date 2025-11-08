extends Node2D

var in_attack := false
var turn_timer := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_positions($Characters, Global.characters, Vector2(108.0, 0.0))
	set_positions($Enemies, Global.monsters, Vector2(640.0 - 108.0, 0.0))
	Global.display_text.emit(Global.get_opening_line(), false)
	Global.enemy_killed.connect(enemy_killed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_positions(parent: Node, nodes: Array, offset := Vector2.ZERO):
	var size := nodes.size()
	if size == 1:
		var node: Node2D = nodes[0]
		parent.add_child(node)
		node.position = Vector2(0.0, Global.CENTER.y) + offset
	elif size == 2:
		var node_1: Node2D = nodes[0]
		var node_2: Node2D = nodes[1]
		parent.add_child(node_1)
		parent.add_child(node_2)
		node_1.position = Vector2(0.0, Global.CENTER.y - 48.0) + offset
		node_2.position = Vector2(0.0, Global.CENTER.y + 96.0 - 48.0) + offset
	else:
		for i: int in size:
			var node: Node2D = nodes[i]
			parent.add_child(node)
			node.position.x = 0.0
			node.position.y = Global.CENTER.y - 96.0 + 2.0 * 96.0 * i / (size - 1)
			node.position += offset


func hurt(p_damage: int) -> void:
	var alive_characters: Array[Character] = []
	for character: Character in Global.characters:
		if character.alive:
			alive_characters.append(character)
	if alive_characters.is_empty():
		return
	var character: Character = alive_characters.pick_random()
	character.hurt(p_damage)
	if alive_characters.size() == 1 and !character.alive:
		await character.faint_finished
		Global.change_to_scene("res://scenes/menus/lost_screen/lost_screen.tscn")


func enemy_killed() -> void:
	var monsters_dead := true
	for monster: Monster in Global.monsters:
		if monster != null:
			monsters_dead = false
			break
	if monsters_dead:
		$BottomPanel.continue_battle = false
		$BottomPanel/AttackTiming.focused = false
		for character: Character in Global.characters:
			character.do_animation(Character.Animations.IDLE)
		Global.display_text.emit("  * You won!\n[color=#000]----[/color]Got 0 EXP and 10D$.", true)
		await Global.text_finished
		Global.change_to_scene("res://scenes/menus/win_screen/win_screen.tscn")
