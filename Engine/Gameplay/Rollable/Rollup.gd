extends Node
var size = 1.0
var body : PhysicsBody3D
var player : Node
@export var object_name: String = "Thing"
@export var description: String = "Some kind of funny detail."
@export var creator: String = "Somebody"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	body = get_parent()
	size = body.scale.x
	player = get_tree().get_first_node_in_group("Player")
	update_scale()
	player.get_node("Collector").size_changed.connect(_on_player_size_change)

func update_scale():
	body.scale = Vector3(size, size, size)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_size_change(player_size, rollup_size):
	if (rollup_size > size):
		body.set_collision_layer_value(3, false)
		body.set_collision_layer_value(4, true)
		body.set_collision_mask_value(2, false)
		body.set_collision_layer_value(5, true)
	else:
		body.set_collision_layer_value(3, true)
		body.set_collision_layer_value(4, false)
		body.set_collision_mask_value(2, true)
		body.set_collision_layer_value(5, false)

func rolled_up():
	pass
