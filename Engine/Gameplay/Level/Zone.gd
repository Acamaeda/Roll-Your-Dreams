extends Node3D

@export var size_required : float  = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var collector = get_tree().get_first_node_in_group("Player").get_node("Collector")
	collector.size_changed.connect(_check_to_open)
	if size_required != 0:
		get_node("Objects").set_process(false)

func _check_to_open(size, _blah):
	if (size >= size_required):
		get_node("Objects").set_process(true)
		get_node("Barrier").set_process(false)
