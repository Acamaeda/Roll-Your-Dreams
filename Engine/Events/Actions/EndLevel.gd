extends Action

@export_enum("Normal", "Fail", "Perfect Clear") var ending_type = 0


func act():
	get_tree().get_first_node_in_group("Level Control").end_level(ending_type)
