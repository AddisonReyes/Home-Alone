extends Control


@onready var label = $CanvasLayer/Fader/Control/VBoxContainer/Label
@onready var button = $CanvasLayer/Fader/Control2/VBoxContainer2/Back
@onready var fader = $CanvasLayer/Fader
@onready var anim = $AnimationPlayer

@export_dir var menu: String

var path = "res://Data/language.dat"
var language = "EN"

var exit = false


func _ready():
	$AudioStreamPlayer.play()
	exit = false
	
	load_data()
	fader.fade_in()
	
	if language == "EN":
		button.text = "Back"
		label.text = "Developer
Addison Reyes
(Lord Dakotah)


Software
Godot 4
MagicaVoxel
Audiomass
Aseprite
LabChirp

Sound Effects
Footsteps_Stiletto_Stone_Walk05 - marb7e (Freesound)
Light Switch - SoundReality (pixabay)
Porte open close - Slanesh (Freesound)
Locked Door - tvilgiat (Freesound)
AMBIENCE 1 CRICKETS AT NIGHT - MessyAcousticApocalypse666 (Freesound)
Key get - Mendenhall02 (Freesound)
cat meow 02 - Kyster (Freesound)
cat purring and meow - skymary (Freesound)
Pouring cat food into a plastic bowl - Ryntjie (Freesound)
office Chair manipulating adjustment leaver - MattRuthSound (Freesound)
Meow 6.wav - TRNGLE (Freesound)
Nagging Cat echo - dsp9000 (Freesound)
Telephone Pick Up - kwahmah_02 (Freesound)
ring-ring.mp3 - keybit2 (Freesound)
Cell phone interference 3 - MrAuralization (Freesound)
jumpscare.wav - crunchymaniac (Freesound)
CAT - bell sound tingeling(SFX).wav - HermanDV (Freesound)
Ghost 01.wav - MATRIXXX_ (Freesound)
Calling the bank.mp3 - jobro (Freesound)
Jumpscare.mp3 - SCP096Pro (Freesound)
Jumpscare_sound - JeremiahMendoweganalt (Freesound)
Jumpscare SFX (3).ogg - dragonboi50120 (Freesound)
Electronic Growl.ogg - dragonboi50120 (Freesound)
Jumpscare Scream - Breviceps (Freesound)
Heartbeats 61.wav - patobottos (Freesound)
Bass_sound_extract.wav - patobottos (Freesound)
Dark Ambience - PatrickLieberkind (Freesound)
Confetti - Sound Effect - Eccentric Sounds (Youtube)
Kids Cheering - Sound Effect (HD) - Gaming Sound FX (Youtube)

Assets
Modular House Collection - Keith at Fertile Soil Productions (Itch.io)
horror sound effects - YourPalRob (Itch.io)
Voxel Nature - Asset Bakery (Itch.io)
tiny texture pack - Screaming Brain Studios (Itch.io)"
	
	else:
		button.text = "Atras"
		label.text = "Desarrollador
Addison Reyes
(Lord Dakotah)


Software
Godot 4
MagicaVoxel
Audiomass
Aseprite
LabChirp

Efectos de sonido
Footsteps_Stiletto_Stone_Walk05 - marb7e (Freesound)
Light Switch - SoundReality (pixabay)
Porte open close - Slanesh (Freesound)
Locked Door - tvilgiat (Freesound)
AMBIENCE 1 CRICKETS AT NIGHT - MessyAcousticApocalypse666 (Freesound)
Key get - Mendenhall02 (Freesound)
cat meow 02 - Kyster (Freesound)
cat purring and meow - skymary (Freesound)
Pouring cat food into a plastic bowl - Ryntjie (Freesound)
office Chair manipulating adjustment leaver - MattRuthSound (Freesound)
Meow 6.wav - TRNGLE (Freesound)
Nagging Cat echo - dsp9000 (Freesound)
Telephone Pick Up - kwahmah_02 (Freesound)
ring-ring.mp3 - keybit2 (Freesound)
Cell phone interference 3 - MrAuralization (Freesound)
jumpscare.wav - crunchymaniac (Freesound)
CAT - bell sound tingeling(SFX).wav - HermanDV (Freesound)
Ghost 01.wav - MATRIXXX_ (Freesound)
Calling the bank.mp3 - jobro (Freesound)
Jumpscare.mp3 - SCP096Pro (Freesound)
Jumpscare_sound - JeremiahMendoweganalt (Freesound)
Jumpscare SFX (3).ogg - dragonboi50120 (Freesound)
Electronic Growl.ogg - dragonboi50120 (Freesound)
Jumpscare Scream - Breviceps (Freesound)
Heartbeats 61.wav - patobottos (Freesound)
Bass_sound_extract.wav - patobottos (Freesound)
Dark Ambience - PatrickLieberkind (Freesound)
Confetti - Sound Effect - Eccentric Sounds (Youtube)
Kids Cheering - Sound Effect (HD) - Gaming Sound FX (Youtube)

Assets
Modular House Collection - Keith at Fertile Soil Productions (Itch.io)
horror sound effects - YourPalRob (Itch.io)
Voxel Nature - Asset Bakery (Itch.io)
tiny texture pack - Screaming Brain Studios (Itch.io)"

	anim.play("credits")


func load_data():
	var file = FileAccess.open(path, FileAccess.READ)
	language = file.get_var()


func _on_back_pressed():
	exit = true
	fader.fade_out()


func _on_fader_fade_finished():
	if exit:
		get_tree().change_scene_to_file(menu)
