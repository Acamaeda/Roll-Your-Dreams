extends "res://Engine/Events/Actions/Action.gd"
@export var text:String = "Hello!"

# Called when the node enters the scene tree for the first time.
func action():
	UI.PopupSmall.emit(text)
	await UI.dialogue_done
	return
