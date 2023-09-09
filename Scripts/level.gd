extends Node3D


var rng  = RandomNumberGenerator.new()

const weirdSoundsPath = preload("res://Scenes/weird_sound.tscn")

const firstPosition = Vector3(40.683, -0.572, 32.351)
const secondPosition = Vector3(-7.281, -0.572, 16.873)
const thirdPosition = Vector3(17.9, -0.572, 14.083)

const catGhostSpawn = preload("res://Scenes/monster.tscn")

@onready var interface = $CanvasLayer/Interface
@onready var fader = $CanvasLayer/Fader
@onready var player = $Player

@onready var keyRing = $Objects/keyRing
@onready var frontDoor = $Objects/FrontDoor

@export_dir var menu: String
@export_dir var hints: String

var lastPlayerSound

var gameFinished = false
var transitionStarted = false
var lastObjetivePrinted = false
var secondObjetivePrinted = false
var resetLevelBool = false
var backToMenu = false

var weirdNoises


func _ready():
	fader.fade_in()
	
	var num = rng.randi_range(0, 1)
	
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


func monsterSpawn():
	var monster = catGhostSpawn.instantiate()
	monster.position = Vector3(28.984, -1.5, 1.275)
	add_child(monster)
	
	$Objects/keyRing.eraseKeys()
	$Objects/Keys.showKeys()
	
	$Timers/Timer.start()


func killRealCat():
	if $RealCat.alive:
		$Player.myCatIsDeath = true
		$RealCat.death()


func SoundReached():
	$JumpscaresAndSounds/YourCatIsDeath/CatGhostPaws.visible = true
	$RealCat.queue_free()
	$Phone.canInteract()
	$Phone.ring()


func createWeirdSound():
	var sound = weirdSoundsPath.instantiate()
	var num = rng.randi_range(0, 2)
	
	if num == 0:
		sound.position = firstPosition
	
	if num == 1:
		sound.position = secondPosition
	
	if num == 2:
		sound.position = thirdPosition
	
	add_child(sound)


func resetLevel():
	fader.beforeJumpscare()
	resetLevelBool = true


func levelFadeIn():
	fader.fade_in()


func levelFadeOut():
	interface.visible = false
	fader.fade_out()


func _on_update_target_timeout():
	$Timers/UpdateTarget.start()


func _on_fader_fade_finished():
	if gameFinished:
		get_tree().change_scene_to_file(menu)
	
	if resetLevelBool:
		get_tree().change_scene_to_file(hints)
	
	if backToMenu:
		get_tree().change_scene_to_file(menu)


func _on_shuiiin_finished():
	createWeirdSound()


func _on_timer_timeout():
	if lastObjetivePrinted == false:
		interface.printObjetive()
		lastObjetivePrinted = true


func _on_second_objetive_timer_timeout():
	if secondObjetivePrinted == false:
		secondObjetivePrinted = true
		interface.printObjetive()
