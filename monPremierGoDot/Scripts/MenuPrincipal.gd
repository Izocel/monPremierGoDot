extends Node

class_name MenuPrincipal

var chemin_scene

func _ready():
	for button in $Menu/LigneCentre/Bouttons.get_children():
		if(button is BouttonScene):
			button.connect("pressed", self, "lanceurScene",[button.scene_a_charger])


func lanceurScene(scene_a_charger):
	chemin_scene = scene_a_charger.get_path()
	
	if(scene_a_charger is Niveau):
		$ColorRect.show()
		$ColorRect.fondu_entre()
	else:
		get_tree().change_scene(chemin_scene)


func _colorRect_animation_fin() -> void:
	get_tree().change_scene(chemin_scene)
