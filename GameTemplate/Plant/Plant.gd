extends Area2D

export var MAX_GROW_LEVEL = 10
export var MAX_GROW_TIME = 10
export var MIN_GROW_TIME = 2

onready var grow_level = -1

var color

func _ready():
	randomize()
	
	var rnd = randi() % 3
	if rnd == 0:
		color = "yellow"
	elif rnd == 1:
		color = "blue"
	else:
		color = "red"
	
	$GrowTimer.wait_time = randf() * ( MAX_GROW_TIME - MIN_GROW_TIME ) + MIN_GROW_TIME
	$GrowTimer.autostart = true
	$GrowTimer.start()
	$GrowTimer.connect("timeout", self, "grow")
	
	print(str("Plant created (Color=", color, " GrowTime=", $GrowTimer.wait_time, ")"))
	
	grow()

func grow():
	if grow_level < MAX_GROW_LEVEL:
		grow_level += 1
		$AnimatedSprite.animation = str(color, grow_level)
