extends Action

func act():
	get_tree().get_first_node_in_group("Level Control").end_level()
