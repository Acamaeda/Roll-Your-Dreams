extends "res://Engine/Events/Actions/Action.gd"
@export var text:String = "Hello!"

func action():
	UI.PopupSmall.emit(text)
	await UI.dialogue_done
	await get_tree().create_timer(0.2).timeout
	return
