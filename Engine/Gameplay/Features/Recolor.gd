@tool
extends Node

@export_range(-180, 180, 1, "or_less", "or_greater") var shift_amount: float = 0


var target : MeshInstance3D
var shader : Shader

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var parent = get_parent()
	for child in parent.get_children():
		if (child is MeshInstance3D):
			target = child
		else:
			for grandchild in child.get_children():
				if (grandchild is MeshInstance3D):
					target = grandchild
	if (!target):
		return
	var newmat = target.get_active_material(0).duplicate()
	target.set_surface_override_material(0, newmat)
	shader = load("res://Engine/Gameplay/Features/Recolor.gdshader")
	newmat.shader = shader

	update_color()

func update_color():
	shader.set("shift_amount", shift_amount)
		
