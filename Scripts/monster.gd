extends CharacterBody3D
class_name Enemy


var rng = RandomNumberGenerator.new()

@onready var player = get_parent().get_node("Player")
@onready var navAgent = $NavigationAgent3D
@onready var anim = $AnimationPlayer

var stayQuiet = false
var SPEED = 5.06


func _ready():
	$Timer.start()
	
	var time = 2
	$WeirdNoises/NoisesTimer.wait_time = time
	$WeirdNoises/NoisesTimer.start()
	
	anim.play("idle")


func _physics_process(delta):
	$RayCast3D2.look_at(player.global_position)
	process_audio()
	
	if $RayCast3D2.is_colliding():
		var collider = $RayCast3D2.get_collider()
		
		if collider != null:
			if collider.is_in_group("player"):
				jumpscare()
	
	if stayQuiet:
		return
	
	var currentLocation = global_transform.origin
	var nextLocation = navAgent.get_next_path_position()
	var newVelocity = (nextLocation - currentLocation).normalized() * SPEED
		
	velocity = newVelocity
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


func jumpscare():
	player.jumpscare()
	self.visible = false


func process_audio():
	if velocity.length() != 0: 
		if $Steps/StepsTimer.time_left <= 0:
			$Steps/Steps.pitch_scale = rng.randf_range(0.666, 0.999)
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
	if body is Player:
		update_target_location(body.global_transform.origin)
		body.soundPosition = body.global_transform.origin


func _on_noises_timer_timeout():	
	var noise = rng.randi_range(1, 4)
	
	if noise == 1:
		$WeirdNoises/s1.pitch_scale = rng.randf_range(0.5, 0.7)
		$WeirdNoises/s1.play()
	
	if noise == 2:
		$WeirdNoises/s2.pitch_scale = rng.randf_range(0.5, 0.7)
		$WeirdNoises/s2.play()
	
	if noise == 3:
		$WeirdNoises/s3.pitch_scale = rng.randf_range(0.5, 0.7)
		$WeirdNoises/s3.play()
	
	if noise == 3:
		$WeirdNoises/s4.pitch_scale = rng.randf_range(0.5, 0.7)
		$WeirdNoises/s4.play()
	
	if noise == 4:
		$WeirdNoises/s5.pitch_scale = rng.randf_range(0.5, 0.7)
		$WeirdNoises/s5.play()
	
	var time = rng.randi_range(16, 36)
	$WeirdNoises/NoisesTimer.wait_time = time
	$WeirdNoises/NoisesTimer.start()
