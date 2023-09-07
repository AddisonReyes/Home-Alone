extends Node3D


@onready var fader = $CanvasLayer/Fader
@onready var player = $Player
var lastPlayerSound


func _ready():
	fader.fade_in()
	
	lastPlayerSound = player.soundPosition
	$Timers/UpdateTarget.start()


func _physics_process(delta):
	if lastPlayerSound != player.soundPosition:
		get_tree().call_group("Enemy", "chase")
		get_tree().call_group("Enemy", "update_target_location", player.soundPosition)
		lastPlayerSound = player.soundPosition


func _on_update_target_timeout():
	
	$Timers/UpdateTarget.start()


func _on_fader_fade_finished():
	$CanvasLayer.queue_free()
