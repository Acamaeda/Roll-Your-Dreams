extends Control

var progress:Array[float] = []
var loading = false
@onready var bar = $"HBoxContainer/box2/ProgressBar"

func start_load():
	if (OS.has_feature("web")): 
		bar.visible = false
	visible = true
	await get_tree().create_timer(0.1).timeout
	ResourceLoader.load_threaded_request(GameControl.level_path)
	bar.value=0.0
	loading = true

func _process(_delta):
	if (!loading): return
	var status = ResourceLoader.load_threaded_get_status(GameControl.level_path, progress)
	
	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			bar.value = progress[0] * 100.0
		ResourceLoader.THREAD_LOAD_LOADED:
			loading = false
			visible = false
			get_tree().change_scene_to_file(GameControl.level_path)
			GameControl.get_node("FreezeControl").set_pause(false)
