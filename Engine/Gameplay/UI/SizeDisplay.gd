extends Node

var positive_prefixes = ["", "k", "M", "G", "T", "P", "E","Z","Y","X","W"]
var negative_prefixes = ["", "m", "μ", "n", "p", "a", "f","z","y","x","w"]
var lightyear = 9.605e15
var au = 1.496e11
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.

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
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
