extends Node

var positive_prefixes = ["", "k", "M", "G", "T", "P", "E","Z","Y","X","W"]
var negative_prefixes = ["", "m", "μ", "n", "p", "a", "f","z","y","x","w"]
var lightyear = 9.605e15
var au = 1.496e11
# Called when the node enters the scene tree for the first time.
@onready var text : RichTextLabel = get_node("b1/b2/text")
func _ready() -> void:
	var player = get_tree().get_first_node_in_group("Player")
	if (!player): #this means we aren't in a level scene and shouldn't rescale
		return
	var collector = player.get_node("Collector")
	collector.size_changed.connect(_on_player_size_change)
	text.add_theme_font_size_override("normal_font_size", 64)
	_on_player_size_change(collector.size, null)
	
func _on_player_size_change(size, _ignore):
	text.text=formatSize(size)
	
func test():
	print(formatSize(2.231))
	print(formatSize(0.231))
	print(formatSize(0.001213))
	print(formatSize(0.00000000001213))

	print(formatSize(44444))
	print(formatSize(au * 144.44))
	print(formatSize(au * 9000))
	print(formatSize(lightyear * 92.3))
	print(formatSize(lightyear * 953454354352.3))

func formatSize(size:float):
	if (size > lightyear):
		return metricify(size/lightyear) + "ly"
	if (size > au):
		return metricify(size/au) + "AU"
	if (0.01 <= size && size < 1 ):
		return "%.3f cm" %(size * 100)
	return metricify(size) + "m"

func metricify(val: float):
	var level = floor(log(val)/log(1000))
	var amount = val / pow(1000, level)
	var prefix = ""
	if (level < 0):
		prefix = negative_prefixes[level*-1]
	else:
		prefix = positive_prefixes[level]
	return(("%.3f" % amount) + " " + prefix)
