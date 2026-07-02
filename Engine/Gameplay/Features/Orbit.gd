@tool
extends Node3D

@export var radius: float = 1.0
@export var speed: float = 1.0
@export_range(0, 360) var arc_used:float = 360.0

@export_enum("Towards ground", "Towards center", "No rotation") var rotation_style = 0

func _ready() -> void:

		
	var count = get_child_count()
	var v = get_node("Visualizer")
	if(v):
		count-=1
	var x = 0
	for child in get_children():
		if (child.name!="Visualizer"):
			if (child is Node3D):
				var angle = arc_used/180*PI/count*x
				var rot = rotation.rotated(transform.basis.y, angle)
				var dist = radius
				if (dist == 0): 
					dist = child.position.abs()
				child.position = Vector3(dist, 0, 0).rotated(transform.basis.y, angle)
			x+=1
	
func _process(delta: float) -> void:
	if !Engine.is_editor_hint():
		for child in get_children():
			if (child is Node3D):
				child.position=child.position.rotated(transform.basis.y, 2*PI*delta*speed)
