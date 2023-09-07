extends CharacterBody3D
class_name Enemy


var rng = RandomNumberGenerator.new()

@onready var navAgent = $NavigationAgent3D

var stayQuiet = false
var SPEED = 4.6


func _ready():
	$Timer.start()
	
	var time = 4#rng.randi_range(180, 360)
	$WeirdNoises/NoisesTimer.wait_time = time
	$WeirdNoises/NoisesTimer.start()


func _physics_process(delta):
	process_audio()
	
	if stayQuiet:
		return
		
	var currentLocation = global_transform.origin
	var nextLocation = navAgent.get_next_path_position()
	var newVelocity = (nextLocation - currentLocation).normalized() * SPEED
		
	velocity = velocity.move_toward(newVelocity, .26)
	look_at(nextLocation)
	move_and_slide()


func idle():
	stayQuiet = true


func chase():
	stayQuiet = false


func interact_with_the_world():
	if $RayCast3D.is_colliding():
		var collider = $RayCast3D.get_collider()
		
		if collider != null:
			if collider.is_in_group("interactable"):
				collider.interact()
				
			if collider.is_in_group("player"):
				jumpscare()


func jumpscare():
	pass#self.queue_free()


func process_audio():
	if velocity.length() != 0 and stayQuiet == false: 
		if $Steps/StepsTimer.time_left <= 0:
			$Steps/Steps.pitch_scale = rng.randf_range(0.1, 0.6)
			$Steps/Steps.play()
			
			$Steps/StepsTimer.start()


func update_target_location(target_location):
	navAgent.target_position = target_location


func _on_navigation_agent_3d_target_reached():
	idle()


func _on_timer_timeout():
	interact_with_the_world()
	$Timer.start()


func _on_area_3d_body_entered(body):
	body.soundPosition = body.global_transform.origin


func _on_noises_timer_timeout():
	return 
	
	var noise = rng.randi_range(1, 3)
	
	if noise == 1:
		$WeirdNoises/s1.play()
	
	if noise == 2:
		$WeirdNoises/s2.play()
	
	if noise == 3:
		$WeirdNoises/s3.play()
	
	var time = 3#rng.randi_range(180, 360)
	$WeirdNoises/NoisesTimer.wait_time = time
	$WeirdNoises/NoisesTimer.start()
