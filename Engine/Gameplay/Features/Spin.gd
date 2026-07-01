@tool
extends Node3D

@export var speed: float = 1.0


func _ready() -> void:
	var parent = get_parent()
	var roll : Rollable = parent.get_node("Rollable")
	if(roll):
		var vscale = roll.size
		if Engine.is_editor_hint():
			get_node("Visualizer").scale = Vector3(vscale, vscale, vscale)
		
	
func _process(delta: float) -> void:
	if !Engine.is_editor_hint():
		get_parent().rotate(transform.basis.y, 2*PI*delta*speed)
