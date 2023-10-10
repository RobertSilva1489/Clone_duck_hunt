extends KinematicBody2D
var lado = 1 # pato indo para direita
var vel = Vector2() # movimento horizontal
var speed = 100 # velocidade
var queda = 1 # movimento vertical
func _ready():
	$quack.wait_time = rand_range(0.8,2) # fazer som do pato em momentos aleatorio
	randomize() # melhorar a randomização 
	$movimento.wait_time = rand_range(0.4,2) # criando aleatoriedade
	$anima.wait_time = rand_range(0.6,1) # criando aleatoriedade
	

func _process(delta):
	#movimentação horizontal
	position.x += speed*lado *delta
	
	#movimentação vertical
	position.y -= 140*queda*delta
	
	#espelhamento da animação
	if lado < 0:
		$AnimatedSprite.flip_h = true # flipar a sprite para esquerda
	else:
		$AnimatedSprite.flip_h = false #flipar a sprite para direita

func _on_movimento_timeout():
	lado = lado *(-1) # mudar de direção


func _on_anima_timeout():
	if $AnimatedSprite.animation == "cima": #mudar de direção
		$AnimatedSprite.animation = "lado"
	elif $AnimatedSprite.animation == "lado": #mudar de direção
		$AnimatedSprite.animation = "cima"

func mata(): # eleminar o pato
	$AnimatedSprite.animation = "susto"
	$morte.start()



func _on_morte_timeout():
	$quack.stop() # controle para nao ter som do pato apos a morte
	$AnimatedSprite.animation = "morte"
	queda = - 1 # cair do ar
	lado = 0 # 0 para cair apenas na vertical
	


func _on_quack_timeout():
	$audio.play() #fazer tocar quando o time é disparado
