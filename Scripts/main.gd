extends Node

@export var mob_scenes: Array[PackedScene]
@onready var NemoContainer = $CanvasLayer/NemoContainer
@onready var player = $Player
@onready var EnemyTimer = $EnemyTimer


func _ready() -> void:
	Global.Score = 0
	NemoContainer.setMaxNemos(player.maxHealth)
	NemoContainer.updateNemos(player.currHealth)
	player.hit.connect(NemoContainer.updateNemos)

func new_game():
	$Player.start($StartPos.position)
	$StartTimer.start()

func _on_enemy_timer_timeout():
	#print(EnemyTimer.wait_time)
	if EnemyTimer.wait_time > 0.5:
		EnemyTimer.wait_time = round((EnemyTimer.wait_time*0.90)*100) / 100
		if EnemyTimer.wait_time <= 0.5:
			EnemyTimer.wait_time = 0.5
	# Randomly choose between pufferfish and swordfish
	var index = choose_random_enemy()
	var mob_scene = mob_scenes[index]

	# Instantiate the chosen enemy scene
	var mob = mob_scene.instantiate()
	if index == 1:
		mob.add_to_group("Swordies")
	mob.add_to_group("enemies")

	# Choose a random location on Path2D.
	var mob_spawn_location = $"Path/Spawn enemies"
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position
	
	#Calculate the center of the screen
	var screen_center = get_viewport().get_visible_rect().size / 2

	#Calculate direction towards the center of the screen
	var direction_vector = (screen_center - mob.position).normalized()
	
	#Set the mob's rotation to face the center of the screen
	mob.rotation = direction_vector.angle()

	# Choose the velocity for the mob.
	var velocity = Vector2(mob.velocity, 0.0)
	mob.linear_velocity = direction_vector * velocity.length()
	
	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

func _on_start_timer_timeout() -> void:
	EnemyTimer.start()

# Function to randomly choose between the pufferfish and swordfish
func choose_random_enemy() -> int:
	return randi() % mob_scenes.size()
