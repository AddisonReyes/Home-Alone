extends Node3D


var rng = RandomNumberGenerator.new()

var playerInteract = false
var canInteractCall = false
var interaction = true
var canStop = false


func ring():
	$Ring.play()


func canInteract():
	canInteractCall = true
	interaction = true


func interact():
	if interaction:
		if canInteractCall:
			playerInteract = true
			$ReducePitchTimer.start()
			$Audio.play()
			$Ring.stop()
		
		else:
			$Static.play()
		
		interaction = false
		$Timer2.start()


func _on_ring_finished():
	if playerInteract == false and canStop == false:
		$Ring.play()


func _on_timer_2_timeout():
	interaction = true


func _on_reduce_pitch_timer_timeout():
	$Audio.pitch_scale -= rng.randf_range(0.06, 0.09)
	$ReducePitchTimer.start()
