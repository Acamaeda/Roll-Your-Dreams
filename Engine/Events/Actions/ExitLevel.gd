extends "res://Engine/Events/Actions/Action.gd"

func act():
	UI.get_node("PauseMenu")._main_menu_btn_pressed()
