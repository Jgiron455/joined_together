extends Control

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

signal update_lumberjack
signal remove_lumberjack

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Add_Lumberjack_pressed() -> void:
	emit_signal("update_lumberjack")


func _on_RemoveLumberjack_pressed() -> void:
	emit_signal("remove_lumberjack")
