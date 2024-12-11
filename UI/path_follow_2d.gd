extends PathFollow2D


var speed = 0.12

# Called when the node enters the scene tree for the first time.

func _ready():
	progress_ratio = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_ratio  += delta*speed
	
	if progress_ratio >= 1.0:
		end_reached()
		
func end_reached():	
	#set_process(false) 
	get_tree().current_scene.updatehealth(get_child(0).health)
	get_parent().queue_free()

	
