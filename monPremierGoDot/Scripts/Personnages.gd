extends Acteur #(KinematicsBody2D)
class_name Personnage


# Déclaré les variables de la classe ici.
export var hauteurSaut = 1.0
export var max_Point_Vie = 100
export var point_Vie_Actuel = 100

var PERSO_FLOOR_NORMAL = Vector2.UP
var direction = Vector2.ZERO
var saut_interompu = true
var est_Invincible = false;

var kunai  = preload("res://Scenes/kunai.tscn")


func _ready() -> void:
	animation_Apparition(3,true)
	pass


func _process(delta: float) -> void:
	
	### Boucle détection d'actions ###
	gestionActions()
	
	#### Animations et Positionement ####
	gestionAnimationDeplacement()
	directionRegard(get_global_mouse_position().x)
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	
	### Déplacments 2D ###
	gestionDeplacement()


### FONCTIONS DE CLASSE ###

func gestionDeplacement() -> void:
	direction = avoir_DirectionV2()
	saut_interompu =  est_saut_interompu()
	velocite = velocite_mouvement(velocite, direction, vitesseMin, saut_interompu)
	move_and_slide(velocite, PERSO_FLOOR_NORMAL)

func gestionActions() -> void:
	if Input.is_action_just_released("ArmeLancer"):
		lancerInstanceKunai()


func lancerInstanceKunai() -> void:
	var instance = kunai.instance()
	instance.position = vecteurLancer()
	get_parent().add_child(instance)

func vecteurLancer() -> Vector2:
	var vecteurDecaler = get_global_position()
	vecteurDecaler.y += 3
	return vecteurDecaler

func est_saut_interompu() -> bool:
	return Input.is_action_just_released("Saut") and velocite.y < 0.0

func gestionAnimationDeplacement() -> String:
	if velocite.x !=  0:
		$AnimationPlayer.play("Courrir")
	else:
		$AnimationPlayer.play("Repos")
	return $AnimationPlayer.current_animation

func flashAnimation(delaiSec : float) -> void:
	var termine = get_tree().create_timer(delaiSec)
	while(termine.time_left > 0):
		
		#visible_Flash(1) <-- Marche pas ???? WTF ???
		$Sprite.visible = false
		yield(get_tree().create_timer(0.1), "timeout")
		$Sprite.visible = true
		yield(get_tree().create_timer(0.1), "timeout")

func visible_Flash(n: int) -> void:
	for x in range(n):
		$Sprite.visible = false
		yield(get_tree().create_timer(0.1), "timeout")
		$Sprite.visible = true
		yield(get_tree().create_timer(0.1), "timeout")

func animation_Apparition(delaiSec: int, soiger: bool) -> void:
	pouvoir_invicibiliter(delaiSec, soiger)
	flashAnimation(delaiSec)
	

func pouvoir_invicibiliter(delaiSec: int, soigner:bool) -> bool:
	devient_Invicible(soigner)
	var terminer = yield(get_tree().create_timer(delaiSec), "timeout")
	devient_Mortel()
	return terminer;

func devient_Mortel() -> bool:
	est_Invincible = false
	return est_Invincible;


func devient_Invicible(soigner: bool) -> bool:
	est_Invincible = true
	if(soigner):
		point_Vie_Actuel = max_Point_Vie
	return est_Invincible;

#Reflexion du HFrame selon position sourie
##Translation du colision box du au "flip"
func directionRegard(pointX : float) -> int:
	#Gauche
	if $".".position.x + 5 <= pointX:
		$Sprite.flip_h = false
		$CollisionShape2D.position.x = -7.00
		return 1;
	#Droite
	if $".".position.x - 5 > pointX:
		$Sprite.flip_h = true
		$CollisionShape2D.position.x = 7
		return -1;
	
	return 0;
	
func lancerKunai() -> bool:
	var sceneKunai = kunai.instance()
	add_child(sceneKunai)
	return true

func avoir_directionX() -> float:
	return Input.get_action_strength("Droite") - Input.get_action_strength("Gauche")
	
func avoir_directionY() -> float:
	var directionY = -hauteurSaut if Input.is_action_just_pressed("Saut") and is_on_floor() else 1.0
	return directionY

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
