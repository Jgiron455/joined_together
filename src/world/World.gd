extends Node2D

var Citizen = preload("res://src/actors/Citizen.tscn")
var Wood = preload("res://src/actors/WoodCutter.tscn")

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var max_citizen := 5
var cur_citizen := 0
var cur_wood := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	add_citizen()

func add_citizen():
	if cur_citizen <= max_citizen:
		cur_citizen +=1
		var citizen = Citizen.instance()
		citizen.position = $Castle.position
		add_child(citizen)
		
	if cur_wood <= max_citizen:
		cur_wood +=1
		var citizen = Wood.instance()
		citizen.position = $Castle.position
		add_child(citizen)
