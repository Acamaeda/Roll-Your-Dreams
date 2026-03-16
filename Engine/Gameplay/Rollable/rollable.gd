extends Node
var size = 1.0
var scale = 1.0
var body : PhysicsBody3D
var player : Node
signal onRollup

@export var object_name: String = "Thing"
@export var description: String = "Some kind of funny detail."
@export var creator: String = "Somebody"

@export var base_size: float = 1.0

@export var use_detailed_collision: bool = false
@export var solid: bool = true
@export var rollable: bool = true
@export var include_in_collection: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	body = get_parent()
	scale = body.scale.x
	player = get_tree().get_first_node_in_group("Player")
	update_scale()
	var collector = player.get_node("Collector")
	collector.size_changed.connect(_on_player_size_change)
	body.set_collision_mask_value(1, solid)
	body.set_collision_mask_value(3, solid)
	body.set_collision_mask_value(4, solid)
	_on_player_size_change(collector.size, collector.size * collector.rollup_ratio)
	
	choose_collision.call_deferred()	


func choose_collision():
	var detailed_collision = get_node("../DetailedCollision")
	if !detailed_collision:
		return
	if use_detailed_collision:
		for child in body.get_children():
			if (child is CollisionShape3D):
				child.queue_free()
		for child in detailed_collision.get_children():
			child.reparent(body, true)
	
	detailed_collision.queue_free()
func update_scale():
	body.scale = Vector3(scale, scale, scale)
	size = scale * base_size
	
func _set_solid(val):
	if (solid == val):
		return
	solid = val
	body.set_collision_mask_value(1, solid)
	body.set_collision_mask_value(3, solid)
	body.set_collision_mask_value(4, solid)

	if !body.get_collision_layer_value(4):
		body.set_collision_layer_value(3, solid)
		body.set_collision_mask_value(2, solid)		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_player_size_change(_player_size, rollup_size):
	if (rollup_size > size) && rollable:
		body.set_collision_layer_value(3, false)
		body.set_collision_layer_value(4, true)
		body.set_collision_mask_value(2, false)
		body.set_collision_mask_value(5, true)
	else:
		body.set_collision_layer_value(3, solid)
		body.set_collision_layer_value(4, false)
		body.set_collision_mask_value(2, solid)
		body.set_collision_mask_value(5, false)

func rolled_up():
	onRollup.emit()
