@tool
extends Node
class_name Rollable
var size = 1.0
var size_mult :float  = 1.0
var scale = 1.0
var body : PhysicsBody3D
var player : Node
signal onRollup

@export var object_name: String = "Thing"
@export var description: String = "Some kind of funny detail."
@export var creator: String = "Somebody"
@export var link: String = ""
@export_range(0, 5555, 1e-14, "or_greater", "or_less", "hide_control") var base_size: float = 1.0
@export_range(0, 4444, 1e-14, "or_greater", "or_less", "hide_control") var model_scale: float = 1.0

var collision: int
@export var solid: bool = true
var rollable: bool = true
var include_in_collection: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	if (!player): #this means we aren't in a level scene and shouldn't rescale
		return
	body = get_parent()
	update_scale()
	if (Engine.is_editor_hint()):
		return

	var collector = player.get_node("Collector")
	collector.size_changed.connect(_on_player_size_change)
	body.set_collision_mask_value(1, solid)
	body.set_collision_mask_value(3, solid)
	body.set_collision_mask_value(4, solid)
	_on_player_size_change(collector.size, collector.size * collector.rollup_ratio)
	
	choose_collision.call_deferred()	

func cleanup_collision():
	var node = get_node_or_null("../DetailedCollision")
	if (node): node.queue_free()
	node = get_node_or_null("../SimpleCollision")
	if (node): node.queue_free()

func choose_collision():
	var newcoll
	var wname = ""
	match collision:
		0:
			cleanup_collision()
			return
		1:
			newcoll = get_node_or_null("../DetailedCollision")
			wname = "detailed"
		2:
			newcoll = get_node_or_null("../SimpleCollision")
			wname = "simple"

	if (!newcoll || newcoll.get_child_count() == 0):
		push_warning(name + " has no " + wname + " collision set up! You'll have to implement it yourself.")
	for child in body.get_children():
		if (child is CollisionShape3D):
			child.queue_free()
	for child in newcoll.get_children():
		child.reparent(body, true)
	cleanup_collision()

	
func update_scale():

	size = base_size * size_mult
	scale = model_scale
	scale *= size_mult
	var control = get_tree().get_first_node_in_group("Level Control")
	if (!control): #this means we aren't in a level scene and shouldn't rescale
		return
	var level_scale = 1/control.level_scale
	scale *= level_scale/body.scale.x
	body.global_scale(Vector3(scale, scale, scale))
	size = size_mult * base_size
	
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
