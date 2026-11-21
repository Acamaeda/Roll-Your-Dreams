extends Node3D

@onready var animation_tree = $AnimationTree
var animation = Vector2(0.0, 0.0)

func _process(_delta: float) -> void:
	animation_tree.set("parameters/BlendSpace2D/blend_position", animation.normalized())
