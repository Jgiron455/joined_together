extends Node2D

onready var scene_tree := get_tree()
onready var node_children := get_children()
onready var timer : Timer =  get_node("Timer")

var Wood = preload("res://src/actors/WoodCutter.tscn")
var Citizen = preload("res://src/actors/Citizen.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func add_citizen():
	var castle = scene_tree.get_nodes_in_group("castle")
	if PlayerData.citizen < PlayerData.max_citizen:
		PlayerData.set_citizen(PlayerData.citizen+1)
		var citizen = Citizen.instance()
		citizen.position = castle[0].getDoorPosition()
		add_child(citizen)

func add_lumberjack():
	var lodge = scene_tree.get_nodes_in_group("lodge")
	var lumberjack = Wood.instance()
	lumberjack.position = lodge[0].getDoorPosition()
	add_child(lumberjack)
	
func remove_lumberjack():
	var lumberjack = scene_tree.get_nodes_in_group("lumberjack")
	var cur_c = lumberjack.pop_front()
	cur_c.quit()
	cur_c.remove_from_group("lumberjack")
	PlayerData.set_lumberjack(PlayerData.lumberjack-1)
	#PlayerData.set_max_citizen(PlayerData.max_citizen+1)
	cur_c.connect("quitting", self, "remove")

func remove():
	var lodge = scene_tree.get_nodes_in_group("lodge")
	PlayerData.set_citizen(PlayerData.citizen+1)
	PlayerData.set_max_citizen(PlayerData.max_citizen+1)
	var citizen = Citizen.instance()
	citizen.position = lodge[0].getDoorPosition()
	add_child(citizen)

func update_lumberjack():
	if PlayerData.lumberjack < PlayerData.max_lumberjack:
		PlayerData.set_citizen(PlayerData.citizen-1)
		PlayerData.set_max_citizen(PlayerData.max_citizen-1)
		PlayerData.set_lumberjack(PlayerData.lumberjack+1)
		var citizen = scene_tree.get_nodes_in_group("citizen")
		var cur_c = citizen.pop_front()
		cur_c.remove_from_group("citizen")
		cur_c.change_job_to_lumberjack()
		cur_c.connect("lumberjack", self, "add_lumberjack")

func _on_Timer_timeout() -> void:
	add_citizen()

func _on_OperationControl_update_lumberjack() -> void:
	update_lumberjack()

func _on_OperationControl_remove_lumberjack() -> void:
	remove_lumberjack()
