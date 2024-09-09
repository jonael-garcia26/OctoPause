extends RigidBody2D
class_name EnemyClass

@export var health = 100
@export var velocity = 150
@export var damage = 1

signal bullet_shot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func take_damage():
	health -= 25
	if health <= 0:
		queue_free()
