extends Node3D


var rng = RandomNumberGenerator.new()

var buttonOn = false
var interaction = false
var canInteract = true


func interact():
	if canInteract:
		interaction = true
		
		if buttonOn:
			$Buttom2.visible = true
			$Buttom.visible = false
			buttonOn = false
		
		else:
			$Buttom2.visible = false
			$Buttom.visible = true
			buttonOn = true
		
		$Timer.start()
		canInteract = false
	
	if buttonOn:
		var time = rng.randi_range(60, 300)
		$TurnOffTimer.wait_time = time
		$TurnOffTimer.start()


func _on_timer_timeout():
	canInteract = true


func _on_turn_off_timer_timeout():
	interact()
