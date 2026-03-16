extends Node


func delete_node(node : Node):
	for child in node.get_children():
		if (child is Trigger):
			if (child.active):
				child.reparent(get_tree().root)
	node.queue_free()
