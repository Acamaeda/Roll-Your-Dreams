@tool
extends Node
class_name LevelControl
@export_range(0, 2222, 1e-14, "or_greater", "or_less", "hide_control") var level_scale: float = 1.0:
	set(val):
		var parent = get_parent()
		if parent is Node3D:
			var newscale = map_scale/val
			print(newscale)
			parent.scale = Vector3(newscale, newscale, newscale)
		level_scale = val
		size_ratio = map_scale/level_scale
		magic_scale = level_scale/map_scale/map_scale
@export_range(0, 2222, 1e-14, "or_greater", "or_less", "hide_control") var map_scale: float = 1.0

var size_ratio
var magic_scale
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	size_ratio = map_scale/level_scale
	magic_scale = level_scale/map_scale/map_scale
