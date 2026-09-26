extends ToggleAction

@export var object: Node3D

func get_value(): return object.process_mode != object.ProcessMode.PROCESS_MODE_DISABLED

func set_value(_val):
	if (_val):
		object.process_mode = object.PROCESS_MODE_INHERIT
	else:
		object.process_mode = object.PROCESS_MODE_DISABLED
	object.visible = _val
