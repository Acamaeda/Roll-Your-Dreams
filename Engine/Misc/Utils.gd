@tool
extends Node


func delete_node(node : Node):
	rescue_active_events(node)
	node.queue_free()

func rescue_active_events(node: Node):
	for child in node.get_children():
		if (child is Trigger):
			if (child.active):
				child.reparent(get_tree().root)
		else:
			rescue_active_events(child)
		
func upgrade_physics(node: Node, level):
	for child in node.get_children():
		upgrade_physics(child, level)
	if (node is PhysicsBody3D && get_physics_level(node) < level):
		var new_node = create_physics_node(level)
		replace_physics_node(node, new_node)

func replace_physics_node(old: PhysicsBody3D, new: PhysicsBody3D):
	new.collision_mask = old.collision_mask
	new.collision_layer = old.collision_layer
	new.transform = old.transform
	var rollable: Rollable = old.get_node("Rollable")
	if (rollable):
		rollable.body = new
	
	var new_name = old.name
	old.name = new_name+"old"
	new.name=new_name
	old.replace_by.call_deferred(new, true)
	old.queue_free.call_deferred()
	
func create_physics_node(level):
	match level:
		0: 
			return StaticBody3D.new()
		1: 
			var body = AnimatableBody3D.new()
			body.sync_to_physics = false
			return body
		2: 
			return CharacterBody3D.new()
		3: 
			return RigidBody3D.new()
	push_error("Unknown physics level!")

func get_physics_level(node: Node):
	if (node is StaticBody3D):
		return 0
	if (node is AnimatableBody3D):
		return 1
	if (node is CharacterBody3D):
		return 2
	if (node is RigidBody3D):
		return 3
	else: return 0
