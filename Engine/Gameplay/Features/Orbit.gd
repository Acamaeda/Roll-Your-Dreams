@tool
extends Node3D

@export_range(0, 6767, 1e-14, "or_greater", "or_less", "hide_control")  var radius: float = 1.0:
	set(val):
		radius = val
		if(!get_parent()):
			return
		var controller = get_tree().get_first_node_in_group("Level Control")
		internal_radius = global_basis.get_scale().x*radius*controller.magic_scale
		if Engine.is_editor_hint():
			updateVisualizer()
@export var speed: float = 1.0
@export_range(0, 360) var arc_used:float = 360.0

@export_enum("Towards ground", "Towards center", "Towards orbital plane", "No rotation") var rotation_style = 0

var internal_radius = 0.0

func _ready() -> void:
	var controller = get_tree().get_first_node_in_group("Level Control")
	internal_radius = global_basis.get_scale().x*radius*controller.magic_scale
	if Engine.is_editor_hint():
		updateVisualizer()
	var count = get_child_count()
	var v : Node3D = get_node("Visualizer")
	if(v):
		count-=1
	var x = 0
	for child in get_children():
		if (child.name!="Visualizer"):
			if (child is Node3D):
				var angle = arc_used/180*PI/count*x
				var dist = internal_radius
				if (dist == 0): 
					dist = child.position.abs()
				child.position = Vector3(dist, 0, 0).rotated(Vector3.UP, angle)
				update_rotation(child)
			x+=1
	Utils.upgrade_physics.call_deferred(self, 1)

			
func updateVisualizer():
	var v : Node3D = get_node("Visualizer")
	v.scale = Vector3(internal_radius, internal_radius, internal_radius)

func _process(delta: float) -> void:
	if !Engine.is_editor_hint():
		for child in get_children():
			if (child is Node3D):
				child.position=child.position.rotated(Vector3.UP, 2*PI*delta*speed)
				update_rotation(child)
			
func update_rotation(object : Node3D):
	var forward = global_transform.basis.y.cross(object.position)
	if (speed > 0): # It's backwards by default
		forward = forward*-1
	match rotation_style:
		0: # Toward Ground
			forward.y=0
			object.look_at(object.global_position+forward, to_local(global_position+Vector3.UP))
		1: # Toward Center
			object.look_at(object.global_position+forward, (object.global_position-global_position).normalized())
		2: # Toward Orbital Plane
			object.look_at(object.global_position+forward)

			
	
