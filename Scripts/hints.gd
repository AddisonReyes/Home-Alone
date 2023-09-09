extends Control


var rng = RandomNumberGenerator.new()

@onready var label = $CanvasLayer/Fader/Control/VBoxContainer/Label

@export_dir var gameScene: String
@onready var fader = $CanvasLayer/Fader

var path = "res://Data/language.dat"
var language = "EN"

var exit = false


func _ready():
	$AudioStreamPlayer.play()
	fader.fade_in()
	load_data()
	printHint()


func load_data():
	var file = FileAccess.open(path, FileAccess.READ)
	language = file.get_var()


func printHint():
	var num = rng.randi_range(0, 5)
	
	if language == "EN":
		if num == 0:
			label.text = "When you don't make noise, your cat's ghost doesn't follow you."
		
		if num == 1:
			label.text = "Don't point the flashlight at your cat's ghost."
		
		if num == 2:
			label.text = "Take advantage of the yard of the house to lose track of your cat."
		
		if num == 3:
			label.text = "When you see cat paws on the ground it means that a ghost has already taken over your cat's body."
		
		if num == 4:
			label.text = "Pay attention to your cat's bell, it always rings wherever it goes."
		
		if num == 5:
			label.text = "Your cat's ghost can only hear and see the light of your flashlight, be careful getting too close to it."
	
	else:
		if num == 0:
			label.text = "Cuando no haces ruido el fantasma de tu gato no te sigue."
		
		if num == 1:
			label.text = "No apuntes con la linterna al fantasma de tu gato."
		
		if num == 2:
			label.text = "Aprovecha el patio de la casa para perder el rastro a tu gato."
		
		if num == 3:
			label.text = "Cuando veas unas patas de gato en el suelo significa que un fantasma ya se apodero del cuerpo de tu gato."
		
		if num == 4:
			label.text = "Estate atento a la campanita de tu gato, siempre suena a donde vaya."
		
		if num == 5:
			label.text = "El fantasma de tu gato solo puede escuchar y ver la luz de tu linterna, ten cuidado acercandotele mucho."
	
	$Timer.start()


func _on_timer_timeout():
	fader.fade_out()
	exit = true


func _on_fader_fade_finished():
	if exit:
		get_tree().change_scene_to_file(gameScene)
