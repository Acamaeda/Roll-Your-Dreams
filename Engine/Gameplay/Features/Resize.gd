@tool
extends Node


@export_range(0, 3333, 1e-14, "or_greater", "or_less", "hide_control")  var scale: float = 1.0:
	set(val):
		scale = val
		update_scale()
@export_enum("Multiply", "Set") var mode = 0:
	set(val):
		mode = val
		update_scale()

var target : Rollable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var parent = get_parent()
	for child in parent.get_children():
		if (child is Rollable):
			target = child
	if (!target):
		return
	update_scale()
	
func update_scale():
	if (!target): return
	var scale_factor = scale
	if (mode == 1):
		scale_factor = scale_factor/target.base_size 
	target.size_mult = scale_factor
	target.update_scale()
	

	
