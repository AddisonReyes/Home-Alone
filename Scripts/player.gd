extends CharacterBody3D


const GRAVITY = -24.8
var MAX_SPEED = 4.7
const ACCEL = 3.5

var dir = Vector3()

const DEACCEL= 16
const MAX_SLOPE_ANGLE = 40

var camera
var rotation_helper

var MOUSE_SENSITIVITY = 0.05

var flashLightCooldown = true


func _ready():
	camera = $CameraPivot/Camera3D
	rotation_helper = $CameraPivot
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta):
	process_input(delta)
	process_movement(delta)
	
	if Input.is_action_pressed("flashlight") and flashLightCooldown:
		$CameraPivot/FlashLight/SpotLight3D.visible = !$CameraPivot/FlashLight/SpotLight3D.visible
		$CameraPivot/FlashLight/CooldownTimer.start()
		flashLightCooldown = false


func process_input(delta):
	dir = Vector3()
	var cam_xform = camera.get_global_transform()
	
	var input_movement_vector = Vector2()
	
	if Input.is_action_pressed("movement_forward"): input_movement_vector.y += 1
	if Input.is_action_pressed("movement_backward"): input_movement_vector.y -= 1
	if Input.is_action_pressed("movement_left"): input_movement_vector.x -= 1
	if Input.is_action_pressed("movement_right"): input_movement_vector.x += 1
	
	if Input.is_action_pressed("walking"): 
		MAX_SPEED = 4.7 / 3
	else:
		MAX_SPEED = 4.7
	
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


func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_helper.rotate_x(deg_to_rad(event.relative.y * MOUSE_SENSITIVITY * -1))
		self.rotate_y(deg_to_rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		
		var camera_rot = rotation_helper.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		rotation_helper.rotation_degrees = camera_rot


func _on_cooldown_timer_timeout():
	flashLightCooldown = true
