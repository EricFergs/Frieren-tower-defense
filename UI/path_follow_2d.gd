extends PathFollow2D
@onready var label: Label = $"../../../Label"

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
	var currHealth = int(label.text.split(" ")[1]) - 1
	label.text = "Health: " + str(currHealth)
	get_parent().queue_free()
