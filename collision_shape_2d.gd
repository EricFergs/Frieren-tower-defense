extends CollisionShape2D

var col = Color("#2ec4d96e")
var tower_range = 130
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shape.radius = tower_range


func make_blue():
	col = Color("#2ec4d96e")
	queue_redraw()

func make_red():
	col = Color(255,0,0,0.294)
	queue_redraw()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _draw() -> void:
	var cen = Vector2(0.588,0.294)
	draw_circle(cen,tower_range,col)
	
