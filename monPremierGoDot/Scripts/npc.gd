extends Acteur #(KinematicsBody2D)
class_name Npc


# Déclaré les variables de la classe ici.

export var hauteurSaut = 1.0
export var maxPointDeVie = 100
export var pointDeVieActuel = 100

var PERSO_FLOOR_NORMAL = Vector2.UP
var direction = Vector2.ZERO
var saut_interompu = true
var est_vivant = true

var kunai  = preload("res://Scenes/kunai.tscn")

	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _process(delta: float) -> void:
	
	
	### Boucle détection d'action ###
	loopActionInput()
	
	#### Animations ####
	gestionAnimationDeplacement()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	
	direction = avoir_DirectionV2()
	saut_interompu =  est_saut_interompu()
	velocite = velocite_mouvement(velocite, direction, vitesseMin, saut_interompu)
	move_and_slide(velocite, PERSO_FLOOR_NORMAL)



### FONCTIONS DE CLASSE ###
func visible_Flash(n: int) -> void:
	for x in range(n):
		$Sprite.visible = false
		yield(get_tree().create_timer(0.1), "timeout")
		$Sprite.visible = true
		yield(get_tree().create_timer(0.1), "timeout")

func tentative_Meutre(pointAtk : float) -> bool:
	visible_Flash(4)
	pointDeVieActuel -= pointAtk
	
	print(pointDeVieActuel)
	return true if pointDeVieActuel <=0 else false
	
	
func loopActionInput() -> void:
	pass

func vecteurLancer() -> Vector2:
	var vecteurDecaler = get_global_position()
	var est_flip = $Sprite.flip_h == true
	
	if est_flip:
		if (get_global_mouse_position().x - vecteurDecaler.x) >= -1:
			vecteurDecaler.x = get_global_mouse_position().x - 12
		else:
			vecteurDecaler.x -= 6
	else:
		if (get_global_mouse_position().x - vecteurDecaler.x) <= 1:
			vecteurDecaler.x = get_global_mouse_position().x + 12
		else:
			vecteurDecaler.x += 6
	return vecteurDecaler

func est_saut_interompu() -> bool:
	return false
	pass

func gestionAnimationDeplacement() -> String:
	if velocite.x !=  0:
		$AnimationPlayer.play("Courrir")
	else:
		$AnimationPlayer.play("Repos")
	
	return $AnimationPlayer.current_animation
	
#Reflexion du HFrame selon position sourie
##Translation du colision box du au "flip"
func flip_horizontal_sur(pointX : float):
	#Gauche
	if $".".position.x + 5 <= pointX:
		$Sprite.flip_h = false
		$CollisionShape2D.position.x = -7.00
	#Droite
	if $".".position.x - 5 > pointX:
		$Sprite.flip_h = true
		$CollisionShape2D.position.x = 7
	
func lancerKunai() -> void:
	var sceneKunai = kunai.instance()
	add_child(sceneKunai)

func avoir_directionX() -> float:
	#return Input.get_action_strength("Droite") - Input.get_action_strength("Gauche")
	return 0.0
func avoir_directionY() -> float:
	#var directionY = -hauteurSaut if Input.is_action_just_pressed("Saut") and is_on_floor() else 1.0
	#return directionY
	return 0.0
	
func avoir_DirectionV2() -> Vector2:
	return Vector2( avoir_directionX(), avoir_directionY() )
	
func velocite_mouvement(
		velocite_lineraire : Vector2,
		_direction: Vector2,
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
