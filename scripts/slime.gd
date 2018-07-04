extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$"Scene Root/AnimationPlayer".play("default")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
