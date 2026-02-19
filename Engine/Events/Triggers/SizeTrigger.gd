extends "res://Engine/Events/Triggers/ValueTrigger.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	var player = get_tree().get_first_node_in_group("Player")
	player.get_node("Collector").size_changed.connect(value_changed2)

	pass # Replace with function body.
