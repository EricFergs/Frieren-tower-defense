extends Node2D

var speed = 500
var attack_enemy = false
var enemy = null
var attackonce = false
var explode_once = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.monitoring = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if attack_enemy and is_instance_valid(enemy):
		var enemy_pos = enemy.global_position
		var direction = (enemy_pos - global_position).normalized()
		position += direction * speed * delta
	elif attack_enemy:
		_explode()
		attack_enemy = false
		
		
		
func attack_start(enemy_ref):
	$lifetime.start()
	enemy = enemy_ref
	$Area2D.monitoring = true
	attack_enemy = true
	
	

func _explode():
	if not explode_once:	
		$CPUParticles2D.emitting = true
		$Sprite2D.visible = false
		$deletion.start()
		explode_once = true
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not attackonce:
		attackonce = true
		_explode()
		attack_enemy = false
		var enemies = $"Explosion radius".get_overlapping_bodies()
		for e in enemies:
			e.health -= 2
		
		
	
	


func _on_deletion_timeout() -> void:
	queue_free()


func _on_lifetime_timeout() -> void:
	_explode()
