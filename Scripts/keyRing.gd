extends Node3D


func eraseKeys():
	$Key.queue_free()
	$Key2.queue_free()
