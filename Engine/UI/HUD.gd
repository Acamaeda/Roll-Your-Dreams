extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var newscale = get_viewport().size.x/1280
	scale = Vector2(newscale, newscale)
