extends Area2D

@onready var window_size = DisplayServer.window_get_size()
@onready var bodies_in_area = []
@onready var ColPol = $CollisionPolygon2D
@onready var Pol = $Polygon2D
@onready var CD = $Cooldown

func _ready() -> void:
	var Wx = window_size.x/2
	var Wy = window_size.y/2
	position = Vector2(Wx,Wy)
	visible = false
	var pol_points = [
		Vector2(25, -25),
		Vector2(Wx, -1*Wy),
		Vector2(Wx, Wy),
		Vector2(25, 25)
	]
	ColPol.polygon = pol_points
	Pol.polygon = pol_points

func _process(_delta: float) -> void:
	if CD.is_stopped():
		if Input.is_action_just_pressed("up"):
			rotation = 270 * (PI/180)
			visible = true
			CD.start()
		elif Input.is_action_just_pressed("right"):
			rotation = 0 * (PI/180)
			visible = true
			CD.start()
		elif Input.is_action_just_pressed("down"):
			rotation = 90 * (PI/180)
			visible = true
			CD.start()
		elif Input.is_action_just_pressed("left"):
			rotation = 180 * (PI/180)
			visible = true
			CD.start()
	if visible:
		_check_overlapping_bodies()

func _check_overlapping_bodies() -> void:
	# Checks for bodies in the area
	var Current_bodies = get_overlapping_bodies()
	for body in Current_bodies:
		if body is RigidBody2D:
			if body not in bodies_in_area:
				bodies_in_area.append(body)
			if not body.sleeping:
				pause_rigid_body(body)
	
	# Unpauses any body in area
	for body in bodies_in_area:
		if body not in Current_bodies:
			bodies_in_area.erase(body)
			if body != null:
				unpause_rigid_body(body)


func pause_rigid_body(body: RigidBody2D):
	if body.is_in_group("Swordies"):
		var screen_center = get_viewport().get_visible_rect().size / 2
		var direction_vector = (screen_center - body.position).normalized()
		var velocity = Vector2(body.velocity/5, 0.0)
		body.linear_velocity = direction_vector * velocity.length()
	else:
		body.sleeping = true  # Put the body to sleep

func unpause_rigid_body(body: RigidBody2D):
	body.sleeping = false  
	var screen_center = get_viewport().get_visible_rect().size / 2
	var direction_vector = (screen_center - body.position).normalized()
	var velocity = Vector2(body.velocity, 0.0)
	body.linear_velocity = direction_vector * velocity.length()
