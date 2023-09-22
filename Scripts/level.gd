extends Node3D


var rng  = RandomNumberGenerator.new()

const weirdSoundsPath = preload("res://Scenes/weird_sound.tscn")

const firstPosition = Vector3(40.683, -0.572, 32.351)
const secondPosition = Vector3(-7.281, -0.572, 16.873)
const thirdPosition = Vector3(17.9, -0.572, 14.083)

const catGhostSpawn = preload("res://Scenes/monster.tscn")

const ghostPath = preload("res://Scenes/ghost.tscn")
var ghost = ghostPath.instantiate()

@onready var ghostSpawner = $JumpscaresAndSounds/GhostPosition

@onready var interface = $CanvasLayer/Interface
@onready var fader = $CanvasLayer/Fader
@onready var player = $Player

@onready var keyRing = $Objects/keyRing
@onready var frontDoor = $Objects/FrontDoor

@export_dir var menu: String
@export_dir var hints: String
@export_dir var final: String

var lastPlayerSound

var gameFinished = false
var transitionStarted = false
var lastObjetivePrinted = false
var secondObjetivePrinted = false
var resetLevelBool = false
var backToMenu = false

var monsterSpawned = false

var weirdNoises

var key2Showed = false


func _ready():
	fader.fade_in()
	
	var num = rng.randi_range(0, 1)
	
	lastPlayerSound = player.soundPosition
	$Timers/SpawnNewGhost.start()
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


func spawnGhost():
	var newGhost = ghost.duplicate()
	newGhost.position = ghostSpawner.givePosition()
	
	add_child(newGhost)
	var time = rng.randi_range(16, 36)
	$Timers/SpawnNewGhost.wait_time = time
	$Timers/SpawnNewGhost.start()


func monsterSpawn():
	if monsterSpawned == false:
		monsterSpawned = true
		
		lastPlayerSound = player.soundPosition
		
		var monster = catGhostSpawn.instantiate()
		monster.position = Vector3(20.026, -1.5, 78.242)
		add_child(monster)
		
		$Objects/keyRing.eraseKeys()
		
		$Timers/nextKey.start()
		$Objects/Keys.showKey1()
		
		$Timers/Timer.start()


func killRealCat():
	if $RealCat.alive:
		$Player.myCatIsDeath = true
		$RealCat.death()


func SoundReached():
	$Tuto/Shift.visible = false
	$JumpscaresAndSounds/YourCatIsDeath/Shift2.visible = true
	
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
		get_tree().change_scene_to_file(final)
	
	if resetLevelBool:
		var hintProb = rng.randf_range(0.1, 0.9)
		
		if hintProb <= 0.4:
			get_tree().change_scene_to_file(hints)
		
		else:
			get_tree().reload_current_scene()
	
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


func _on_spawn_new_ghost_timeout():
	spawnGhost()


func _on_monster_spawn_timer_timeout():
	monsterSpawn()


func _on_next_key_timeout():
	if key2Showed == false:
		$Objects/Keys.showKey2()
		key2Showed = true
