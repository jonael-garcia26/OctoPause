extends Area2D

@export var maxHealth = 6
@onready var currHealth: int = maxHealth

var screen_size

signal hit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(enemy: RigidBody2D) -> void:
	currHealth-= enemy.damage
	print(currHealth)
	if currHealth <= 0:
		currHealth = maxHealth
	
	hit.emit(currHealth)
	#hide()
	#hit.emit()
	#$Hitbox.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$Hitbox.disabled = false
