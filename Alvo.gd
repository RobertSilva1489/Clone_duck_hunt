extends Area2D

var patoatual #controlar ultimo pato que colidiu


func _ready():
	pass


func _on_Alvo_body_entered(body):
	patoatual = body # pegando o pato
	
func _input(event): # função para entrada de dados
	if Input.is_action_just_pressed("atirar"): #fazer atirar
		$AudioStreamPlayer2D.play()
		if patoatual == null: #controle de bug para tiro errado
			print("Miss")
		else:
			patoatual.mata() 
