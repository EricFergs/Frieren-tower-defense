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
		$Iceattack.visible = true
		var hit = $Iceattack/AttackRange.get_overlapping_bodies()
		for e in hit:
			e.ice_health -=  randf_range(0.0, 0.3)
		if global_position.x < firstEnemy.global_position.x: # they're to the right
			#rotation = 0
			scale.x = -1.7
			
			
		else: # they are to the left
			#var angle_to_enemy = global_position.angle_to_point(firstEnemy.global_position)
			#var angle_degrees = rad_to_deg(angle_to_enemy)
			#print(angle_degrees)
			#if angle_degrees >= -70.0 and angle_degrees <= 70.0:
				#rotation = angle_to_enemy
			scale.x = 1.7
	else:
		$Iceattack.visible = false
		
			

			
			

	

			
func make_red():
	$Area2D/CollisionShape2D.make_red()
	#$Range.modulate = Color(255,0,0,0.3)	

func make_blue():
	$Area2D/CollisionShape2D.make_blue()
	#$Range.modulate = Color(0.18,0.77,0.85,0.431)
		
	


func _on_timer_timeout() -> void:
	attackEnemy()
