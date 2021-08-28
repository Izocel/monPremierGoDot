extends Acteur

class_name Personnage
# Déclaré les variables de la classe ici.

export var hauteurSaut = 1.0
var PERSO_FLOOR_NORMAL = Vector2.UP
var direction = Vector2.ZERO

const col_radius_ratio = 1.8072
const col_height_ration = 9.0050
const col_y_change = 1

	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


#func _process(delta: float) -> void:
#	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	var old_flip_h = $Sprite.get_indexed("flip_h")
	
	var est_saut_interompu = Input.is_action_just_released("Saut") and velocite.y < 0.0
	direction = avoir_DirectionV2()
	velocite = velocite_mouvement(velocite, direction, vitesseMin, est_saut_interompu)
	move_and_slide(velocite, PERSO_FLOOR_NORMAL)
	
#	if(direction.x != 0 && direction.x != old_direction.x) :
	

	#### Animations ####
	
	if velocite.x !=  0:
		$AnimationPlayer.play("Courrir")
		
	else:
		$AnimationPlayer.play("Repos")

	
	#Reflexion du HFrame selon direction
	##Translation du colision box du au "flip"
	
	#Gauche
	if velocite.x > 0:
		$Sprite.flip_h = false
		$CollisionShape2D.position.x = -7.00
	#Droite
	if velocite.x < 0:
		$Sprite.flip_h = true
		$CollisionShape2D.position.x = 7
		
		
	print("Radius: ", $CollisionShape2D.shape.radius)
	print($CollisionShape2D.position)
func avoir_directionX() -> float:
	return Input.get_action_strength("Droite") - Input.get_action_strength("Gauche")
	
func avoir_directionY() -> float:
	var directionY = -hauteurSaut if Input.is_action_just_pressed("Saut") and is_on_floor() else 1.0
	
	return directionY


func avoir_DirectionV2() -> Vector2:
	return Vector2( avoir_directionX(), avoir_directionY() )
	
func velocite_mouvement(
		velocite_lineraire : Vector2,
		direction: Vector2,
		vitesse: Vector2,
		est_saut_interompu: bool
	) -> Vector2:
	var n_velocite = velocite_lineraire
	n_velocite.x = vitesse.x * direction.x
	n_velocite.y += gravite * get_physics_process_delta_time()
	if direction.y == -hauteurSaut:
		n_velocite.y = vitesse.y * direction.y
	if est_saut_interompu:
		n_velocite.y = 0.0
	return 	n_velocite
