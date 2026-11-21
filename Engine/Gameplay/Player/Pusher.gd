extends Node3D

@onready var animation_tree = $AnimationTree
var x = 0.0
var y = 0.0

func _process(delta: float) -> void:
	animation_tree.set("parameters/BlendSpace2D/blend_position", Vector2(x, y).normalized())
