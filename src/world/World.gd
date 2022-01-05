extends Node2D

var Citizen = preload("res://src/actors/Citizen.tscn")
var Wood = preload("res://src/actors/WoodCutter.tscn")

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var max_citizen := 5
var cur_citizen := 4
var cur_wood := 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	add_citizen()

	for child in get_children():
		if child.name.find("WoodCutter",0) >= 0 :
			if child.has_method("move_towards_tree"):
				child.move_towards_tree()
		
		#if citz is Wood.instance():

func add_citizen():
	var castle = get_tree().get_nodes_in_group("castle")
	if cur_citizen < max_citizen:
		cur_citizen +=1
		var citizen = Citizen.instance()
		citizen.position = castle[0].getDoorPosition()
		add_child(citizen)
		
	if cur_wood < max_citizen:
		cur_wood +=1
		var citizen = Wood.instance()
		citizen.position = castle[0].getDoorPosition()
		add_child(citizen)
