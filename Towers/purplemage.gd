extends Node2D



var enemies_in_range = []
@onready var character_body_2d: CharacterBody2D = get_node("/root/Node/CharacterBody2D")
@onready var timer: Timer = $Timer
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
	timer.start()

	
	


func attackEnemy():
	var firstEnemy = null
	var maxProgress = -INF
	
	for body in area_2d.get_overlapping_bodies():
		if body.is_in_group("Enemy"):
			var distance = body.get_parent().progress_ratio
			if distance > maxProgress:
				firstEnemy = body
				maxProgress = distance
			
	if firstEnemy:
		var new_fireball = $Fireball.duplicate()
		new_fireball.position = $Fireball.global_position
		get_parent().add_child(new_fireball)
		new_fireball.visible = true
		print(new_fireball.position,new_fireball.visible)
		new_fireball.attack_start(firstEnemy)
		
	
		

			
func make_red():
	$Area2D/CollisionShape2D.make_red()
	#$Range.modulate = Color(255,0,0,0.3)

func make_blue():
	$Area2D/CollisionShape2D.make_blue()
	#$Range.modulate = Color(0.18,0.77,0.85,0.431)
		
	


func _on_timer_timeout() -> void:
	attackEnemy()
