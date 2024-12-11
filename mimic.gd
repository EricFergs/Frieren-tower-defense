extends Node2D



var enemies_in_range = []
@onready var character_body_2d: CharacterBody2D = get_node("/root/Node/CharacterBody2D")

@onready var area_2d: Area2D = $Area2D

var damage = 5

var selected = false
var placed = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d_elta: float) -> void:
	pass
	
func is_placed() -> void:
	$Range.visible = false
	$Area2D/CollisionShape2D.hide()
	Global.mimic += 1
	

	
	


		
	

			
func make_red():
	$Area2D/CollisionShape2D.make_red()
	#$Range.modulate = Color(255,0,0,0.3)	

func make_blue():
	$Area2D/CollisionShape2D.make_blue()
	#$Range.modulate = Color(0.18,0.77,0.85,0.431)
		
	
