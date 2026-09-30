extends PanelContainer

@onready var text : RichTextLabel = get_node("b1/b2/text")

var displayTime = 2.0
var timeLeft = 0.0

var objsize = 0.0
var objscore = 0.0


func _ready() -> void:
	var control = get_tree().get_first_node_in_group("Level Control")
	if (!control): #this means we aren't in a level scene and shouldn't rescale
		return
 
	text.add_theme_font_size_override("normal_font_size", 64)
	
