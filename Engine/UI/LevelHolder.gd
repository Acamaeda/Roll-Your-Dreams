extends Node

@export var level_location = ""

func start_level():
	for child in get_children():
		child.queue_free()
	await get_tree().create_timer(0.1).timeout 

	var level = load("res://Levels/Test Campaign/Demo level/DemoLevel.tscn").instantiate()
	add_child(level)
	GameControl.get_node("FreezeControl").set_pause(false)
