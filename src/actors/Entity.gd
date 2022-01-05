extends KinematicBody2D

enum States {FALL, IDLE, WANDER, RETURN, WOOD, GATHER}
export var state = States.IDLE

export var speed:= 5
export var health:= 10
export var attack:= 0
export var gravity:= 200
export var walking_range := 50

export var is_grounded:= false
export var _velocity:= Vector2.ZERO 

const FLOOR_NORMAL:= Vector2.UP
const MAX_SPEED := 5
const TOLERANCE := 5.0

onready var start_position := global_position
onready var target_position := global_position

func idle():
	state = States.WANDER
	update_target_position()

func wander(delta):
	accelerate_to_point(target_position, speed * delta)
	if is_at_target_position():
		state = States.IDLE

func fall(delta):
	_velocity.y += gravity * delta

func check_falling():
	if !is_on_wall() && !is_grounded:
		state = States.FALL
	if is_on_wall() && !is_grounded:
		is_grounded = true
		start_position = position
		state = States.IDLE
	
func update_target_position():
	var target_vector = Vector2(rand_range(-(walking_range), walking_range), 0)
	target_position = start_position + target_vector
	
#func return_to_castle():
#	var castle = get_tree().get_nodes_in_group("castle")
#	target_position.x = castle[0].getDoorPosition().x
#	state = States.RETURN
		
func is_at_target_position(): 
	return (target_position - global_position).length() < TOLERANCE
	
func accelerate_to_point(point, acceleration_scalar):
	var direction = (point - global_position).normalized()
	var acceleration_vector = direction * acceleration_scalar
	accelerate(acceleration_vector)

func accelerate(acceleration_vector):
	set_animation()
	_velocity += acceleration_vector
	_velocity = _velocity.clamped(MAX_SPEED)

func set_animation():
	if _velocity.x >= 0:
		$AnimationPlayer.play("move_right")
	else:
		$AnimationPlayer.play("move_left")
