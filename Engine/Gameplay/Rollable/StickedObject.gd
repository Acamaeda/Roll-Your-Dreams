extends Node3D
var player : Node
var speed = 5.0
var size = 1.0;

var attached = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if attached: return
	position+= player.linear_velocity * delta
	var goal = player.position + (position - player.position).normalized() * player.scale.x*0.55
	
	var step_size = speed * delta *player.scale.x
	position = position.move_toward(goal, step_size)
	if ((position - goal).length() < player.scale.x /100):
		attached = true
		reparent(player.get_node("Nonscaling"), true)
