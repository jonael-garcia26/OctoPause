extends Area2D

@export var health = 100
var screen_size

signal hit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$Hitbox.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$Hitbox.disabled = false
