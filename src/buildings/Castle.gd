extends Node2D

onready var scene_tree := get_tree()

var Citizen = preload("res://src/actors/Citizen.tscn")

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("castle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func getLocation() -> Position2D:
	return $Location.rect_global_position

func getDoorPosition() -> Position2D:
	return $Door.rect_global_position
