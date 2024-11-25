extends RayCast2D

var is_casting = false : set = set_is_casting
var tween : Tween
var is_active = false

func _ready():
	set_physics_process(false)
	$Line2D.points[1] = Vector2.ZERO

#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#self.is_casting = event.pressed

func _physics_process(delta: float) -> void:
	force_raycast_update()
	var cast_point := target_position
	
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
	$CPUParticles2D2.position = cast_point *0.5
	$CPUParticles2D2.emission_rect_extents.x = cast_point.length() *0.5
	$Line2D.points[1] = cast_point

func set_is_casting(cast: bool):
	is_casting = cast
	is_active = cast
	$CPUParticles2D.emitting = is_casting
	$CPUParticles2D2.emitting = is_casting
	if is_casting:
		appear()
	else:
		disappear()
	set_physics_process(is_casting)
	
func appear():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property($Line2D, "width", 10.0,0.1)
	get_tree().create_timer(0.2).timeout.connect(func(): if is_active: disappear_and_reset())
	
func disappear_and_reset():
	disappear()
	is_active = false
	set_is_casting(false)

func disappear():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property($Line2D, "width", 0.0,0.1)
