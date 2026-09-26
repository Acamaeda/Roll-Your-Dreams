extends Action
@export var object : Node3D
@export var destination: Vector3
@export var move_time = 1.0

func _ready():
	var controller = get_tree().get_first_node_in_group("Level Control")
	Utils.upgrade_physics.call_deferred(object, 1)

func action():
	return
