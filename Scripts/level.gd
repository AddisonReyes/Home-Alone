extends Node3D


var rng  = RandomNumberGenerator.new()

@onready var fader = $CanvasLayer/Fader
@onready var player = $Player

@onready var keyRing = $Objects/keyRing
@onready var frontDoor = $Objects/FrontDoor

@export_dir var menu: String

var lastPlayerSound

var gameFinished = false
var transitionStarted = false

var weirdNoises


func _ready():
	fader.fade_in()
	
	var num = rng.randi_range(0, 1)
	
	if num == 0:
		$Objects/Doors/Door15.interact()
		$Objects/CatFood/CatFood2.queue_free()
		$FakeCat/WeirdSound.queue_free()
		$FakeCat.queue_free()
		
		weirdNoises = $FakeCat2/WeirdSound
	
	elif num == 1:
		$Objects/Doors/Door.interact()
		$Objects/CatFood/CatFood.queue_free()
		$FakeCat2/WeirdSound.queue_free()
		$FakeCat2.queue_free()
		
		weirdNoises = $FakeCat/WeirdSound
	
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


func monsterSpawned():
	$Objects/keyRing.eraseKeys()
	$Objects/Keys.showKeys()


func killRealCat():
	if $RealCat.alive:
		$Player.myCatIsDeath = true
		weirdNoises.queue_free()
		$RealCat.death()


func _on_update_target_timeout():
	$Timers/UpdateTarget.start()


func _on_fader_fade_finished():
	if gameFinished:
		get_tree().change_scene_to_file(menu)
