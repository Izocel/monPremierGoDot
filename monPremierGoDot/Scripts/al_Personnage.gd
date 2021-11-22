extends Node

onready var point_vie_max = 100.00
onready var point_vie = point_vie_max
onready var position = Vector2.ZERO

func inscrire_point_vie(pv : float) -> void:
	point_vie = pv
	
func lire_point_vie() -> float:
	return point_vie

func inscrire_position(vecteur : Vector2) -> void:
	position = vecteur
	
func lire_position() -> Vector2:
	return position

func _ready() -> void:
	pass
