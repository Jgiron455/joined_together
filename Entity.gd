extends KinematicBody2D

enum States {FALL, IDLE, WANDER}
var state = States.IDLE

export var speed:= 5
export var health:= 10
export var attack:= 0
export var gravity:= 200
export var walking_range := 50

export var is_grounded:= false
export var _velocity:= Vector2.ZERO 

const FLOOR_NORMAL:= Vector2.UP
const MAX_SPEED = 100
const TOLERANCE = 2.0
const ACCELERATION = 5

onready var start_position = global_position
onready var target_position = global_position

func basic_movement(delta):
	check_falling()
	match state:
		States.IDLE:
			state = States.WANDER
			update_target_position()
		States.WANDER:
			accelerate_to_point(target_position, ACCELERATION * delta)
			if is_at_target_position():
				state = States.IDLE
		States.FALL:
			_velocity.y += gravity * delta
			
	
	_velocity = move_and_slide(_velocity)

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
	
func is_at_target_position(): 
	return (target_position - global_position).length() < TOLERANCE
	
func accelerate_to_point(point, acceleration_scalar):
	var direction = (point - global_position).normalized()
	var acceleration_vector = direction * acceleration_scalar
	accelerate(acceleration_vector)

func accelerate(acceleration_vector):
	if _velocity.x >= 0:
		$AnimationPlayer.play("move_right")
	else:
		$AnimationPlayer.play("move_left")
	_velocity += acceleration_vector
	_velocity = _velocity.clamped(MAX_SPEED)
