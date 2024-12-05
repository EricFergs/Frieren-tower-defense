extends Node2D


var range = 50
var enemies_in_range = []
@onready var character_body_2d: CharacterBody2D = get_node("/root/Node/CharacterBody2D")
@onready var timer: Timer = $Timer
@onready var area_2d: Area2D = $Area2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D


var selected = false
var placed = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func is_placed() -> void:
	$Range.visible = false
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
		
		var enemy_pos = firstEnemy.global_position
		var ray_global_pos = ray_cast_2d.global_position
		var direction = (enemy_pos - ray_global_pos).normalized()
		var ray_length = 1000 
		ray_cast_2d.target_position = direction * ray_length
		ray_cast_2d.force_raycast_update()
		ray_cast_2d.set_is_casting(true)
		#var local_pos = ray_cast_2d.get_parent().to_local(enemy_pos)
		#ray_cast_2d.set_target_position(local_pos)
		firstEnemy.queue_free()
		#ray_cast_2d.set_is_casting(false)
		
	
		

			
func make_red():
	$Range.modulate = Color(255,0,0,0.3)

func make_blue():
	$Range.modulate = Color(0.18,0.77,0.85,0.431)
		
	


func _on_timer_timeout() -> void:
	attackEnemy()
