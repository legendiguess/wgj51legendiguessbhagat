extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_play_button_pressed():
	get_tree().change_scene("res://scenes/game.tscn")
	queue_free()
	pass # replace with function body


func _on_settings_button_pressed():
	$popup_settings.popup()
	pass # replace with function body


func _on_about_button_pressed():
	$popup_about.popup()
	pass # replace with function body


func _on_exit_button_pressed():
	get_tree().quit()
	pass # replace with function body
