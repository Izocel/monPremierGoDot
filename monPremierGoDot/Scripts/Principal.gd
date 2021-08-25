extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Personnage/AnimationPlayer.play("Repos")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	print(delta)
#c
func _physics_process(delta):
	if Input.is_action_pressed("Droite"):
		$Personnage/AnimationPlayer.play("Courrir")
	if Input.is_action_just_released("Droite"):
		$Personnage/AnimationPlayer.play("Repos")
