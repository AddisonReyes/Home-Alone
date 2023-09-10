extends Control


var rng = RandomNumberGenerator.new()

@onready var label = $CanvasLayer/Fader/Control/VBoxContainer/Label
@onready var skip = $CanvasLayer/Fader/Control/VBoxContainer2/skip

@export_dir var gameScene: String
@onready var fader = $CanvasLayer/Fader

var path = "res://Data/language.dat"
var language = "EN"

var progress = 0

var nextScene = false
var exit


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	load_data()
	
	
	fader.fade_in()
	exit = false
	skipText()
	printText()


func load_data():
	var file = FileAccess.open(path, FileAccess.READ)
	language = file.get_var()


func skipText():
	if language == "EN":
		skip.text = "-Press ESC to skip-"
	
	else:
		skip.text = "-Presiona ESC para saltar-"


func printText():
	if exit:
		get_tree().change_scene_to_file(gameScene)
		
	if language == "EN":
		if progress == 0:
			label.text = "You find yourself alone with your cat Lily living in an isolated house in the middle of the dark forest."
		
		if progress == 1:
			label.text = "It is a very cloudy night, the air is heavy and silent, broken only by the creaking of the wood of the house."
		
		if progress == 2:
			label.text = "You decide to take out a Ouija board that you found in a box. You think it might be a fun way to spend the night."
		
		if progress == 3:
			label.text = "You place the board on a cabinet in your room, with a mixture of enthusiasm and fear, you place your fingers on the pointer."
		
		if progress == 4:
			label.text = "You played for hours, you stopped playing with the Ouija because you heard your cat meowing, it seems like she's hungry..."
	
	else:
		if progress == 0:
			label.text = "Te encuentras solo con tu gata Lily viviendo en una casa aislada en medio del oscuro bosque."
		
		if progress == 1:
			label.text = "Es una noche muy nublada, el aire es pesado y silencioso, solo roto por el crujir de la madera de la casa."
		
		if progress == 2:
			label.text = "Decides sacar una tabla Ouija que has encontrado en una caja. Piensas que es una forma divertida de pasar la noche."
		
		if progress == 3:
			label.text = "Colocas la tabla encima de un gabetero de tu cuarto, con una mezcla de entusiasmo y temor, colocas tus dedos sobre el puntero."
	
		if progress == 4:
			label.text = "Jugaste durante horas, dejaste de jugar con la Ouija por que escuchaste los maullidos de tu gata, parece que tiene hambre..."
	
	$Timer.start()
	progress += 1


func _process(delta):
	if Input.is_action_pressed("pause") and exit == false:
		exit = true
		
		get_tree().change_scene_to_file(gameScene)


func _on_timer_timeout():
	if exit:
		get_tree().change_scene_to_file(gameScene)
		
	fader.fade_out()
	nextScene = true


func _on_fader_fade_finished():
	if exit:
		get_tree().change_scene_to_file(gameScene)
		
	if nextScene:
		nextScene = false
		if progress < 5:
			fader.fade_in()
			printText()
		else:
			get_tree().change_scene_to_file(gameScene)
