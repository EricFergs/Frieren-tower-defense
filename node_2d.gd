extends Node2D


var range = 50
var enemies_in_range = []
@onready var character_body_2d: CharacterBody2D = get_node("/root/Node/CharacterBody2D")
@onready var timer: Timer = $Timer
@onready var area_2d: Area2D = $Area2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D


var selected = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if selected:
		followMouse()
		
	
	

func followMouse():
	position = get_global_mouse_position()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			selected = true
		else:
			selected = false

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
		
	
		

			
	
	


func _on_timer_timeout() -> void:
	attackEnemy()
