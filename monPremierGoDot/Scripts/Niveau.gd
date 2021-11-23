extends Node

class_name Niveau
func get_class(): return "Niveau"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect.fondu_sortie()
