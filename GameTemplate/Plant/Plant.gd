extends Area2D

export var MAX_GROW_LEVEL = 2
export var GROW_TIME = 2

onready var time_elapsed = 0
onready var grow_level = 0

func _ready():
	$AnimatedSprite.animation = "level0"
	$SnailSimulator.wait_time = randf() * 15
	$SnailSimulator.start()
	$SnailSimulator.connect("timeout", self, "snail_bite")

func _process(delta):
	time_elapsed += delta
	
	if grow_level < MAX_GROW_LEVEL and time_elapsed >= GROW_TIME:
		grow_level += 1
		print_debug("Plant upgraded")
		update_grow_level()
		
func snail_bite():
	if grow_level > 0:
		grow_level -= 1
		print_debug("Plant bited! ")
		update_grow_level()
		$SnailSimulator.wait_time = randf() * 15
		$SnailSimulator.start()
	else:
		queue_free()

func update_grow_level():
	time_elapsed = 0
	$AnimatedSprite.animation = str("level", grow_level)
