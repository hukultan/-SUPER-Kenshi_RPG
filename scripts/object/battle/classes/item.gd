class_name Item
extends Resource

enum TYPE {
	NONE, HEAL, WEAPON, ARMOR
}

@export var name := "Item"
@export var short_description := ""
@export_multiline var long_description := ""
@export var type := TYPE.NONE
@export var amount := 0
