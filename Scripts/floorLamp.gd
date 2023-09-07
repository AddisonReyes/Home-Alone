extends Node3D


var rng = RandomNumberGenerator.new()
@onready var timer = $Timer6
var flashLightCooldown = true
var flashingLight = false


func _ready():
	var flashingRate = rng.randf_range(0.1, 0.9)
	if flashingRate <= 0.16:
		randomize()
		timer.wait_time = rng.randf_range(0.05, 0.1)
		timer.start()


func on_timer_timeout():
	timer.wait_time = rng.randf_range(0.05, 0.1)
	$SpotLight3D.light_energy = rng.randf_range(0.0, 1.0)
	timer.start()


func interact():
	if flashLightCooldown:
		$SpotLight3D.visible = !$SpotLight3D.visible
		$CooldownTimer.start()
		flashLightCooldown = false
		
		$AudioStreamPlayer3D.pitch_scale = rng.randf_range(0.6, 1.6)
		$AudioStreamPlayer3D.play()
	
	if $SpotLight3D.visible:
		var time = rng.randi_range(120, 300)
		$TurnOffTimer.wait_time = time
		$TurnOffTimer.start()


func _on_cooldown_timer_timeout():
	flashLightCooldown = true


func _on_turn_off_timer_timeout():
	interact()
