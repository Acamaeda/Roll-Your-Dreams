extends Node

@export var level_location = "res://Levels/Test Campaign/Demo level/DemoLevel.tscn"

func start_level():
	for child in get_children():
		remove_child(child)
		child.queue_free()
	await get_tree().create_timer(0.1).timeout 

	var level = load(level_location).instantiate()
	add_child(level)
	GameControl.get_node("FreezeControl").set_pause(false)
