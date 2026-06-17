extends Node

@export var object_name: String = ""
@export var description: String = ""

@export_enum("Normal", "Super Detailed", "Super Simple")var collision: int
@export var solid: bool = true
@export var rollable: bool = true
@export var include_in_collection: bool = true

var target : Rollable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var parent = get_parent()
	for child in parent.get_children():
		if (child is Rollable):
			target = child
	if (!target):
		return
	
	if (object_name): target.object_name = object_name
	if (description): target.description = description
	
	target.collision = collision
	target.solid = solid
	target.rollable = rollable
	target.include_in_collection = include_in_collection

	
