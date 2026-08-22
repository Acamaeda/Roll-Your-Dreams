extends "res://Engine/Events/Actions/ChangeValue.gd"

#Currently just sets the size instead of changing it more elaborately.


func get_current_value():
	var collector = get_tree().get_first_node_in_group("Player").get_node("Collector")
	return collector.size

func apply_change(val):
	var collector = get_tree().get_first_node_in_group("Player").get_node("Collector")
	collector.set_size(val)
