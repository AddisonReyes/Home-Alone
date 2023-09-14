extends Node3D


var rng = RandomNumberGenerator.new()


func _ready():
	var num = rng.randi_range(1, 3)
	
	if num == 1:
		$flashlight2.queue_free()
		$flashlight3.queue_free()
		
		$CatFood2.queue_free()
		$CatFood3.queue_free()
		
		$f2.queue_free()
		$f3.queue_free()
	
	elif num == 2:
		$flashlight1.queue_free()
		$flashlight2.queue_free()
		
		$CatFood1.queue_free()
		$CatFood2.queue_free()
		
		$f2.queue_free()
		$f1.queue_free()
	
	else:
		$flashlight1.queue_free()
		$flashlight3.queue_free()
		
		$CatFood1.queue_free()
		$CatFood3.queue_free()
		
		$f1.queue_free()
		$f3.queue_free()
