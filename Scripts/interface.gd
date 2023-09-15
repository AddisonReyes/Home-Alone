extends Control


@onready var player = get_parent().get_parent().get_node("Player")

@onready var level = get_parent().get_parent()
@onready var volume = $VBoxContainer2/Volume
@onready var dot = $VBoxContainer/Dot

@onready var objetiveAnim = $objetive/AnimationObjetive
@onready var objetive = $objetive/Label

@onready var fullscreenButton = $Panel/CenterContainer2/HBoxContainer/Fullscreen
@onready var languageButtom = $Panel/CenterContainer2/HBoxContainer/Options

const fullscreenIcon = preload("res://Sprites/fs.png")
const windowedIcon = preload("res://Sprites/df.png")

@onready var panel = $Panel
@onready var pauseLabel = $Panel/VBoxContainer3/Label
@onready var playButtom = $Panel/VBoxContainer3/Play
@onready var menuButtom = $Panel/VBoxContainer3/Menu

@export_dir var menu: String

var playerSurvived = false

var path = "res://Data/language.dat"
var language = "EN"

var animationStarted = false
var default = Color(1, 1, 1, 1)

var progress = 1


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	
	changeObjetive()
	load_data()
	
	panel.visible = get_tree().paused


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused: 
			get_tree().paused = false
			
		else:
			get_tree().paused = true
		
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	panel.visible = get_tree().paused

	if player == null:
		return
	
	if player.printDot:
		dot.visible = true
	
	else:
		dot.visible = false
	
	if player.doingNoise:
		$VBoxContainer2/AnimationPlayer.play("idle")
	
	else:
		$VBoxContainer2/AnimationPlayer.play("fade")
	
	if language == "EN":
		pauseLabel.text = "Pause"
		playButtom.text = "Continue"
		menuButtom.text = "Main menu"
		languageButtom.text = "ES"
	
	else:
		pauseLabel.text = "Pausa"
		playButtom.text = "Volver a jugar"
		menuButtom.text = "Menu principal"
		languageButtom.text = "EN"
	
	if playerSurvived:
		volume.visible = false
		dot.visible = false


func printObjetive():
	changeObjetive()
	objetiveFadeIn()


func changeObjetive():
	if progress == 1:
		if language == "EN":
			objetive.text = "Find food for Lily."
		
		else:
			objetive.text = "Busca comida para Lily."
	
	elif progress == 2:
		if language == "EN":
			objetive.text = "Find out where the noise is coming from."
		
		else:
			objetive.text = "Investiga de donde proviene el ruido."
	
	elif progress == 3:
		if language == "EN":
			objetive.text = "Look for the keys to leave the house."
		
		else:
			objetive.text = "Busca las llaves para salir de la casa."
	
	else:
		objetive.text = ""


func objetiveFadeIn():
	objetiveAnim.play("fade_in")
	$Timer.start()


func objetiveFadeOut():
	objetiveAnim.play("fade_out")


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


func _on_timer_timeout():
	objetiveFadeOut()


func _on_play_pressed():
	$AudioStreamPlayer.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false


func _on_quit_pressed():
	$AudioStreamPlayer.play()
	level.backToMenu = true
	level.levelFadeOut()


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


func _on_options_pressed():
	$AudioStreamPlayer.play()
	
	changeObjetive()
	save_data()
	load_data()


func _on_animation_objetive_animation_finished(anim_name):
	if anim_name == "fade_out":
		progress += 1
