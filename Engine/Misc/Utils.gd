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
		
