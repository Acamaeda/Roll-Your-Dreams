extends Node3D
class_name MovePoint

@export var move_with_object = true
var moving = false
var speed = 0.0
var distance = 1.0
var direction

func _ready():
	Utils.upgrade_physics.call_deferred(get_parent(), 1)
	direction = position.normalized()
	top_level = !move_with_object
	var roll : Rollable = get_parent().get_node_or_null("Rollable")
	if(roll):
		var vscale = roll.size/roll.model_scale/2
		if Engine.is_editor_hint():
			get_node("Visualizer").scale = Vector3(vscale, vscale, vscale)
		

		
func start(time):
	top_level = false
	distance = position.length() / get_parent().scale.x
	speed = distance / time
	moving = true

func _process(delta):
	if(moving):
		var parent :Node3D = get_parent()
		var step_size = min(speed * delta, distance)
		parent.position = parent.position + direction * step_size
		distance -= step_size
		if (distance < 0.001):
			moving = false
			top_level = !move_with_object
	
	
