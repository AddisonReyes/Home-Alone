extends Node3D


var rng = RandomNumberGenerator.new()

@onready var sound1 = $s1
@onready var sound2 = $s2
@onready var sound3 = $s3

@onready var timer1 = $Timer
@onready var timer2 = $Timer2
@onready var timer3 = $Timer3


func _ready():
	var time1 = rng.randi_range(1, 6)
	var time2 = rng.randi_range(1, 16)
	var time3 = rng.randi_range(1, 26)
	
	timer1.wait_time = time1
	timer2.wait_time = time2
	timer3.wait_time = time3
	
	timer1.start()
	timer2.start()
	timer3.start()


func selfDestruction():
	$Meow2.play()


func _on_area_3d_body_entered(body):
	timer1.stop()
	timer2.stop()
	timer3.stop()
	
	sound1.stop()
	sound2.stop()
	sound3.stop()


func _on_area_3d_body_exited(body):
	var time1 = rng.randi_range(1, 6)
	var time2 = rng.randi_range(1, 16)
	var time3 = rng.randi_range(1, 26)
	
	timer1.wait_time = time1
	timer2.wait_time = time2
	timer3.wait_time = time3
	
	timer1.start()
	timer2.start()
	timer3.start()


func _on_timer_timeout():
	sound1.pitch_scale = rng.randf_range(0.1, 0.6)
	sound1.play()
	
	var time1 = rng.randi_range(1, 6)
	timer1.wait_time = time1
	timer1.start()


func _on_timer_2_timeout():
	sound1.pitch_scale = rng.randf_range(0.1, 0.6)
	sound2.play()
	
	var time2 = rng.randi_range(1, 16)
	timer2.wait_time = time2
	timer2.start()


func _on_timer_3_timeout():
	sound1.pitch_scale = rng.randf_range(0.1, 0.6)
	sound3.play()
	
	var time3 = rng.randi_range(1, 26)
	timer3.wait_time = time3
	timer3.start()


func _on_meow_2_finished():
	self.queue_free()


func _on_area_3d_2_body_entered(body):
	get_parent().get_parent().killRealCat()
	$Meow2.play()
