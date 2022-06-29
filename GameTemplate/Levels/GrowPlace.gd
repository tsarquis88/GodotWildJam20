extends Area2D

var plant_scene = load("res://Plant/Plant.tscn")

onready var planted = false

signal player_entered

func _on_GrowPlace_body_entered(body):
	if body.get_name() == "Player":
		emit_signal("player_entered", self)

func plant():
	if not planted:
		var plant = plant_scene.instance()
		plant.position = Vector2(8,-8)
		plant.z_index = 0
		add_child(plant)
		planted = true
