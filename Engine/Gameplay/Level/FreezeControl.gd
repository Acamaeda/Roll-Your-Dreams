extends Node
var paused = false
var frozen = false

var pause_menu :PauseMenu
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu = UI.get_node("PauseMenu")
	UI.TogglePauseGame.connect(set_pause)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("Pause") && get_tree().get_first_node_in_group("Player")): # Only pause if in a level
		if (UI.get_node("OptionsMenu").visible || UI.get_node("MainMenu").visible):
			return
		toggle_pause()
			
func toggle_pause():
	paused = !paused
	UI.TogglePauseGame.emit(paused)
	pause_menu._toggle_control(pause_menu.id, paused, pause_menu.id)
	if paused:
		get_tree().paused = true
	if !paused && !frozen:
		get_tree().paused = false

func set_pause(pause):
	if (pause != paused):
		toggle_pause()
