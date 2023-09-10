extends Node3D


var rng = RandomNumberGenerator.new()

var buttonOn = false
var interaction = false
var canInteract = true


func _ready():
	var time = rng.randi_range(60, 300)
	$TurnOffTimer.wait_time = time
	$TurnOffTimer.start()


func interact():
	if canInteract:
		interaction = true
		
		$Timer.start()
		canInteract = false


func _on_timer_timeout():
	canInteract = true


func _on_turn_off_timer_timeout():
	interact()
	
	var time = rng.randi_range(60, 300)
	$TurnOffTimer.wait_time = time
	$TurnOffTimer.start()
