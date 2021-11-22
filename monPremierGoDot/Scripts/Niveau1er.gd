extends Node

class_name Niveau

var chemin_scene_precedente = "res://Scripts/Niveau1er.gd"
var chemin_scene_suivante = "res://Scripts/Niveau2e.gd"
var portail
var collision
var joueur

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$ColorRect.fondu_sortie()