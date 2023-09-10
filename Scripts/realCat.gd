extends Node3D


var rng = RandomNumberGenerator.new()
var canInteract = true
var alive = true


func interact():
	if canInteract and alive:
		var num = rng.randi_range(0, 1)
		
		if num == 0:
			$Meow.pitch_scale = rng.randf_range(1, 1.2)
			$Meow.play()
		
		if num == 1:
			$Purr.pitch_scale = rng.randf_range(1, 1.2)
			$Purr.play()
		
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
