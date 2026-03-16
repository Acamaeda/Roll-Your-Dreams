extends Action

@export var wait_time:float

func action():
	await get_tree().create_timer(wait_time).timeout
	
