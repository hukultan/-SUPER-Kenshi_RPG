extends Label

var velocity := Vector2.ZERO
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func initialize(p_position: Vector2, p_text: String, p_color: Color) -> void:
	position = p_position - Vector2(160.0, 160.0)
	text = p_text
	modulate = p_color

func _ready() -> void:
	velocity = randf_range(36.0, 64.0) * Vector2.from_angle(randf_range(0.0, TAU))
	await animation_player.animation_finished
	queue_free()

func _physics_process(delta: float) -> void:
	if velocity == Vector2.ZERO:
		return
	velocity -= velocity.normalized() * 64.0 * delta
	position += velocity * delta
	if velocity.length() < 1.0:
		velocity = Vector2.ZERO
