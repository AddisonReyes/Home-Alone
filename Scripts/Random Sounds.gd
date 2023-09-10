extends Node3D


var rng = RandomNumberGenerator.new()
@onready var Ouija = $Ouija


func _physics_process(delta):
	if Ouija.interaction:
		var sound = rng.randi_range(0, 2)
		
		if sound == 0:
			$S1.play()
		
		if sound == 1:
			$S2.play()
		
		else:
			$S3.play()
		
		Ouija.interaction = false
