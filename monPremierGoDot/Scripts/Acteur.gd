extends KinematicBody2D
class_name Acteur
func get_class(): return "Acteur"


# Declare member variables here. Examples:
var FLOOR_NORMAL = Vector2.UP
export var vitesseMin = Vector2(333.0,333.0)
export var gravite = 500.0
var velocite = Vector2.ZERO

func check_colision_portail() -> void:

	var last_slide = get_slide_count() - 1

	if(last_slide >= 0):
		var colision = get_slide_collision(last_slide)
		
		if(colision):
			var collider = colision.collider

			if(collider.is_in_group("Portail")):
				collider.teleport_body(self)


func _physics_process(_delta: float) -> void:
	check_colision_portail()
