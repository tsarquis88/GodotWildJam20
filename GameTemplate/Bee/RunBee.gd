extends State
# MOVEMENT FROM:
# 	https://godotengine.org/qa/31522/how-to-apply-sprite-for-8-direction-movement


export var anim_speed = 3
onready var bee = self.get_node('../../')
onready var animationSprite = self.get_node('../../AnimatedSprite')


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
	var arrived_to_next_point = bee.move_to(bee.target_point_world)
	if arrived_to_next_point:
		bee.path.remove(0)
		if len(bee.path) == 0:
			state_machine.transition_to("Idle")
			return
		bee.target_point_world = bee.path[0]


# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	animationSprite.play("Idle")
	animationSprite.set_speed_scale(anim_speed)
	bee.path = bee.astar.find_path(bee.position, bee.target_position)
	if not bee.path or len(bee.path) == 1:
		state_machine.transition_to('Idle')
		return
	# The index 0 is the starting cell
	# we don't want the character to move back to it in this example
	bee.target_point_world = bee.path[1]

# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass


