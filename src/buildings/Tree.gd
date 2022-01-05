extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("tree")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func getLocation() -> Position2D:
	return $Location.rect_global_position

func getTreeLocation():
	return [$Tree.rect_global_position, $Tree2.rect_global_position, $Tree3.rect_global_position]
