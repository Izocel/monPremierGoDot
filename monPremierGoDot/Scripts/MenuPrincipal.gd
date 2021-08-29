extends Node

class_name MenuPrincipal

var chemin_scene

func _ready():
	for button in $Menu/LigneCentre/Bouttons.get_children():
		var btn = button as BouttonScene
		if(btn is BouttonScene):
			btn.connect("pressed", self, "lanceurScene", [btn.scene_a_charger])


func lanceurScene(scene):
	scene as PackedScene
	chemin_scene = scene.get_path()
	
	$ColorRect.show()
	$ColorRect.fondu_entre()


func _colorRect_animation_fin() -> void:
	get_tree().change_scene(chemin_scene)
