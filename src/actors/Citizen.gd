extends "res://src/actors/Entity.gd"

onready var scene_tree := get_tree()
var Wood = preload("res://src/actors/WoodCutter.tscn")

signal lumberjack

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("citizen")
	speed = rand_range(1,5)

func _process(delta):
	basic_movement(delta)
	
func basic_movement(delta):
	check_falling()
	match state:
		States.IDLE:
			idle()
		States.WANDER:
			wander(delta)
		States.FALL:
			fall(delta)
		States.RETURN:
			returnCastle(delta)
		States.WOOD:
			start_lumberjack_job(delta)
			
	_velocity = move_and_slide(_velocity)

func returnCastle(delta):
	var castle = scene_tree.get_nodes_in_group("castle")
	target_position.x = castle[0].getDoorPosition().x
	accelerate_to_point(target_position, speed * delta)
	if is_at_target_position():
		state = States.IDLE	

func change_job_to_lumberjack():
	var lodge = scene_tree.get_nodes_in_group("lodge")
	target_position.x = lodge[0].getDoorPosition().x
	state = States.WOOD

func start_lumberjack_job(delta):
	accelerate_to_point(target_position, speed * delta)
	if is_at_target_position():
		emit_signal("lumberjack")
		queue_free()
