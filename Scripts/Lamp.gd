extends Node3D


var flashLightCooldown = true


func interact():
	if flashLightCooldown:
		$SpotLight3D.visible = !$SpotLight3D.visible
		$CooldownTimer.start()
		flashLightCooldown = false


func _on_cooldown_timer_timeout():
	flashLightCooldown = true
