extends Node

@export var pufferfish_scene: PackedScene
@export var swordfish_scene: PackedScene

func _ready() -> void:
	pass

func new_game():
	$Player.start($StartPos.position)
	$StartTimer.start()

func _on_enemy_timer_timeout():
	# Randomly choose between pufferfish and swordfish
	var mob_scene = choose_random_enemy()

	# Instantiate the chosen enemy scene
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $"Path/Spawn enemies"
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(mob.min_speed, mob.max_speed), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

func _on_start_timer_timeout() -> void:
	$EnemyTimer.start()

# Function to randomly choose between the pufferfish and swordfish
func choose_random_enemy() -> PackedScene:
	if randf() < 0.5:
		return pufferfish_scene
	else:
		return swordfish_scene
