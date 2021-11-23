extends Control


var ispause:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func actionPause() ->void:
	
	if Input.is_action_just_pressed("Pause"):
		if(ispause):
			hide()
			ispause = false
			get_tree().paused = false
		
		else:
			show()
			ispause = true
			get_tree().paused = true


func _process(_delta: float) -> void:
	actionPause()
