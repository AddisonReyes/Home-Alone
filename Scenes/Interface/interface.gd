extends Control


@onready var player = get_parent().get_node("Player")

@onready var volume = $VBoxContainer2/Volume
@onready var dot = $VBoxContainer/Dot

@onready var label = $VBoxContainer/Label
var playerSurvived = false

var path = "res://Data/language.dat"
var language = "EN"

var animationStarted = false
var default = Color(1, 1, 1, 1)


func _ready():
	load_data()


func _process(delta):
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
	
	
	if playerSurvived:
		volume.visible = false
		dot.visible = false
		
		if language == "EN":
			label.text = "You have escaped"
	
		else:
			label.text = "Has escapado"


func load_data():
	var file = FileAccess.open(path, FileAccess.READ)
	language = file.get_var()
