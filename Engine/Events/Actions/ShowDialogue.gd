extends "res://Engine/Events/Actions/Action.gd"


# Called when the node enters the scene tree for the first time.
func action():
	UI.PopupSmall.emit("Blah")
