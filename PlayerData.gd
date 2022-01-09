extends Node
var citizen:= 0 setget set_citizen
var max_citizen := 4 setget set_max_citizen
var money:= 0 setget set_money

var lumberjack:= 0 setget set_lumberjack
var max_lumberjack:= 0 setget set_max_lumberjack

var wood:= 0 setget set_wood
var miner:= 0 setget set_miner
var stone:= 0 setget set_stone

signal update_res 

func set_citizen(value: int) -> void:
	citizen = value
	emit_signal("update_res")

func set_max_citizen(value: int) -> void:
	max_citizen = value
	emit_signal("update_res")
	
func set_money(value: int) -> void:
	money = value
	emit_signal("update_res")

func set_lumberjack(value: int) -> void:
	lumberjack = value
	emit_signal("update_res")
	
func set_max_lumberjack(value: int) -> void:
	max_lumberjack = value
	emit_signal("update_res")

func set_wood(value: int) -> void:
	wood = value
	emit_signal("update_res")
	
func set_miner(value: int) -> void:
	miner = value
	emit_signal("update_res")

func set_stone(value: int) -> void:
	stone = value
	emit_signal("update_res")
