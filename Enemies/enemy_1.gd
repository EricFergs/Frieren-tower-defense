extends CharacterBody2D

var health = 10;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ProgressBar.max_value = health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ProgressBar.value = health
	if health <= 0:
		Global.money += 10
		get_parent().get_parent().queue_free()
		
