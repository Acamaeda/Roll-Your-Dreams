extends RigidBody3D

var nonrolling : Node3D
var collector : Node3D
var base_mass = 1.5
var rolling_force = 60
@export var speed_mult = 1.0
@export var horizontal_mult = 0.5
@export var back_mult = 0.3
@export var turn_speed = 1.0
var slow_force = 40
var max_speed = 20
var too_slow = 5
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
var camera_angle = 0
var grounded = false

var stuck_timer = 0
var stuck_timer2 = 0

var stuck_limit = 0.75
var initial_stuck_direction = null
var min_height = 0
var emergency_pos


func _ready() -> void:
	nonrolling = get_node("Nonrolling")
	collector = get_node("Collector")

	nonrolling.top_level = true
	if !emergency_pos:
		emergency_pos = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	stored_delta = delta

func _integrate_forces(state: PhysicsDirectBodyState3D):
	set_collision_mask_value(6, false)
	update_size();
	check_collisions(state)
	
	inputs_advanced();
	var inputs = Vector2(vertical, horizontal * horizontal_mult)
	if vertical > 0:
		inputs.x = inputs.x * back_mult
	inputs = inputs.rotated(-1 * nonrolling.rotation.y)
	
	if (quickturn_left > 0):
		var turn_amount = min(quickturn_left, stored_delta/quickturn_speed*PI)
		quickturn_left -= turn_amount
		camera_angle += turn_amount
		angular_velocity = Vector3.ZERO
	elif (Input.is_action_just_pressed("QuickTurn") && angular_velocity.length() < too_slow*1.5):
		quickturn_left = PI
		angular_velocity = Vector3.ZERO
	else:
		var total_force = rolling_force*speed_mult
		#Speed up if player is just starting to move
		if(state.angular_velocity.length() < too_slow):
			total_force *= 2
		var change = Vector3(total_force*inputs.x*stored_delta, 0,  total_force*inputs.y*stored_delta)
		state.angular_velocity.x += change.x
		state.angular_velocity.z += change.z
		camera_angle += turn*turn_speed*stored_delta;
		slow_down(stored_delta, state, change, inputs)

	check_stuck(state, inputs)
	
	nonrolling.rotation.y = camera_angle
	nonrolling.position = position/collector.control.level_scale*collector.control.map_scale
	

	last_pos = position
	last_rot = rotation

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
	nonrolling.scale = big/collector.control.level_scale*collector.control.map_scale


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
	position = emergency_pos
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
