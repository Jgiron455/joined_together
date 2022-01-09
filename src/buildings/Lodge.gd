extends Node2D

export var capacity := 5

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("lodge")
	PlayerData.set_max_lumberjack(PlayerData.max_lumberjack+capacity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func getLocation() -> Position2D:
	return $Location.rect_global_position

func getDoorPosition() -> Position2D:
	return $Door.rect_global_position
