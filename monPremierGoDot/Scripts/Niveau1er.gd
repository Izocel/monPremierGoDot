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


############### Fonction d'action  ###############
	
func collision_portail_niveau(collision):
	# Si il y a une collision avec le prtail
	if(collision):
		# Initier le corps de l'objet collisionné	
		joueur = collision.collider
		# Si l'objet qui est entré en collision est un portail
		changement_scene(joueur)
	
func changement_scene(joueur) -> void:
					
	if(portail.is_in_group("portail_suivant")):
		get_tree().change_scene(chemin_scene_suivante)
	
	
################ Fonction principale #################

func _process(delta: float) -> void:
	$PortailSuivant.
	pass

func _physics_process(delta):
	pass

