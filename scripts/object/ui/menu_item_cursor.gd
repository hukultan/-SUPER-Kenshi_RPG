extends Label

signal cursor_selected


func cursor_select() -> void:
	print(name)
	cursor_selected.emit()
