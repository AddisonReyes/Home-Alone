extends Node3D


@onready var fader = $CanvasLayer/Fader
@onready var player = $Player

@onready var frontDoor = $Objects/FrontDoor

@export_dir var menu: String

var lastPlayerSound

var gameFinished = false
var transitionStarted = false


func _ready():
	fader.fade_in()
	
	lastPlayerSound = player.soundPosition
	$Timers/UpdateTarget.start()


func _physics_process(delta):
	if lastPlayerSound != player.soundPosition:
		get_tree().call_group("Enemy", "chase")
		get_tree().call_group("Enemy", "update_target_location", player.soundPosition)
		lastPlayerSound = player.soundPosition
	
	
	if frontDoor.playerSurvived and transitionStarted == false:
		get_tree().call_group("Enemy", "idle")
		gameFinished = true
		
		fader.fade_out()
		transitionStarted = true


func _on_update_target_timeout():
	$Timers/UpdateTarget.start()


func _on_fader_fade_finished():
	if gameFinished:
		get_tree().change_scene_to_file(menu)
