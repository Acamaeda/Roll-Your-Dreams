extends RigidBody3D

var nonrolling : Node3D
var nonscaling : Node3D

var collector : Node3D
var base_mass = 1.5
var rolling_force = 60.0
@export var speed_mult = 1.0
@export var horizontal_mult = 0.66
@export var back_mult = 0.66
@export var turn_speed = 1.2
var slow_force = 40.0
var max_speed = 20.0
var too_slow = 5.0
var floor_angle = 0.5
var friction = 1.0

var quickturn_speed = 0.3
var quickturn_left = 0.0

var horizontal = 0.0
var vertical = 0.0
var turn = 0.0
var last_vel = Vector3.ZERO
@onready var last_pos= position
@onready var last_rot = rotation
var stored_delta = 0.0167
var camera_angle = 0.0
var camera_scale = 0.0
var camera_change_limit = 4.0

var grounded = false
var turn_vel = 0.0

var stuck_timer = 0.0
var stuck_timer2 = 0.0

var stuck_limit = 0.75
var initial_stuck_direction = null
var min_height = 0.0
var spawnpoint : Node3D

var stopped = false

func _ready() -> void:
	nonrolling = get_node("Inner Workings/Nonrolling")
	nonscaling = get_node("Inner Workings/Nonscaling")

	collector = get_node("Collector")

	nonrolling.top_level = true
	if !spawnpoint:
		spawnpoint = load("res://Engine/Gameplay/Player/SpawnPoint.tscn").instantiate()
		get_parent().add_child.call_deferred(spawnpoint)
		spawnpoint.position = position
		
	var pusher = nonrolling.get_node("Pusher")
	for child in get_node("Pusher Character").get_children():
		child.reparent(pusher, false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	stored_delta = delta

func _integrate_forces(state: PhysicsDirectBodyState3D):
	set_collision_mask_value(6, false)
	update_size();
	check_collisions(state)
	if (stopped):
		vertical = 0.0
		horizontal = 0.0
	else:
		inputs_advanced();
	var inputs = Vector2(vertical, horizontal * horizontal_mult)
	if vertical > 0:
		inputs.x = inputs.x * back_mult
	inputs = inputs.rotated(-1 * nonrolling.rotation.y)
	
	var animation = Vector2(0, 0)
	
	if (quickturn_left > 0):
		var turn_amount = min(quickturn_left, stored_delta/quickturn_speed*PI)
		quickturn_left -= turn_amount
		camera_angle += turn_amount
		angular_velocity = Vector3.ZERO
		animation = Vector2(1, 0)
	elif (Input.is_action_just_pressed("QuickTurn") && angular_velocity.length() < too_slow*1.5):
		quickturn_left = PI
		turn_vel = 0.0
		angular_velocity = Vector3.ZERO
		animation = Vector2(1, 0)

	else:
		var total_force = rolling_force*speed_mult
		#Speed up if player is just starting to move
		if(state.angular_velocity.length() < too_slow):
			total_force *= 2
		var change = Vector3(total_force*inputs.x*stored_delta, 0,  total_force*inputs.y*stored_delta)
		state.angular_velocity.x += change.x
		state.angular_velocity.z += change.z
		turn_vel = lerp(turn_vel, turn*turn_speed, turn_speed*stored_delta * 10)
		
		camera_angle += turn_vel*stored_delta;
		slow_down(stored_delta, state, change, inputs)
		animation = calc_animation()
		
	check_stuck(state, inputs)
	
	nonrolling.rotation.y = camera_angle
	nonrolling.global_position = global_position
	
	nonscaling.rotation = global_rotation
	nonscaling.position = global_position
	for child in nonrolling.get_node("Pusher").get_children():
		child.animation = animation

	last_pos = position
	last_rot = rotation

func calc_animation():
	var adjusted_velocity = linear_velocity.rotated(Vector3.UP, camera_angle*-1)
	var y = adjusted_velocity.z *-1
	if (abs(y)) < 0.001: y = 0.0
	var x = adjusted_velocity.x + turn_vel
	if (abs(x)) < 0.001: x = 0.0

	return Vector2(x, y)

func check_collisions(state : PhysicsDirectBodyState3D):
	grounded=false
	var ceilinged = false
	for i in range(0, state.get_contact_count()):
		var c = state.get_contact_local_normal(i)
		if (c.dot(Vector3.UP) > floor_angle):
			grounded = true
		elif (c.dot(Vector3.DOWN) > floor_angle):
			ceilinged = true
			
			
	if grounded && ceilinged:
		physics_material_override.friction = friction/10
	else:
		physics_material_override.friction = friction
		#position = last_pos
		#rotation = last_rot
		#print ("Unsquish")

func check_stuck(state, inputs :Vector2):
	if (position - last_pos).length()/collector.size > 0.002:
		stuck_timer = 0
		stuck_timer2 = 0
		initial_stuck_direction = null
	elif (inputs.length() != 0):
		if (initial_stuck_direction == null):
			initial_stuck_direction = inputs
		
		if (abs(inputs.angle_to(initial_stuck_direction)) < PI/3):
			stuck_timer += stored_delta
		else:
			stuck_timer2 += stored_delta

	if (position.y < (min_height - scale.x * 3)) || (stuck_timer > stuck_limit && stuck_timer2 > stuck_limit):
		emergency_warp(state)

func update_size():
	var size = collector.size/collector.control.map_scale
	var big = Vector3(size, size, size)
	gravity_scale = size
	mass = base_mass * pow(size, collector.exponent)
	scale = big
	nonrolling.scale = global_basis.get_scale()
	
	if (camera_scale == 0):
		camera_scale = size
	else:
		var max_change = camera_scale * (pow(camera_change_limit, stored_delta) - 1)
		if (camera_scale < size):
			camera_scale = min(size, camera_scale + max_change)
		else:
			camera_scale = max(size, camera_scale - max_change)
	nonrolling.get_node("CameraBase").scale = Vector3.ONE * camera_scale/size
	
	if (collector.mode != 0):
		var inner_volume = collector.volume - collector.outer_volume
		var inner_size = pow(inner_volume, 1/collector.exponent)
		var size_ratio = inner_size/collector.size
		var inner_big = Vector3(size_ratio, size_ratio, size_ratio)
		get_node("Model").scale = inner_big


func inputs_advanced():
	var h1 = Input.get_axis("Right1", "Left1")
	var h2 = Input.get_axis("Right2", "Left2")
	var v1 = Input.get_axis("Up1", "Down1")
	var v2 = Input.get_axis("Up2", "Down2")
	var leftSide = Vector2(h1, v1).limit_length(1);
	var rightSide = Vector2(h2, v2).limit_length(1)

	if (leftSide.length() == 0 || rightSide.length() == 0): #Only move if both are active
		horizontal = 0
		vertical = 0
		turn = 0
		return    
	
	if leftSide.x * rightSide.x < 0:
		horizontal = 0
	else:
		horizontal = (leftSide.x + rightSide.x) / 2
	
	turn = leftSide.y - rightSide.y;
	vertical = (leftSide.y + rightSide.y)/2;
	
func emergency_warp(state: PhysicsDirectBodyState3D):
	global_position = spawnpoint.global_position
	position.y+=scale.y
	state.linear_velocity = Vector3.ZERO
	state.angular_velocity = Vector3.ZERO
	last_vel = Vector3.ZERO
	stuck_timer = 0
	print("Warp!")
	
func slow_down(delta: float, state: PhysicsDirectBodyState3D, change, inputs):
	# Get an "intended" speed based on the change in velocity
	var diff = change
	var curr_max = max_speed * speed_mult * max(inputs.length(), back_mult)
	if !grounded:
		curr_max = curr_max / 2
	var intended = diff.normalized() * curr_max 
	intended = intended.limit_length(state.angular_velocity.length())
	
	var next
	var adjustAmount = delta * slow_force
	if (state.angular_velocity.distance_to(intended) < (too_slow / 3.0)):
		adjustAmount *= 3
	if (state.angular_velocity.distance_to(intended) < adjustAmount):
		next = intended
	else:
		next = state.angular_velocity + (state.angular_velocity.direction_to(intended) * adjustAmount)
	
	next = next.limit_length(state.angular_velocity.length())
	next = next.limit_length(max(curr_max, last_vel.length() - delta * rolling_force * speed_mult * (1+inputs.length())/2))

	if (inputs.length() == 0 && grounded && state.angular_velocity.length() < delta * rolling_force * speed_mult * 0.3):
		next = Vector3.ZERO
		set_collision_mask_value(6, true)

	state.angular_velocity = next
	last_vel = next
