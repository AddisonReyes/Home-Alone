extends StaticBody3D


var rng = RandomNumberGenerator.new()
@onready var player = get_parent().get_node("Player")

var delivered = false


func _ready():
	var time = rng.randi_range(16, 36)
	$Timer.wait_time = time
	$Timer.start()


func _physics_process(delta):
	if player == null:
		return
		
	self.look_at(player.global_position)


func miniJumpscare():
	if delivered == false:
		delivered = true
		self.queue_free()


func _on_timer_timeout():
	self.queue_free()
