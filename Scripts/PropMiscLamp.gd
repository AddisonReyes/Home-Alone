extends StaticBody3D


var flashLightCooldown = true


func interact():
	if flashLightCooldown:
		$SpotLight3D.visible = !$SpotLight3D.visible
		$Timer.start()
		
		flashLightCooldown = false


func _on_timer_timeout():
	flashLightCooldown = true
