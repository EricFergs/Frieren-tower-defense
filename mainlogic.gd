extends Node
@onready var health: Label = $Health


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.money = Global._money
	Global.health = Global._health
	health.text =  "Health: " + str(Global.health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func updatehealth(taken):
	Global.health -= taken
	if Global.health < 0:
		get_tree().change_scene_to_file("res://GameOver.tscn")
	health.text = "Health: " + str(Global.health)
