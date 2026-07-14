@tool
extends Node3D

@export var speed: float = 1.0
var last_rotation = Vector3.ZERO
var total = 0
func _ready() -> void:
	Utils.upgrade_physics.call_deferred(get_parent(), 1)
	var roll : Rollable = get_parent().get_node("Rollable")
	if(roll):
		print(roll)
		var vscale = roll.size
		if Engine.is_editor_hint():
			get_node("Visualizer").scale = Vector3(vscale, vscale, vscale)
		
	
func _process(delta: float) -> void:
	if (!Engine.is_editor_hint()):
		get_parent().rotate(transform.basis.y, 2*PI*delta*speed)
