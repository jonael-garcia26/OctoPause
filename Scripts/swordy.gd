extends EnemyClass

@export var min_speed: float = 300.0
@export var max_speed: float = 500.0

func _ready() -> void:
	# Ensure the swordfish faces forward
	rotation = linear_velocity.angle() + PI / 2  # Adjust the rotation so it faces the correct direction

func _process(delta: float) -> void:
	# Ensure the swordfish keeps moving in the correct direction
	linear_velocity = linear_velocity.normalized() * linear_velocity.length()
	rotation = linear_velocity.angle() + PI / 2  # Ensure it always faces forward, adjusting for the sprite's orientation

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
