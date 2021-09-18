extends RigidBody2D

class_name Kunai

# Declare member variables here. Examples:

export var vitesse = 550;
export var tempsVieSec = 16
export var pointAtk = 5

var velocite = Vector2();

# Called when the node enters the scene tree for the first time.
func _ready():
	gestionDirection()
	autoDestruction(tempsVieSec)
	pass


func _process(_delta):
	pass
	
func _physics_process(_delta):
	pass


func gestionDirection() -> void:
	var cibleQuandInstance = get_angle_to(get_global_mouse_position())
	apply_impulse(Vector2(), Vector2(vitesse,0).rotated(cibleQuandInstance))
	rotation = cibleQuandInstance

func autoDestruction(tempVie : int) -> void:
	yield(get_tree().create_timer(tempVie), "timeout")
	queue_free()
	
func on_Kunai_Colision(body) -> void:
	if body.is_in_group("NPC-Ennemi"):
		$CollisionShape2D.set_deferred("disabled", true)
		self.hide()
		body.tentative_Meutre(pointAtk)
	pass
