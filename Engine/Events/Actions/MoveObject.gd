extends Action
@export var target : MovePoint
@export var move_time = 1.0


func action():
	target.start(move_time)
	await get_tree().create_timer(move_time).timeout
