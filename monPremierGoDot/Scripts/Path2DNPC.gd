extends Path2D
class_name pathSingulier

export(NodePath) var noeudSuiveur
onready var vitesseSuivie = 300
onready var cheminSuivie = get_node("PathFollow")
onready var _body = getBody()


func getBody() -> Node:
		return get_node_or_null(noeudSuiveur)

func setVitesseSuivie(noeudBody) -> void:
	if(getBody()):
		if(noeudBody.get_class() == "Npc"):
			vitesseSuivie = noeudBody.get_vitesseX()

func suivreChemin(_delta) -> void:
	if(getBody()):
		cheminSuivie.set_offset(cheminSuivie.get_offset() + vitesseSuivie * _delta)
		grosseGestionMouvementSuiveur(_delta)
		
func grosseGestionMouvementSuiveur(_delta) -> void:
	if(getBody().get_class() == "Npc"):
		getBody().velocite.x = vitesseSuivie * _delta

func _ready() -> void:
	setVitesseSuivie(_body)
	set_process(true)


func _process(delta: float) -> void:
	setVitesseSuivie(_body)
	suivreChemin(delta)
	
	if( !getBody() ):
		queue_free()
		
