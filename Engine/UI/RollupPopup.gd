extends PanelContainer

@onready var text : RichTextLabel = get_node("b1/b2/text")

var displayTime = 2.0
var timeLeft = 0.0

var objsize = 0.0
var objscore = 0.0

@onready var focus = get_node("SubViewportContainer/SubViewport/Node3D/Focus")

func _ready() -> void:
	var control = get_tree().get_first_node_in_group("Level Control")
	if (!control): #this means we aren't in a level scene and shouldn't rescale
		return
 
	text.add_theme_font_size_override("normal_font_size", 64)
	
	
func update(object, model):
	var rollable = object.get_node("Rollable")
	if !(check_better(rollable)):
		return
	clear_focus()
	fix_model(model)
	focus.add_child(model)

	var mscale = 1 / rollable.max_dimension
	focus.set_scale(Vector3(mscale, mscale, mscale))
	focus.position.y = rollable.center_height * -1 / rollable.max_dimension

func fix_model(model):
	for child : VisualInstance3D in model.get_children():
		child.set_layer_mask_value(1, false)
		child.set_layer_mask_value(2, false)

		child.set_layer_mask_value(20, true)
		fix_model(child)

	

	
func clear_focus():
	for child in focus.get_children():
		focus.remove_child(child)
		child.queue_free()

func check_better(objedt):
	return true
