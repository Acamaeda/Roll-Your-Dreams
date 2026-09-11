extends "res://Engine/UI/Display.gd"
class_name ScoreDisplay

var counter : ScoreCounter
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text.add_theme_font_size_override("normal_font_size", 40)
	finish_setup.call_deferred()	

func finish_setup():
	counter.value_changed.connect(_on_value_change)
	_on_value_change(counter.value)

func _on_value_change(_value):
	var newtext = counter.format()
	if (counter.use_label):
		newtext = counter.display_name + ": " + newtext
	text.text = newtext
