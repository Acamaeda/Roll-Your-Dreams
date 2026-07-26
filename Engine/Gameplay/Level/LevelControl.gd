@tool
extends Node

@export_range(0, 2222, 1e-14, "or_greater", "or_less", "hide_control") var level_scale: float = 1.0
@export_range(0, 2222, 1e-14, "or_greater", "or_less", "hide_control") var map_scale: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
