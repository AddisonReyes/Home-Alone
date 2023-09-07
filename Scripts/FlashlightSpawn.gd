extends Node3D


var rng = RandomNumberGenerator.new()


func _ready():
	var num = rng.randi_range(0, 2)
	
	if num == 1:
		$flashlight2.queue_free()
		$flashlight3.queue_free()
	
	elif num == 2:
		$flashlight.queue_free()
		$flashlight2.queue_free()
	
	else:
		$flashlight.queue_free()
		$flashlight3.queue_free()
