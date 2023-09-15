extends Node3D

@onready var playButton = $CanvasLayer/Fader/Control/VBoxContainer/CenterContainer/VBoxContainer/Play
@onready var optionsButton = $CanvasLayer/Fader/Control/VBoxContainer/CenterContainer2/HBoxContainer/Options
@onready var fullscreenButton = $CanvasLayer/Fader/Control/VBoxContainer/CenterContainer2/HBoxContainer/Fullscreen
@onready var creditsButton = $CanvasLayer/Fader/Control/VBoxContainer/CenterContainer/VBoxContainer/Credits
@onready var quitButton = $CanvasLayer/Fader/Control/VBoxContainer/CenterContainer/VBoxContainer/Quit

const fullscreenIcon = preload("res://Sprites/fs.png")
const windowedIcon = preload("res://Sprites/df.png")

@onready var fader = $CanvasLayer/Fader

@export_dir var gameScene: String
@export_dir var creditsScene: String

var startGame = false
var credits = false

var path = "res://Data/language.dat"
var language = "EN"


func _ready():
	load_data()
	fader.fade_in()


func _physics_process(delta):
	if language == "EN":
		playButton.text = "Start Game"
		creditsButton.text = "Credits"
		optionsButton.text = "ES"
		quitButton.text = "Exit"
	
	else:
		playButton.text = "Iniciar juego"
		creditsButton.text = "Los creditos"
		optionsButton.text = "EN"
		quitButton.text = "Salir"
	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func save_data():
	var data
	
	if language == "EN":
		data = "ES"
	else:
		data = "EN" 
	
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_var(data)


func load_data():
	var file = FileAccess.open(path, FileAccess.READ)
	language = file.get_var()


func _on_play_pressed():
	$AudioStreamPlayer.play()
	startGame = true
	
	var data = language
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_var(data)
	
	fader.fade_out()


func _on_options_pressed():
	$AudioStreamPlayer.play()
	
	save_data()
	load_data()


func _on_credits_pressed():
	credits = true
	fader.fade_out()


func _on_quit_pressed():
	get_tree().quit()


func _on_fader_fade_finished():
	if startGame:
		get_tree().change_scene_to_file(gameScene)
	
	if credits:
		get_tree().change_scene_to_file(creditsScene)


func _on_fullscreen_pressed():
	$AudioStreamPlayer.play()
	if DisplayServer.window_get_mode() == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		fullscreenButton.set_button_icon(windowedIcon)
		
		return
	
	if DisplayServer.window_get_mode() == 3:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fullscreenButton.set_button_icon(fullscreenIcon)
		
		return
