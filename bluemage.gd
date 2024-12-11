extends CharacterBody2D

var health = 5;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ProgressBar.max_value = health
	get_parent().speed = 0.2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$ProgressBar.value = health
	if health <= 0:
		Global.money += health
		get_parent().get_parent().queue_free()
		