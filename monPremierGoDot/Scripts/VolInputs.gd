# src: https://godotengine.org/qa/3196/how-add-subcategories-inspector-script-variables-section
tool
extends VBoxContainer
class_name BusVolumeSlider


const PropertyList = preload("res://Scripts/ListePropriete.gd")

var bussArr = getAllBusesChannel()

export(AudioBusLayout) var Layout = AudioServer.generate_bus_layout()
export(String) var CanalSortie = bussArr[0]

var property_list = PropertyList.new([
	["CannauxDisponibles/Défaults",TYPE_ARRAY,bussArr,""]
	])


func _get(property):
	return property_list.get(property)

func _set(property, value):
	property_list.set(property, value)
	property_list_changed_notify()

func _get_property_list():
	return property_list.properties.values()
# end src...



# Declare member variables here. Examples:
var hasChanged = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if(hasChanged):
		updateSliderLabel()
		

func _on_vol_changed(value: int) -> void:
	hasChanged = true

func updateSliderLabel():
	var slider = get_children()[0]
	var label = get_children()[1]
	label.text = String(slider.value)
	updateAudioDB(Layout,CanalSortie, slider.value)
	hasChanged = false
	
func updateAudioDB(layout, canalSortie, value):
	print(layout, "  ", canalSortie, "  ", value)
	var busIdx = AudioServer.get_bus_index(canalSortie)
	var dbScale86Val = 20*log(value/100)
	
	AudioServer.set_bus_layout(layout)
	AudioServer.set_bus_volume_db(busIdx,dbScale86Val)


func getAllBusesChannel() -> Array:
	var arr = Array()
	var channelsCount = AudioServer.bus_count
	for buss in channelsCount:
		
		var bussName = AudioServer.get_bus_name(buss)
		arr.append(bussName)
	return arr
