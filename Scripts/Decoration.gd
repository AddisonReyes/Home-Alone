extends Node3D


var rng = RandomNumberGenerator.new()

func _ready():
	var time = rng.randi_range(2, 6)
	$Timer.wait_time = time
	$Timer.start()


func _on_timer_timeout():
	var lamp = rng.randi_range(0, 3)
	
	if lamp == 0:
		$Lamp.interact()
	
	elif lamp == 1:
		$Lamp2.interact()
	
	elif lamp == 2:
		$Lamp3.interact()
	
	else:
		$Lamp4.interact()
	
	
	$AudioStreamPlayer3D.pitch_scale = rng.randf_range(0.6, 1.6)
	$AudioStreamPlayer3D.play()
	
	var time = rng.randi_range(60, 120)
	$Timer.wait_time = time
	
	$Timer.start()
