extends "res://src/actors/Entity.gd"

onready var timer : Timer = $CuttingTime
onready var scene_tree := get_tree()

var isGathering := false
var rng = RandomNumberGenerator.new()

signal quitting

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("lumberjack")
	speed = rand_range(1,5)
	rng.randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_towards_tree()
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
		States.QUIT:
			quitting(delta)
				
	_velocity = move_and_slide(_velocity)

func move_towards_tree():
	if !isGathering:
		var tree = scene_tree.get_nodes_in_group("tree")
		if tree:
			target_position.x = tree[0].getLocation().x
			state = States.WOOD
	
func go_to_work(delta):
	accelerate_to_point(target_position, speed * delta)
	if is_at_target_position():
		isGathering = true
		state = States.GATHER
		var tree = scene_tree.get_nodes_in_group("tree")
		if tree[0]:
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
			animation.play("chop_left")
			_velocity.x = 0
		else:
			animation.play("chop_right")
			_velocity.x = 0
	else:
		set_animation()
	
func return_to_castle(delta):
	var castle = scene_tree.get_nodes_in_group("castle")
	if castle[0]:
		target_position.x = castle[0].getDoorPosition().x
		accelerate_to_point(target_position, speed * delta)
		if is_at_target_position():
			PlayerData.set_wood(PlayerData.wood+5)
			isGathering = false
			move_towards_tree()
			
func quitting(delta):
	accelerate_to_point(target_position, speed * delta)
	if is_at_target_position():
		emit_signal("quitting")
		queue_free()
			
func quit():
	var lodge = scene_tree.get_nodes_in_group("lodge")
	target_position.x = lodge[0].getDoorPosition().x
	state = States.QUIT

func _on_Timer_timeout() -> void:
	state = States.RETURN
