extends "res://Engine/Events/Conditions/ConditionTrigger.gd"
@export var text:String = "Do you want to do the thing?"

var result = false

func _ready():
		UI.PopupResult.connect(_get_result)


func check_condition():
	UI.PopupLarge.emit(text, text)
	await UI.dialogue_done
	await get_tree().create_timer(0.2).timeout
	return result

func _get_result(_thing, ans):
	result = ans
