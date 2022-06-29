extends State

onready var bee = self.get_node('../../')
onready var animationSprite = self.get_node('../../AnimatedSprite')
onready var timer = self.get_node('../../Timer')


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
	animationSprite.play("Idle")
	timer.wait_time = randi() % 5 + 1
	timer.start()
	timer.connect("timeout", self, "idle_timeout")


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass



func idle_timeout():
	print_debug("BEE: Idle to Run")
	state_machine.transition_to("Run")
	timer.disconnect("timeout", self, "idle_timeout")
