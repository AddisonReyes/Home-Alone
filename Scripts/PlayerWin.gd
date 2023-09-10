extends Control


var rng = RandomNumberGenerator.new()

@onready var label = $CanvasLayer/Fader/Control/VBoxContainer/Label

@export_dir var menuScene: String
@onready var fader = $CanvasLayer/Fader

var path = "res://Data/language.dat"
var language = "EN"

var progress = 0

var nextScene = false
var exit


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	load_data()
	
	exit = false
	
	fader.fade_in()
	printText()
	
	$Celebration.play()
	$Coffetti.play()


func load_data():
	var file = FileAccess.open(path, FileAccess.READ)
	language = file.get_var()


func printText():
	if language == "EN":
		label.text = "You have escaped!"
	
	else:
		label.text = "Has escapado!"
	
	$Timer.start()


func _on_timer_timeout():
	fader.fade_out()
	exit = true


func _on_fader_fade_finished():
	if exit:
		get_tree().change_scene_to_file(menuScene)
