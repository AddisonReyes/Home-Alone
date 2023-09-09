extends ColorRect


@onready var animationPlayer = $AnimationPlayer
signal fadeFinished


func fade_in():
	$AnimationPlayer.play("fade_in")


func fade_out():
	$AnimationPlayer.play("fade_out")


func beforeJumpscare():
	$AudioStreamPlayer3D.play()
	$AnimationPlayer.play("beforeJumpscare")


func _on_animation_player_animation_finished(anim_name):
	emit_signal("fadeFinished")
