extends ColorRect

signal animation_debut
signal animation_fin

func fondu_entre():
	$Animations.play("Fondu_TC_entre")
	
func fondu_sortie():
	$Animations.play("Fondu_TC_sortie")
	

func _on_animation_started(anim_name: String) -> void:
	emit_signal("animation_debut")

func _on_animation_finished(anim_name: String) -> void:
	emit_signal("animation_fin")
