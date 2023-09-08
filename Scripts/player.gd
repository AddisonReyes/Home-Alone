extends CharacterBody3D
class_name Player


var rng = RandomNumberGenerator.new()

const GRAVITY = -24.8
var MAX_SPEED = 4.7
const ACCEL = 3

var dir = Vector3()

const DEACCEL= 66
const MAX_SLOPE_ANGLE = 40

var camera
var rotation_helper

var MOUSE_SENSITIVITY = 0.10

var flashLightCooldown = true

#///////////////////////////////////

var soundPosition
var flashlightOn
var walking

var myCatIsDeath = false
var flashlightPicked = true
var catFoodPicked = false

var doingNoise = false
var printDot = false
var keys = 0


func _ready():
	soundPosition = self.global_transform.origin
	
	camera = $CameraPivot/Camera3D
	rotation_helper = $CameraPivot
	
	$CameraAnimation.play("idle")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta):
	process_input(delta)
	process_movement(delta)
	process_audio()
	process_data()
	
	if flashlightPicked:
		if Input.is_action_just_pressed("flashlight") and flashLightCooldown:
			flashlight()
	
	if Input.is_action_pressed("interact") and $CameraPivot/RayCast3D.is_colliding():
		var collider = $CameraPivot/RayCast3D.get_collider()
		if collider != null:
			if collider.is_in_group("interactable"):
				collider.interact()
				
				if collider.is_in_group("door"):
					doingNoise = true


func process_audio():
	doingNoise = false
	
	if velocity.length() != 0 and walking == false: 
		if $Audio/StepsTimer.time_left <= 0:
			$Audio/Steps.pitch_scale = rng.randf_range(0.1, 0.6)
			$Audio/Steps.play()
			
			$Audio/StepsTimer.start()
			
		doingNoise = true


func flashlight():
	$CameraPivot/FlashLight/SpotLight3D.visible = !$CameraPivot/FlashLight/SpotLight3D.visible
	$CameraPivot/FlashLight/CooldownTimer.start()
	flashLightCooldown = false
		
	$Audio/FlashLight.play()
	
	flashlightOn = $CameraPivot/FlashLight/SpotLight3D.visible
	soundPosition = self.global_transform.origin
	
	if flashlightOn:
		var time = rng.randi_range(180, 360)
		$Audio/TurnOffTimer.wait_time = time
		$Audio/TurnOffTimer.start()


func process_data():
	if doingNoise:
		soundPosition = self.global_transform.origin
	
	
	if flashlightPicked:
		$CameraPivot/FlashLight.visible = true
	
	else:
		$CameraPivot/FlashLight.visible = false
		
	flashlightOn = $CameraPivot/FlashLight/SpotLight3D.visible
	
	if flashlightPicked:
		if $CameraPivot/RayCast3D2.is_colliding() and flashlightOn:
			var collider = $CameraPivot/RayCast3D2.get_collider()
			
			if collider != null:
				if collider.is_in_group("Monster"):
					soundPosition = self.global_transform.origin
					flashlight()
	
	
	printDot = false
	if $CameraPivot/RayCast3D.is_colliding():
		var collider = $CameraPivot/RayCast3D.get_collider()
		
		if collider != null:
			if collider.is_in_group("interactable"):
				printDot = true
				
				if collider.visible == false:
					printDot = false


func process_input(delta):
	dir = Vector3()
	var cam_xform = camera.get_global_transform()
	
	var input_movement_vector = Vector2()
	
	if Input.is_action_pressed("movement_forward"): input_movement_vector.y += 1
	if Input.is_action_pressed("movement_backward"): input_movement_vector.y -= 1
	if Input.is_action_pressed("movement_left"): input_movement_vector.x -= 1
	if Input.is_action_pressed("movement_right"): input_movement_vector.x += 1
	
	if Input.is_action_pressed("walking"): 
		MAX_SPEED = 6 / 2
		walking = true
		
	else:
		MAX_SPEED = 6
		walking = false
	
	input_movement_vector = input_movement_vector.normalized()
	
	dir += -cam_xform.basis.z * input_movement_vector.y
	dir += cam_xform.basis.x * input_movement_vector.x
	
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func process_movement(delta):
	dir.y = 0
	dir = dir.normalized()
	
	#velocity.y += delta * GRAVITY
	
	var hvel = velocity
	hvel.y = 0
	
	var target = dir
	target *= MAX_SPEED
	
	var accel
	if dir.dot(hvel) > 0:
		accel = ACCEL
		
	else:
		accel = DEACCEL
		
	hvel = hvel.lerp(target, accel * delta)
	velocity.x = hvel.x
	velocity.z = hvel.z
	
	move_and_slide()


func purinePicked():
	catFoodPicked = true
	$Audio/GrabFood.play()


func addKey():
	$Audio/GrapKey.play()
	keys += 1


func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_helper.rotate_x(deg_to_rad(event.relative.y * MOUSE_SENSITIVITY * -1))
		self.rotate_y(deg_to_rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		
		var camera_rot = rotation_helper.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		rotation_helper.rotation_degrees = camera_rot


func _on_cooldown_timer_timeout():
	flashLightCooldown = true


func _on_turn_off_timer_timeout():
	if flashlightOn:
		flashlight()
