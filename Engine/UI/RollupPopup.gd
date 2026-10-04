extends PanelContainer

@onready var nameText : RichTextLabel = get_node("b1/b2/text")
@onready var scoreText : RichTextLabel = get_node("b1/b3/text2")

var displayTime = 2.5
var fadeinTime = 0.2
var fadeoutTime = 0.5
var timeLeft = 0.0

var objsize = 0.0
var objscore = 0.0

var spin_time = 3

@onready var focus = get_node("SubViewportContainer/SubViewport/Node3D/Focus")

func _ready() -> void:
	var control = get_tree().get_first_node_in_group("Level Control")
	if (!control): #this means we aren't in a level scene and shouldn't rescale
		return
 
	nameText.add_theme_font_size_override("normal_font_size", 32)
	scoreText.add_theme_font_size_override("normal_font_size", 32)

	nameText.add_theme_color_override("default_color", Color.GHOST_WHITE)
	nameText.add_theme_color_override("font_outline_color", Color.GHOST_WHITE)
	scoreText.text = ""
	modulate.a = 0
	
func update(object, model):
	var rollable  :Rollable = object.get_node("Rollable")
	if !(check_better(rollable)):
		return
	clear_focus()
	fix_model(model)
	focus.add_child(model)

	var mscale = 1 / rollable.max_dimension
	focus.set_scale(Vector3(mscale, mscale, mscale))
	focus.position.y = rollable.center_height * -1 / rollable.max_dimension
	objsize = rollable.size
	
	nameText.text = rollable.object_name
	
	if (rollable.my_counter):
		objscore = rollable.my_score
		var newtext = rollable.my_counter.format_value(objscore)
		if (rollable.my_counter.use_label):
			newtext += " " + rollable.my_counter.display_name
		if (objscore < 0):
			scoreText.add_theme_color_override("default_color", Color.RED)
		else:
			newtext = "+" + newtext
			scoreText.add_theme_color_override("default_color", Color.GREEN)
		scoreText.text = newtext
	else:
		scoreText.text = ""
		objscore = 0.0
		
	timeLeft = displayTime

func fix_model(model):
	for child : VisualInstance3D in model.get_children():
		child.set_layer_mask_value(1, false)
		child.set_layer_mask_value(2, false)

		child.set_layer_mask_value(20, true)
		fix_model(child)

	
func _process(delta):
	if (timeLeft > 0):
		timeLeft -= delta
		modulate.a = min(modulate.a + delta/fadeinTime, 1)
		if (timeLeft <= 0):
			objsize = 0.0
			objscore = 0.0
	else:
		modulate.a = max(modulate.a - delta/fadeoutTime, 0)

	
	focus.rotation.y += delta/spin_time
	
func clear_focus():
	for child in focus.get_children():
		focus.remove_child(child)
		child.queue_free()

func check_better(rollable):
	if (rollable.size > objsize / 5):
		return true
		
