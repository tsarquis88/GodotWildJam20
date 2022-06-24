extends KinematicBody2D

export var MAX_HP = 100
export var NORMAL_SPEED = 1

var speed = NORMAL_SPEED
var hp = MAX_HP

var directions = ["Right", "RightDown", "Down", "LeftDown", "Left", "LeftUp", "Up", "RightUp"]
var current_direction: String = "Down" setget set_current_dir, get_current_dir
var facing = Vector2() setget set_facing, get_facing

func set_current_dir(new_dir: String):
	current_direction = new_dir

func get_current_dir() -> String:
	return current_direction

func get_dir(index: int) -> String:
	return directions[index]

func set_facing(new_facing: Vector2):
	facing = new_facing

func get_facing() -> Vector2:
	return facing

func get_animationSprite () -> Node:
	return $AnimatedSprite

func _ready():
	pass

func _process(_delta):
	pass
