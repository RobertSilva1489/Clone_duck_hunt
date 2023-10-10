extends Node2D

var patosnatela #controlar o numero de patos instanciados
var pato = preload("res://Pato.tscn") # pegando a cena pato

var flyaway = 0 #pato fugiu
var capturados = 0 # contador de pontos


func _ready():
	$gerapato.start() # instacia o primeiro grupo de patos
func _process(delta):
	$Alvo.position.x = get_local_mouse_position().x # seguindo posição vertical do mouse
	$Alvo.position.y = get_local_mouse_position().y # seguindo posição horizontal do mouse
	$HUD/Label.text = str(capturados)
func nasce():
	var novop = pato.instance() # instanciando pato
	add_child(novop) # fazendo pato filho da mmain
	novop.position.x = rand_range(50,700) # fazendo nascer em posição horizontal aleatoria
	novop.position.y = 700 # fazendo nascer atras da grama
func _on_gerapato_timeout():
	patosnatela = int(rand_range(2,6)) # numero inteiros de patos que serão gerados
	for n in patosnatela:
		nasce()


func _on_espera_timeout():
	$gerapato.start() # chama o gertador de patos
	$novo_turno.play() # toca o som do inicio da rodada


func _on_topo_body_entered(body):
	$flyaway.play() # toca o som do pato fugiu
	flyaway = 1 # saiu da tela recebe 1
	patosnatela -= 1 # saiu da tela, menos 1 pato na tela
	atualizaturno()
	

func _on_chao_body_entered(body):
	$colidiu.play() # toca o com do pato capturado
	capturados += 1 # tiro certo no pato, mais um no contador
	patosnatela -= 1 # menos um pato na tela
	atualizaturno()
func atualizaturno():
	if (patosnatela == 0): # verifica se acabou aquela rodada
		$espera.start() # tempo de decidir se foi ou nao gameover
		if flyaway == 1:  # verificar se deu gameover
			$cao.play("rindo")
			$cao_rindo.play() #toca o som do cao rindo
			flyaway =0
			capturados = 0
		else:
			$cao.play("captura")
			$cao_captura.play() #toca o som do cao capturando
