extends Display

var timer : RYDTimer

func _ready() -> void:
	var control = get_tree().get_first_node_in_group("Level Control")
	if (!control): #this means we aren't in a level scene and shouldn't rescale
		return
	timer = control.get_node("Counters/time")
	timer.value_changed.connect(_time_changed)
	text.add_theme_font_size_override("normal_font_size", 64)
	_time_changed(timer.value)
	
func _time_changed(time):
	text.text= format_time(time)

func format_time(time):
	var mins = int(floor(time/60))
	time = int(floor(time))
	var secs = int(floor(time%60))
	var secs_txt = str(secs)
	if (secs < 10):
		secs_txt = "0" + secs_txt
	return str(mins) + ":" + str(secs_txt)
