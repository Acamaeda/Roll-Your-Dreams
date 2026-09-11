extends "res://Engine/Events/Actions/Action.gd"
@export var dialogue : Array[String] = ["Hello"]

var canceled = false

func _ready():
	Utils.cancel_dialogue.connect(cancel)

func cancel():
	if (active):
		canceled=true

func action():
	for text in dialogue:
		if (!canceled):
			await show_dialogue(text)
	canceled=false
	return

func insert_counters(text : String):
	var slices = text.split("%", false)
	if (slices.size() == 1):
		return text
	var newtext = ""
	for slice in slices:
		if (slice.begins_with(" ")):
			newtext += "%" + slice
		else:
			var subslices = slice.split(" ", true, 1)
			var cname = subslices[0].to_lower()
			print(cname)
			var counter = get_tree().get_first_node_in_group("Level Control").get_node_or_null("Counters/" + cname)
			if (counter):
				newtext = newtext + counter.format() + " " + subslices[1]
				
			else:
				newtext = newtext + "%" + slice
	if (text.ends_with("%")):
		newtext += "%"
	return newtext

func show_dialogue(text):
	text = insert_counters(text)
	UI.PopupSmall.emit(text)
	await UI.dialogue_done
	await get_tree().create_timer(0.2).timeout
	return
	
