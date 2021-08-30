# src: https://godotengine.org/qa/3196/how-add-subcategories-inspector-script-variables-section
tool
extends Container

const PropertyList = preload("res://Scripts/ListePropriete.gd")

var property_list = PropertyList.new([
	["Panel/borderColor",TYPE_COLOR,null,"Couleur pour la bordure du panel"],
	["Panel/borderThickness",TYPE_REAL,10,"Épaisseur de la bordure du panel"],
	["Panel/backgroundColor",TYPE_COLOR,Color("00ffffff"),"Couleur de l'arrière plan du panel'"]
	])

func _get(property):
	return property_list.get(property)

func _set(property, value):
	property_list.set(property, value)

func _get_property_list():
	return property_list.properties.values()
# end src...
