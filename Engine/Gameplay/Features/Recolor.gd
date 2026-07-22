@tool
extends Node

@export_range(-180, 180, 1, "or_less", "or_greater") var shift_amount: float = 0:
	set(val):
		shift_amount = val
		update_color()

var target : MeshInstance3D
var shader : Shader
var shadermat : ShaderMaterial
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	find_target(get_parent())
	if (!target):
		return
	shader = load("res://Engine/Gameplay/Features/Recolor.gdshader")
	shadermat = ShaderMaterial.new()
	shadermat.shader = shader
	for id in target.get_surface_override_material_count():
		var newmat : StandardMaterial3D
		if (target.get_active_material(id)):
			newmat = target.get_active_material(id).duplicate()
		else:
			newmat = StandardMaterial3D.new()
		newmat.next_pass = shadermat
		shadermat.render_priority=shadermat.RENDER_PRIORITY_MIN
		
		target.set_surface_override_material(id, newmat)
		

	update_color()

func update_color():
	if(!shadermat):
		return
	shadermat.set_shader_parameter("shift_amount", shift_amount)
	#target.set_instance_shader_parameter()

	
func find_target(parent):
	for child in parent.get_children():
		if (child is MeshInstance3D):
			target = child
		else:
			find_target(child)

	
