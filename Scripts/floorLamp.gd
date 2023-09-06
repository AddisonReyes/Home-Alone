extends Node3D


var rng = RandomNumberGenerator.new()
var flashLightCooldown = true


func interact():
	if flashLightCooldown:
		$SpotLight3D.visible = !$SpotLight3D.visible
		$CooldownTimer.start()
		flashLightCooldown = false
		
		$AudioStreamPlayer3D.pitch_scale = rng.randf_range(0.6, 1.6)
		$AudioStreamPlayer3D.play()
	
	if $SpotLight3D.visible:
		var time = rng.randi_range(120, 300)
		$TurnOffTimer.wait_time = time
		$TurnOffTimer.start()


func _on_cooldown_timer_timeout():
	flashLightCooldown = true


func _on_turn_off_timer_timeout():
	interact()
