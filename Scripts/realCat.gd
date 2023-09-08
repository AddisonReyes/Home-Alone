extends Node3D


var rng = RandomNumberGenerator.new()
var canInteract = true
var alive = true


func interact():
	if canInteract and alive:
		var num = rng.randi_range(0, 3)
		
		if num == 0:
			$Meow.pitch_scale = rng.randf_range(0.9, 1.6)
			$Meow.play()
		
		if num == 1:
			$Purr.pitch_scale = rng.randf_range(0.9, 1.6)
			$Purr.play()
		
		if num == 2:
			$Meow2.pitch_scale = rng.randf_range(0.9, 1.6)
			$Meow2.play()
		
		if num == 3:
			$Meow3.pitch_scale = rng.randf_range(0.9, 1.6)
			$Meow3.play()
		
		$Timer.start()
		canInteract = false


func death():
	if alive:
		alive = false
		
		$StaticBody3D.queue_free()
		$Cat.queue_free()
		
		$CatDeath.visible = true


func _on_timer_timeout():
	canInteract = true
