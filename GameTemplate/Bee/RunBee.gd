extends State
# MOVEMENT FROM:
# 	https://godotengine.org/qa/31522/how-to-apply-sprite-for-8-direction-movement

onready var bee = self.get_node('../../')
onready var animationSprite = self.get_node('../../AnimatedSprite')
onready var timer = self.get_node('../../Timer')

var move_direction

func _ready():
	pass


# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	#if !Input.is_action_pressed("move_left") and !Input.is_action_pressed("move_up") and !Input.is_action_pressed("move_right") and !Input.is_action_pressed("move_down"):
	#	print_debug("BEE: Run to Idle")
	#	state_machine.transition_to("Idle")
	pass


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	if bee.move_and_collide(move_direction * bee.speed):
		change_move_direction()

func direction2str(direction):
	var angle = direction.angle()
	if angle < 0:
		angle += 2 * PI
	var index = round(angle / PI * 4)
	return bee.get_dir(index)

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	change_move_direction()
	
	timer.wait_time = randi() % 5 + 1
	timer.start()
	timer.connect("timeout", self, "run_timeout")

# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass

func change_move_direction():
	move_direction = Vector2()
	
	var LEFT = 0
	var RIGHT = 0
	var UP = 0
	var DOWN = 0
	
	while !LEFT and !RIGHT and !UP and !DOWN:
		LEFT = randi() % 2
		RIGHT = randi() % 2
		UP = randi() % 2
		DOWN = randi() % 2

	move_direction.x = int(RIGHT) - int(LEFT)
	move_direction.y = int(DOWN) - int(UP)

	bee.set_facing(move_direction)	
	bee.set_current_dir(direction2str(bee.facing))
	
	var animation = bee.get_current_dir() + "Run"
	if animationSprite.get_animation() != animation:
		animationSprite.play(animation)

func run_timeout():
	timer.disconnect("timeout", self, "run_timeout")
	print_debug("BEE: Run to Idle")
	state_machine.transition_to("Idle")


