extends State
# MOVEMENT FROM:
# 	https://godotengine.org/qa/31522/how-to-apply-sprite-for-8-direction-movement

onready var bee = self.get_node('../../')
onready var animationSprite = self.get_node('../../AnimatedSprite')



func _ready():
	pass


# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	if !Input.is_action_pressed("move_left") and !Input.is_action_pressed("move_up") and !Input.is_action_pressed("move_right") and !Input.is_action_pressed("move_down"):
		print_debug("BEE: Run to Idle")
		state_machine.transition_to("Idle")


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	var move_direction = Vector2()

	var LEFT = Input.is_action_pressed("move_left")
	var RIGHT = Input.is_action_pressed("move_right")
	var UP = Input.is_action_pressed("move_up")
	var DOWN = Input.is_action_pressed("move_down")

	move_direction.x = int(RIGHT) - int(LEFT)
	move_direction.y = int(DOWN) - int(UP)

	if LEFT || RIGHT || UP || DOWN:
		bee.set_facing(move_direction)
	
	bee.set_current_dir(direction2str(bee.facing))
	
	bee.move_and_collide(move_direction * bee.speed)
	
	var animation = bee.get_current_dir() + "Run"
	if animationSprite.get_animation() != animation:
		animationSprite.play(animation)


func direction2str(direction):
	var angle = direction.angle()
	if angle < 0:
		angle += 2 * PI
	var index = round(angle / PI * 4)
	return bee.get_dir(index)

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	pass

# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass





