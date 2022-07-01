extends RigidBody2D

export onready var speed = 200
var target: Vector2 setget set_target,get_target 

# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug(target)
	set_gravity_scale(0)
	apply_impulse(Vector2(),Vector2(0,speed).rotated(rotation))


func _process(_delta ):
	pass


func _on_Area2D_body_entered(body):
	pass # Replace with function body.


func set_target(new_target: Vector2):
	target = new_target


func get_target() -> Vector2:
	return target
