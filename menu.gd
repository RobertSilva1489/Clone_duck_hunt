extends Control


func _ready() ->void:
	for button in get_tree().get_nodes_in_group("butao"):
		button.connect("pressed",self,"on_button_pressed",[button])
		$title_theme.start()

func on_button_pressed(button:Button) -> void:
	match button.name:
		"START":
			var _game: bool = get_tree().change_scene("res://Main.tscn")
		"EXIT":
			get_tree().quit()
func mouse_interaction(button:Button,state:String) -> void:
	match state:
		"exited":
			button.modulate.a = 1.0
		
		"entered":
			button.modulate.a = 0.5


func _on_title_theme_timeout():
	$AudioStreamPlayer2D.play()
