extends Node

@export var mob_scene: PackedScene

func _ready() -> void:
	pass

func new_game():
	$Player.start($StartPos.position)
	$StartTimer.start()
	
func _on_enemy_timer_timeout():
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $"Path/Spawn enemies"
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2 #ESTE CANTO BREGA CON DIRECCION, REVISAR SOON

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150, 250), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)


func _on_start_timer_timeout() -> void:
	$EnemyTimer.start()
