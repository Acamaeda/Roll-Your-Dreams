extends Action


func action():
	GameControl.level_path = get_tree().current_scene.scene_file_path
	UI.get_node("Loading").start_load()
