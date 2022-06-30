extends State

export var anim_speed = 3
onready var bee = self.get_node('../../')
onready var animationSprite = self.get_node('../../AnimatedSprite')
onready var player: KinematicBody2D

var move_direction

func _ready():
	pass


# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	pass


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass


# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	print_debug("Attack")
	animationSprite.play("Attack")
	animationSprite.set_speed_scale(1)
#	bee.look_at(player.get_position()) # NO ME MIRA CON LOOK AT
	print_debug(bee.get_rotation(),'->',bee.get_rotation()+bee.get_angle_to(player.get_position()))
	bee.get_tween().interpolate_property(bee, "rotation",
		bee.get_rotation(),bee.get_rotation()+bee.get_angle_to(player.get_position()), 0.05,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	bee.get_tween().start()


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	player = null


func _on_AttackArea_body_entered(body):
	if body.get_name() == 'Player':
		player = body
		state_machine.transition_to("Attack")
