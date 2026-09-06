@tool
extends DisplayCounter
class_name ScoreCounter

@export var display = true
@export var use_label = false

@export var object_values : Dictionary[String, float]

func _ready():
	if(!Engine.is_editor_hint() && display):
		get_tree().get_first_node_in_group("Level Control").get_node("Hud").add_score_display(self)

func add_from_object(object:String):
	var add = object_values.get(object, 0)
	if (add):
		value += add
