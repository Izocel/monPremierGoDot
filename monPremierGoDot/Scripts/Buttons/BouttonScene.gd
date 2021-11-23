extends Button

class_name BouttonScene

export(PackedScene) var scene_a_charger


export(bool) var sfx_sur_focus = true
export(AudioStream) var sfx_du_focus
export(String) var bus_channel = "MasterEffets"

export(Color) var couleur_texte = Color.white
export(Color) var couleur_texte_focus = Color.orange

func _ready():
	$Label.add_color_override("font_color",couleur_texte)
	$"../../../../EffDetsAudioStreamPlayer".bus = bus_channel
	pass


func _process(delta):
	pass
	

func _on_both_focus_entered():
	$Label.uppercase = true
	$Label.add_color_override("font_color",couleur_texte_focus)
	
	if(sfx_sur_focus):
		var streamPlayer = $"../../../../EffetsAudioStreamPlayer"
		streamPlayer.stream = sfx_du_focus
		streamPlayer.volume_db = -8
		streamPlayer.play()
	
func _on_both_focus_exited():
	$Label.uppercase = false
	$Label.add_color_override("font_color",couleur_texte)
