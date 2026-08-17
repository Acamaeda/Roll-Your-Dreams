class_name GenericMenu extends SMenuControl



## If TRUE, sets the position of the back button through code.
@export var set_position_of_buttons:bool = true


@onready var back_btn: Button = get_node_or_null("back_btn")

func _ready() -> void:
	super()
	if(back_btn):
		back_btn.pressed.connect(_back_btn_pressed)
		if set_position_of_buttons:
			back_btn.position = (Vector2(UI.width, UI.height) * 0.95) - back_btn.size





func _back_btn_pressed() -> void:
	UI.ToggleUi.emit("main_menu", true, id)


func _toggle_control(_id:String, _value:bool, _previous:String = "") -> void:
	if id == "":
		push_error(name, " does not have an id set.")
	else:
		UI.previous_menu = _previous
		if _id == id:
			if(back_btn):
				back_btn.grab_focus()
				set_deferred("visible", _value)
		else:
			set_deferred("visible", not _value)
