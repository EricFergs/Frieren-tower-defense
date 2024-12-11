extends Node2D
@onready var timer: Timer = $Timer
@onready var label: Label = $Label
const ENEMY_1 = preload("res://UI/Path1.tscn")
@onready var character_body_2d: CharacterBody2D = $"../CharacterBody2D"
const greenmage = preload("res://Enemies/enemy1.tscn")
const violetmage = preload("res://violetmage.tscn")
const redmage = preload("res://redmage.tscn")
const wingedmage = preload("res://wingedmage.tscn")
const yellowmage = preload("res://yellowmage.tscn")
const bluemage = preload("res://bluemage.tscn")

var json = JSON.new()
var currWave = 0
var events = []
var types = {
	"greenmage": greenmage,
	"violetmage":violetmage,
	"redmage": redmage,
	"wingedmage":wingedmage,
	"yellowmage":yellowmage,
	"bluemage":bluemage
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var content = _loadJSON()
	var json = json.parse_string(content)
	_handleWaves(json)
	
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "Wave time: " + str(int(timer.get_time_left()))  + "\nWave: " + str(currWave)
	_check_spawn_events()

func _loadJSON():
	var file = FileAccess.open("res://UI//waveStruct.json", FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	return content

func _handleWaves(json):
	var waveCount = json["wave_count"]
	var wave = json["waves"]
	
	for i in waveCount:
		timer.start(wave[i]["duration"])
		currWave = wave[i]["wave_number"]
		
		_handleEnemies(wave[i]["enemies"])
		
		await timer.timeout
		

func _handleEnemies(enemies):
	for e in enemies:
		events.append(e)
		
func _check_spawn_events():
	if events:
		while events[0]["spawn_time"] >= timer.get_time_left():
			
			var e_instance = ENEMY_1.instantiate()
			var path = e_instance.get_child(0)
			var type = types[events[0]["type"]]
			var path_enemy = type.instantiate()
			path.add_child(path_enemy)
			character_body_2d.add_child(e_instance)
			events.pop_front()
			if not events:
				break
	pass
	
	
