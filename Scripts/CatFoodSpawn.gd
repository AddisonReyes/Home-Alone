extends Node3D


var rng = RandomNumberGenerator.new()


func _ready():
	var num = rng.randi_range(0, 1)
	
	if num == 0:
		$CatFood.queue_free()
	
	else:
		$CatFood2.queue_free()
