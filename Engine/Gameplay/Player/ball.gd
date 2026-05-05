extends RigidBody3D
var nonrolling : Node3D
var collector : Node3D
var ghost_floor : Node3D
var ghost_hat : Node3D

var rolling_force = 60
var horizontal_mult = 0.5
var back_mult = 0.3
var turn_speed = 0.8
var slow_force = 40
var warp_height = -10
var max_speed = 20
var too_slow = 5
var floor_angle = 0.5

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
var stuck_limit = 1.5
var min_height = 0
var emergency_pos


func _ready() -> void:
	nonrolling = get_node("Nonrolling")
	collector = get_node("Collector")
	ghost_hat = get_node("Ghost Hat")

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
	var total_force = rolling_force
	#Speed up if player is just starting to move
	if(state.angular_velocity.length() < too_slow):
		total_force *= 2
	var change = Vector3(total_force*inputs.x*stored_delta, 0,  total_force*inputs.y*stored_delta)
	state.angular_velocity.x += change.x
	state.angular_velocity.z += change.z
	camera_angle += turn*turn_speed*stored_delta;
	slow_down(stored_delta, state, change, inputs)

	if (position - last_pos).length()/collector.size > 0.01:
		stuck_timer = 0
	elif (inputs.length() != 0):
		print(stuck_timer)
		stuck_timer += stored_delta

	if (position.y < (min_height - collector.size * 5)) || stuck_timer > stuck_limit:
		emergency_warp(state)
	
	nonrolling.rotation.y = camera_angle
	nonrolling.position = position
	
	ghost_hat.position = to_local(position+Vector3(0, 0.25, 0))
	ghost_hat.set_global_rotation(Vector3.ZERO)

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
		pass
		#position = last_pos
		#rotation = last_rot
		#print ("Unsquish")

func update_size():
	var size = collector.size
	var big = Vector3(size, size, size)
	gravity_scale = size
	scale = big
	nonrolling.scale = big

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
	state.linear_velocity = Vector3.ZERO
	state.angular_velocity = Vector3.ZERO
	last_vel = Vector3.ZERO
	stuck_timer = 0
	print("Warp!")
	
func slow_down(delta: float, state: PhysicsDirectBodyState3D, change, inputs):
	# Get an "intended" speed based on the change in velocity
	var diff = change
	var curr_max = max_speed * max(inputs.length(), back_mult)
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
	next = next.limit_length(max(curr_max, last_vel.length() - delta * rolling_force * (1+inputs.length())/2))

	if (inputs.length() == 0 && grounded && state.angular_velocity.length() < delta * rolling_force * 0.3):
		next = Vector3.ZERO
		set_collision_mask_value(6, true)

	state.angular_velocity = next
	last_vel = next
