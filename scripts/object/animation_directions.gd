class_name FacingDirection
extends Resource

enum Dir {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

# Optional per-direction animation prefixes
@export var up_prefix: StringName = "up_"
@export var down_prefix: StringName = "down_"
@export var horizontal_prefix: StringName = "side_"  # LEFT/RIGHT use same animation

# Horizontal sprite scale for flipping
@export var flip_scale: float = 0.661

# Converts enum direction + state_name to final animation string
func to_anim_name(dir: int, state_name: StringName) -> StringName:
	match dir:
		Dir.UP:
			return StringName(up_prefix + state_name)
		Dir.DOWN:
			return StringName(down_prefix + state_name)
		Dir.LEFT, Dir.RIGHT:
			return StringName(horizontal_prefix + state_name)
		_:
			return state_name
