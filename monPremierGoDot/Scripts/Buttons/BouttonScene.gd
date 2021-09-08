extends Control

class_name BouttonScene

export(PackedScene) var scene_a_charger


export(bool) var sfx_sur_focus = true
export(AudioStream) var sfx_de_focus = "res://Ressources/audio/sfx/click.wav"
export(String) var bus_channel = "MasterEffets"

export(Color) var couleur_texte = Color.white
export(Color) var couleur_texte_focus = Color.orange

func _ready():
	$"../../../../EffetsAudioStreamPlayer".bus = bus_channel
	pass


func _process(delta):
	pass
	

func _on_both_focus_entered():
	print("Mouse: Enter")
	$Label.uppercase = true
	$Label.add_color_override("font_color",couleur_texte_focus)
	
	if(sfx_sur_focus):
		var streamPlayer = $"../../../../EffetsAudioStreamPlayer"
		streamPlayer.stream = sfx_de_focus
		streamPlayer.volume_db = -8
		streamPlayer.play()
	
func _on_both_focus_exited():
	print("Mouse: Out")
	$Label.uppercase = false
	$Label.add_color_override("font_color",couleur_texte)
