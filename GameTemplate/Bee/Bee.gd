#extends KinematicBody2D
#
#export var MAX_HP = 100
#export(float) var SPEED = 200.0
#
#var hp = MAX_HP
#var velocity = Vector2()
#
#var directions = ["Right", "RightDown", "Down", "LeftDown", "Left", "LeftUp", "Up", "RightUp"]
#var current_direction: String = "Down" setget set_current_dir, get_current_dir
#var facing = Vector2() setget set_facing, get_facing
#
#var path = []
#var target_point_world = Vector2()
#var target_position = Vector2()
#
#
#func set_current_dir(new_dir: String):
#	current_direction = new_dir
#
#func get_current_dir() -> String:
#	return current_direction
#
#func get_dir(index: int) -> String:
#	return directions[index]
#
#func set_facing(new_facing: Vector2):
#	facing = new_facing
#
#func get_facing() -> Vector2:
#	return facing
#
#func get_animationSprite () -> Node:
#	return $AnimatedSprite
#
#func _ready():
#	pass
#
#func _process(_delta):
#	pass
#
#func move_to(world_position):
#	var MASS = 10.0
#	var ARRIVE_DISTANCE = 10.0
#
#	var desired_velocity = (world_position - position).normalized() * SPEED	
#	var steering = desired_velocity - velocity
#	velocity += steering / MASS
#	position += velocity * get_process_delta_time()
#	rotation = velocity.angle()
#	return position.distance_to(world_position) < ARRIVE_DISTANCE
#
#
#func path_to():
#	path = get_parent().get_node('TileMap').find_path(position, target_position)

# TODO: combinar este archivo con el funcionamiento por estados
extends KinematicBody2D

export(float) var SPEED = 200.0
onready var astar = get_parent().get_node('Tiles').get_node("Obstacles")
enum STATES { IDLE, FOLLOW }
var _state = null

var path = []
var target_point_world = Vector2()
var target_position = Vector2()

var velocity = Vector2()

func _ready():
	pass

func move_to(world_position):
	var MASS = 10.0
	var ARRIVE_DISTANCE = 10.0

	var desired_velocity = (world_position - position).normalized() * SPEED
	var steering = desired_velocity - velocity
	velocity += steering / MASS
	position += velocity * get_process_delta_time()
	rotation = velocity.angle()
	return position.distance_to(world_position) < ARRIVE_DISTANCE


func _input(event):
	if event.is_action_pressed('click'):
		if Input.is_key_pressed(KEY_SHIFT):
			global_position = get_global_mouse_position()
		else:
			print_debug('Yendo')
			target_position = get_global_mouse_position()
		$StateMachine.transition_to('Run')
