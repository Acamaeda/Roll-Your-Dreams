extends RigidBody3D

var player
var nonrolling
var rolling_force = 30
var horizontal_mult = 0.5
var turn_speed = 0.8
var slow_force = 10
var warp_height = -10
var max_speed = 20
var too_slow = 5

var horizontal = 0.0
var vertical = 0.0
var turn = 0.0
var last_vel = Vector3.ZERO
var stored_delta = 0.0167
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent();
	nonrolling = get_node("../Nonrolling")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	stored_delta = delta
	
func _integrate_forces(state: PhysicsDirectBodyState3D):
	inputs_advanced();
	var inputs = Vector2(vertical, horizontal * horizontal_mult)
	inputs = inputs.rotated(-1 * nonrolling.rotation.y)
	var total_force = rolling_force
	#Speed up if player is just starting to move
	if(state.angular_velocity.length() < too_slow):
		total_force *= 2
	state.angular_velocity.x += total_force*inputs.x*stored_delta
	state.angular_velocity.z += total_force*inputs.y*stored_delta
	nonrolling.rotation.y += turn*turn_speed*stored_delta;
	
	if position.y < (warp_height * player.size):
		emergency_warp(state)
	nonrolling.position = position
	slow_down(stored_delta, state)
	
	

func inputs_advanced():
	var h1 = Input.get_axis("Right1", "Left1")
	var h2 = Input.get_axis("Right2", "Left2")
	var v1 = Input.get_axis("Up1", "Down1")
	var v2 = Input.get_axis("Up2", "Down2")
	var leftSide = Vector2(h1, v1).limit_length(1);
	var rightSide = Vector2(h2, v2).limit_length(1)

	if leftSide.x * rightSide.x < 0:
		horizontal = 0
	else:
		horizontal = (leftSide.x + rightSide.x) / 2
	
	turn = leftSide.y - rightSide.y;
	vertical = (leftSide.y + rightSide.y)/2;
	
func emergency_warp(state: PhysicsDirectBodyState3D):
	position = Vector3.ZERO
	state.linear_velocity = Vector3.ZERO
	state.angular_velocity = Vector3.ZERO
	last_vel = Vector3.ZERO
	print("Warp!")
	
func slow_down(delta: float, state: PhysicsDirectBodyState3D):
	# Get an "intended" speed based on the change in velocity
	var diff = state.angular_velocity - last_vel
	var intended = diff.normalized() * max_speed
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
	next = next.limit_length(max(max_speed, last_vel.length() - delta * rolling_force))
	state.angular_velocity = next
	
	
	
	last_vel = next
