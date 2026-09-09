extends Node

var positive_prefixes = ["", "k", "M", "G", "T", "P", "E","Z","Y","R","Q"]
var full_positive_prefixes = ["", "kilo", "mega", "giga", "tera", "peta", "exa","zetta","yotta","Ronna","Quetta"]
var negative_prefixes = ["", "m", "μ", "n", "p", "f", "a","z","y","r","q"]
var full_negative_prefixes = ["", "mili", "micro", "nano", "pico", "femto", "atto","zepto","yocto","ronto","quecto"]

var lightyear = 9.605e15
var au = 1.496e11
# Called when the node enters the scene tree for the first time.

func formatSize(size:float):
	if (size == 0):
		return "zero"
	elif (size < 0):
		return "-" + formatSize(size*-1)
	if (size > lightyear):
		return metricify(size/lightyear, false) + "ly"
	if (size > au):
		return metricify(size/au, false) + "AU"
	if (0.01 <= size && size < 1 ):
		return "%.3f cm" %(size * 100)
	var text = metricify(size, false) + "m"
	return text


func metric(val: float, use_long:bool, decimals :int):
	if (val < 0):
		return "-" + metric(val*-1, use_long, decimals)
	elif val == 0:
		return number(val, decimals)
	return metricify(val, use_long, decimals)

func metricify(val: float, use_long: bool, _decimals = 3):
	var level :int = floor(log(val)/log(1000))
	level = clamp(level, negative_prefixes.size()*-1, positive_prefixes.size())
	var amount = val / pow(1000, level)
	var prefix = ""
	if (level < 0):
		if (use_long):
			prefix = full_negative_prefixes[level*-1]
		else:
			prefix = negative_prefixes[level*-1]
	else:
		if (use_long):
			prefix = full_positive_prefixes[level*-1]
		else:
			prefix = positive_prefixes[level]
	return(number(amount, _decimals) + " " + prefix)
	
func number(val: float, decimals : int):
	return (("%." + str(decimals)+"f") % val)
