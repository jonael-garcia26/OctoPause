extends Area2D

@export var maxHealth = 6
@onready var currHealth: int = maxHealth

var screen_size
var inkBullet = preload("res://Scenes/ink_bullet.tscn")
var shootTimer = 0
var shootInterval = 0.3

signal hit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var closestEnemy = get_closest_enemy()
	if closestEnemy:
		look_at(closestEnemy.position)
		
	shootTimer += delta
	if shootTimer >= shootInterval:
		shoot_ink_bullet()
		shootTimer = 0


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


func get_closest_enemy():
	var closest_enemy: EnemyClass = null
	var closest_dist = INF
	var enemies = get_parent().get_tree().get_nodes_in_group("enemies")
	
	if(!enemies.is_empty()):
		for enemy in enemies:
			var dist = global_position.distance_to(enemy.global_position)
			if dist < closest_dist:
				closest_dist = dist
				closest_enemy = enemy
		
	return closest_enemy


func shoot_ink_bullet():
	var bulletInstance = inkBullet.instantiate()
	bulletInstance.position = $InkPoint.get_global_position()
	bulletInstance.rotation_degrees = rotation_degrees
	get_tree().get_root().add_child(bulletInstance)
