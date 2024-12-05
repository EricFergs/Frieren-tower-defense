extends Control


@onready var tower_scene: PackedScene = preload("res://Towers/tower1.tscn")  # Replace with your actual tower scene path
var placing = false
var tower_instance: Node2D = null 	

@onready var money: Label = $"../Money"
var placeable = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if placing:
		follow_mouse()
		
func follow_mouse():
	if tower_instance:
		tower_instance.position = get_global_mouse_position()


func _on_texture_button_pressed() -> void:
	if Global.money >= 10:
		Global.money -= 10
		money.text = "Money: " + str(Global.money)
		if not placing:  # Start placing the tower
			tower_instance = tower_scene.instantiate()  # Create an instance of the tower
			placing = true  # Set placing to true
			placeable = true
			get_tree().current_scene.add_child(tower_instance) # Add the tower instance to the scene
		# The tower follows the mouse in _process()


func _input(event):
	if placing and event is InputEventMouseButton:
		if event.pressed:  # Check if the mouse button is pressed
			if placeable:
				placing = false  # Stop placing
				tower_instance.is_placed()
				tower_instance = null  # Clear the reference to the tower instance
			else:
				tower_instance.queue_free()
				placing = false
				tower_instance = null  # Clear the reference to the tower instance


func _on_tower_areas_body_entered(body: Node2D) -> void:
	if tower_instance and not body.is_in_group("Enemy"):
		tower_instance.make_red()
		placeable = false


func _on_tower_areas_body_exited(body: Node2D) -> void:
	if tower_instance and not body.is_in_group("Enemy"):
		tower_instance.make_blue()
		placeable = true
