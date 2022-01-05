extends "res://Entity.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
			
	_velocity = move_and_slide(_velocity)

func returnCastle(delta):
	var castle = get_tree().get_nodes_in_group("castle")
	target_position.x = castle[0].getDoorPosition().x
	accelerate_to_point(target_position, speed * delta)
	if is_at_target_position():
		state = States.IDLE	
