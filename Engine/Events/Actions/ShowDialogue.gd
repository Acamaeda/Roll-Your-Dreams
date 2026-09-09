extends "res://Engine/Events/Actions/Action.gd"
@export var dialogue : Array[String] = ["Hello"]

var canceled = false

func _ready():
	Utils.cancel_dialogue.connect(cancel)

func cancel():
	if (active):
		canceled=true

func action():
	for texts in dialogue:
		if (!canceled):
			await show_dialogue(texts)
	canceled=false
	return

func show_dialogue(texts):
	UI.PopupSmall.emit(texts)
	await UI.dialogue_done
	await get_tree().create_timer(0.2).timeout
	return
