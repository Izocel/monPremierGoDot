extends KinematicBody2D
class_name Acteur
func get_class(): return "Acteur"

# Declare member variables here. Examples:
var FLOOR_NORMAL = Vector2.UP


export var vitesseMin = Vector2(333.0,333.0)
export var gravite = 500.0
var velocite = Vector2.ZERO

func check_colision_portail_suivant() -> void:
	var colision  = get_slide_collision(get_slide_count() - 1)
	
	if(colision):
		var collider = colision.collider
		print("col")
	
		if(collider.is_in_group("PortailSuivant")):
			print(collider)
			print("le portail changeras de scene")
			pass


func _physics_process(_delta: float) -> void:
	check_colision_portail_suivant()
	pass
