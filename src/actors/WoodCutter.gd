extends "res://src/actors/Entity.gd"

onready var timer := $CuttingTime

var isGathering := false
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = rand_range(1,5)
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
			return_to_castle(delta)
		States.WOOD:
			go_to_work(delta)
		States.GATHER:
			gather(delta)
			
	_velocity = move_and_slide(_velocity)

func move_towards_tree():
	if !isGathering:
		var tree = get_tree().get_nodes_in_group("tree")
		target_position.x = tree[0].getLocation().x
		state = States.WOOD
	
func go_to_work(delta):
	accelerate_to_point(target_position, speed * delta)
	if is_at_target_position():
		isGathering = true
		state = States.GATHER
		var tree = get_tree().get_nodes_in_group("tree")
		var location = tree[0].getTreeLocation()
		var rang = rng.randi_range(0,2)
		target_position = location[rang]
		timer.start()
	
func gather(delta):
	var direction = (target_position - global_position).normalized()
	var acceleration_vector = direction * (speed * delta)
	_velocity += acceleration_vector
	_velocity = _velocity.clamped(MAX_SPEED)
	if is_at_target_position():
		if _velocity.x >= 0:
			$AnimationPlayer.play("chop_left")
			_velocity.x = 0
		else:
			$AnimationPlayer.play("chop_right")
			_velocity.x = 0
	else:
		set_animation()
	
func return_to_castle(delta):
	var castle = get_tree().get_nodes_in_group("castle")
	target_position.x = castle[0].getDoorPosition().x
	accelerate_to_point(target_position, speed * delta)
	if is_at_target_position():
		isGathering = false
		move_towards_tree()

func _on_Timer_timeout() -> void:
	state = States.RETURN
