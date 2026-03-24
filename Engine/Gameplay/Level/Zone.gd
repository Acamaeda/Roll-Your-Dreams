extends Node3D

@export var unlock_with_size : bool = true
@export var size_required : float  = 0
@export var lowest_height : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (unlock_with_size):
		var collector = get_tree().get_first_node_in_group("Player").get_node("Collector")
		collector.size_changed.connect(_check_to_open)
	if size_required != 0:
		get_node("Objects").set_process(false)
	else:
		open()


func _check_to_open(size, _blah):
	if (size >= size_required):
		open()
		
func open():
	get_node("Objects").set_process(true)
	get_node("Barrier").set_process(false)
	var player = get_tree().get_first_node_in_group("Player")
	player.min_height = lowest_height
	player.emergency_pos = get_node("Spawnpoint").position
