extends ValueTrigger
@export var counter : Counter

func _ready() -> void:
	super._ready()
	counter.value_changed.connect(value_changed)
