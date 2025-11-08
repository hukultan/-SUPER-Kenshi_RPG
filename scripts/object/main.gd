extends Node2D

## wanna dissable that annoying pop up at execution of the program?
@export var funi_alert: bool = true

var rand_chance: int = randi_range(21, 62)

func _ready() -> void:
	randomize()
	PostProcessing.fade_in(0.3)
	# Do the pop-up alert window
	# Why? I dont freakyng know
	if funi_alert:
		if OS.is_debug_build(): OS.alert( \
		"you testing huh?, good luck testing and debugging this", "Developer detected")
		else: OS.alert("👅👅👅👅👅👅👅👅👅👅👅👅👅👅👅👅👅👅👅", "Freak detected!")
	if rand_chance == 59:
		if $"Control/👀".hidden: $"Control/👀".show()
	pass
