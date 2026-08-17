extends Action


func action():
	get_tree().get_first_node_in_group("LevelHolder").start_level()
