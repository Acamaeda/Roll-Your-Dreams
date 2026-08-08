extends AudioStreamPlayer

@export var author = "Someone"
@export var url = "something.com"
@export_enum("Sound Effect", "Music") var type = 0

func _on_ready():
	match type:
		0:
			bus = "SFX"
		1:
			bus = "Music"
