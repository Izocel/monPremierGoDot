extends TileMap
class_name Portail

func get_class(): return "Portail"


export(String) var chemin_scene
export(Array) var classe_approuver = ["Action","Personnage"]

func as_right_of_teleportation(body_class:String) -> bool:

	if(body_class in classe_approuver):
		return true

	return false

func teleport_body(body:Node) -> void:

	# Le body sera un Acteur ou un personnage ? C'est la surprisssseeeeeee !!!!
	print(body.get_class())
	var body_class = body.get_class()
	var as_right = false

	if( as_right_of_teleportation( body_class )):

		#si le body est dans une des classe autorisées
		print("as right of passage --> TELEPORT")
		as_right = true
		
		if(as_right):
			charger_scene();

func charger_scene() -> void:
	
	if(chemin_scene != ""):
		get_tree().change_scene(chemin_scene)
