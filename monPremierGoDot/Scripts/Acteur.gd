extends KinematicBody2D
class_name Acteur
func get_class(): return "Acteur"

# Declare member variables here. Examples:
var FLOOR_NORMAL = Vector2.UP



export var vitesseMin = Vector2(333.0,333.0)
export var gravite = 500.0
var velocite = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body....
