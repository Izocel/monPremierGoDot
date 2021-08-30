# src: https://godotengine.org/qa/3196/how-add-subcategories-inspector-script-variables-section
extends Object

var properties = {}

func add(name, type, default_value, hint):
	properties[name] = {
		"hint": PROPERTY_HINT_PLACEHOLDER_TEXT,
		"usage": PROPERTY_USAGE_DEFAULT,
		"name": name,
		"type": type,
		"value": default_value 
	}

func get(name):
	return properties[name].value

func set(name, value):
	if properties.has(name):
		properties[name].value = value

func _init(list):
	for prop in list:
		add(prop[0], prop[1], prop[2], prop[3])
# end src...
