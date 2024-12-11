extends CharacterBody2D

var health = 100;
var ice_health = 30;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ProgressBar.max_value = health
	get_parent().speed = 0.02

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$ProgressBar.value = health
	if health <= 0:
		Global.money += 80
		get_parent().get_parent().queue_free()
	elif ice_health <= 0:
		get_parent().frozen = true
		var color = Color(0 / 255.0, 100 / 255.0, 100 / 255.0, 0.5)
		modulate = color
