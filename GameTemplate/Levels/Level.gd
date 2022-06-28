extends Node2D

export (String, FILE, "*.tscn") var Next_Scene: String

var plant_scene = load("res://Plant/Plant.tscn")

func _ready()->void:
	Hud.visible = true
	PauseMenu.can_show = true
	$Player.connect("seed_planted", self, "plant_seed")
	$Player.z_index = 1
	$Bee.z_index = 1

func _on_Button_pressed()->void:
	PauseMenu.can_show = false
	Game.emit_signal("ChangeScene", Next_Scene)

func _exit_tree()->void:
	Hud.visible = false
	PauseMenu.can_show = false

func plant_seed():
	var plant = plant_scene.instance()
	plant.position = $Player.position
	plant.z_index = 0
	add_child(plant)
