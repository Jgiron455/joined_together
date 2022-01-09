extends Control

onready var scene_tree := get_tree()
onready var node_children := get_children()

onready var citizen: Label = get_node("Citizens")
onready var lumberjack: Label = get_node("Lumberjack")
onready var wood: Label = get_node("Wood")

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerData.connect("update_res", self, "update_interface")
	update_interface()
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func update_interface() -> void:
	citizen.text = "Citizens: %s/%s" % [PlayerData.citizen, PlayerData.max_citizen]
	lumberjack.text = "Lumberjack: %s/%s" % [PlayerData.lumberjack, PlayerData.max_lumberjack]
	wood.text = "Wood: %s" % PlayerData.wood
