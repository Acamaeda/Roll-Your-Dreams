
extends Node3D

@export var power = 9.8

func _ready() -> void:
	if (!(get_parent() is PhysicsBody3D)):
		push_warning("Fall feature is on " + get_parent().name + " which is not a physics object.")
		return
	Utils.upgrade_physics.call_deferred(get_parent(), 2)
	ready2.call_deferred.call_deferred()
	
func ready2():
	var parent :CharacterBody3D = get_parent()
	parent.wall_min_slide_angle = 0
	
func _process(delta):
	var parent : CharacterBody3D = get_parent()
	var player = get_tree().get_first_node_in_group("Player")
	var change : Vector3 = global_basis.y * player.scale.x * delta * power *-1
	parent.velocity+= change
