extends Node

onready var viewport_three = get_root_three()



func get_root_three() -> String:
	var three_string = ""
	var compteur = 0;
	
	for x in get_parent().get_children():
		three_string += String(compteur) + "\n Nom noeud: " + x.name
		three_string += "\n Type noeud: " + String(typeof(x))
		three_string += "\n Path noeud: " + String( x.get_path())
		three_string += "\n"
		compteur += 1
	return three_string
