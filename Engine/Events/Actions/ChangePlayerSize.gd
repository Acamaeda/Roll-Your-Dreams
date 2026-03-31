extends "res://Engine/Events/Actions/Action.gd"

@export var amount:float = 1
#Currently just sets the size instead of changing it more elaborately.

func action():
	var collector = 	get_tree().get_first_node_in_group("Player").get_node("Collector")
	collector.set_size(amount)
