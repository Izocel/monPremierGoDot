extends Node

class_name Niveau

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$ColorRect.fondu_sortie()


func _process(delta: float) -> void:
	
	pass
