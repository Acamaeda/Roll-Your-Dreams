extends Node

@onready var text : RichTextLabel = get_node("b1/b2/text")
func _ready() -> void:
	var player = get_tree().get_first_node_in_group("Player")
	if (!player): #this means we aren't in a level scene and shouldn't rescale
		return
	var collector = player.get_node("Collector")
	collector.size_changed.connect(_on_player_size_change)
	text.add_theme_font_size_override("normal_font_size", 64)
	_on_player_size_change(collector.size, null)
	
func _on_player_size_change(size, _ignore):
	text.text=Utils.format.formatSize(size)
	
