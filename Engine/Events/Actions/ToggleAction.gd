extends Action
class_name ToggleAction
@export_enum("True", "False", "Toggle") var mode = 0

# Called when the node enters the scene tree for the first time.
func action():
	match mode:
		0: set_value(true)
		1: set_value(false)
		2: set_value(!get_value())

	
func get_value():
	return true

func set_value(_val):
	pass
