extends Node3D


var rng = RandomNumberGenerator.new()

var buttonOn = false
var interaction = false
var canInteract = true


func interact():
	if canInteract:
		interaction = true
		
		if buttonOn:
			$OmniLight3D.visible = true
			$Buttom2.visible = true
			$Buttom.visible = false
			buttonOn = false
		
		else:
			$OmniLight3D.visible = false
			$Buttom2.visible = false
			$Buttom.visible = true
			buttonOn = true
		
		$AudioStreamPlayer3D.pitch_scale = rng.randf_range(0.6, 1.6)
		$AudioStreamPlayer3D.play()
		
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
