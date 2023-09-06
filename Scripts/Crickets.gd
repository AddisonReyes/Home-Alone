extends Node3D


func _ready():
	$AudioStreamPlayer3D.play()


func _on_audio_stream_player_3d_finished():
	$AudioStreamPlayer3D.play()
