extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("tree")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func getLocation() -> Position2D:
	return $Size.rect_global_position

func getTreeLocation():
	return [$Tree.rect_global_position, $Tree2.rect_global_position, $Tree3.rect_global_position]
