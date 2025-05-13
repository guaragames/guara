extends Node2D
var caixas = []  # Lista para armazenar referências das caixas
var posicao_caixa = [Vector2(1408, 231),Vector2(1408, 535),Vector2(1408, 842)]
var posicao_tomada = [Vector2(1243,241),Vector2(1243, 545),Vector2(1243, 852)]
var luz_verde = 0
var luz_verm = 0 
var luzes_total = 3
var t1 = false
var t2 = false
var t3 = false
var cabo_1 = Line2D
var cabo_2 = Line2D
var cabo_3 = Line2D
var tomadinha = Area2D
var tomadinha2 = Area2D
var tomadinha3 = Area2D
var tomadinhaInicial = Vector2()
var tomadinhaInicial2 = Vector2()
var tomadinhaInicial3 = Vector2()
@onready var musica_de_fundo = $acerto
@onready var acerto_som = $acerto
@onready var erro_som = $erro

#var cabo_incio = Vector2(-150, 600)
var diferença = Vector2(164,-12)


var resposta_correta = {
	"tomadinha": "box",
	"tomadinha2": "box2",
	"tomadinha3": "box3",
}
var caixa_indices = {}
#var labels = ["BA", "DA", "FA"] 
var labels = ["res://conectando/assets/objetos/banana.png", "res://conectando/assets/objetos/dado.png", "res://conectando/assets/objetos/faca.png"] 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cabo_1 = $cabo_1
	cabo_2 = $cabo_2
	cabo_3 = $cabo_3
	tomadinha = $tomadinha
	tomadinha2 = $tomadinha2
	tomadinha3 = $tomadinha3
	tomadinhaInicial = tomadinha.position
	tomadinhaInicial2 = tomadinha2.position
	tomadinhaInicial3 = tomadinha3.position
	#print(cabo_1.points[0])

	caixas.append($box)
	caixas.append($box2)
	caixas.append($box3)
	
	for i in range(caixas.size()):
		caixa_indices[caixas[i].name] = i
		 # Atualiza o texto do Label
		var label_node = caixas[i].get_node("Label")
		if label_node:
			label_node.texture = ResourceLoader.load(labels[i])
	
	#funcao para embaralhar
	embaralhar_caixas()
	
func _process(delta: float) -> void:
	atualizaCabo()

func atualizaCabo():
	if tomadinha.position != tomadinhaInicial:
		var off1 = Vector2(597,240)
		var teste = tomadinha.position - off1
		cabo_1.points[1] = teste

	if tomadinha2.position != tomadinhaInicial2:
		var off2 = Vector2(597,545)
		var teste2 = tomadinha2.position - off2
		cabo_2.points[1] = teste2

	if tomadinha3.position != tomadinhaInicial3:
		var off3 = Vector2(597,850)
		var teste3 = tomadinha3.position - off3
		cabo_3.points[1] = teste3

func embaralhar_caixas():
	posicao_caixa.shuffle()

	for i in range(caixas.size()):
		caixas[i].position = posicao_caixa[i]

func _on_tomadinha_body_entered(body: Node2D) -> void:
	if body.name == "box":
		if t1 == false:
			verificar_conexao1(body,$tomadinha)
			t1 = true
	elif body.name == "box2":
		if t2 == false:
			verificar_conexao1(body,$tomadinha)
			t2 = true
	elif body.name == "box3":
		if t3 == false:
			verificar_conexao1(body,$tomadinha)
			t3 = true

func _on_tomadinha_2_body_entered(body: Node2D) -> void:
	if body.name == "box":
		if t1 == false:
			verificar_conexao2(body,$tomadinha2)
			t1 = true
	elif body.name == "box2":
		if t2 == false:
			verificar_conexao2(body,$tomadinha2)
			t2 = true
	elif body.name == "box3":
		if t3 == false:
			verificar_conexao2(body,$tomadinha2)
			t3 = true

func _on_tomadinha_3_body_entered(body: Node2D) -> void:
	if body.name == "box":
		if t1 == false:
			verificar_conexao3(body,$tomadinha3)
			t1 = true
				
	elif body.name == "box2":
		if t2 == false:
			verificar_conexao3(body,$tomadinha3)
			t2 = true
				
	elif body.name == "box3":
		if t3 == false:
			verificar_conexao3(body,$tomadinha3)
			t3 = true

func verificar_conexao1(body: Node2D, tomada: Area2D) -> void:
	var nome_caixa = body.name
	var nome_tomada = tomada.name
	var numero_caixa = caixa_indices[body.name]
	
	if nome_tomada in resposta_correta:
		var caixa_correta = resposta_correta[nome_tomada]
		if caixa_correta == nome_caixa:
			print("acertou")
			atualizaPodicao(numero_caixa, $tomadinha)
			atualizar_lampada(body, true)
		else:
			print("errou")
			atualizaPodicao(numero_caixa, $tomadinha)
			atualizar_lampada(body, false)
			
func verificar_conexao2(body: Node2D, tomada: Area2D) -> void:
	var nome_caixa = body.name
	var nome_tomada = tomada.name
	var numero_caixa = caixa_indices[body.name]
	
	if nome_tomada in resposta_correta:
		var caixa_correta = resposta_correta[nome_tomada]
		if caixa_correta == nome_caixa:
			print("acertou")
			atualizaPodicao(numero_caixa, $tomadinha2)
			atualizar_lampada(body, true)
		else:
			print("errou")
			atualizaPodicao(numero_caixa, $tomadinha2)
			atualizar_lampada(body, false)
			
func verificar_conexao3(body: Node2D, tomada: Area2D) -> void:
	var nome_caixa = body.name
	var nome_tomada = tomada.name
	var numero_caixa = caixa_indices[body.name]
	
	if nome_tomada in resposta_correta:
		var caixa_correta = resposta_correta[nome_tomada]
		if caixa_correta == nome_caixa:
			print("acertou")
			atualizaPodicao(numero_caixa, $tomadinha3)
			atualizar_lampada(body, true)
		else:
			print("errou")
			atualizaPodicao(numero_caixa, $tomadinha3)
			atualizar_lampada(body, false)
			
func atualizaPodicao(numero_caixa: int, e:Area2D):
	e.parada = true
	e.position = posicao_caixa[numero_caixa] - diferença
	
func atualizar_lampada(caixa: Node2D, tentativa:bool):
	var contador = []
	var verde = caixa.get_node("lampada_certa")
	var vermelha = caixa.get_node("lampada_errada")
	if tentativa == true:
		verde.visible = true
		luz_verde += 1
		acerto_som.play()
		verifica_fim(luz_verde, luz_verm)
		#verifica_fim(contador)
	else:
		vermelha.visible = true
		luz_verm += 1
		erro_som.play(8.78)
		verifica_fim(luz_verde, luz_verm)
		#verifica_fim(contador)
		
func verifica_fim(verde: int, verm:int):
	var ascesas = verde + verm
	print(verde)
	print(verm)
	if ascesas >= luzes_total:
		await get_tree().create_timer(0.5).timeout
		ConectandoGlobal.luz_verde = luz_verde
		get_tree().change_scene_to_file("res://conectando/scenes/game_over.tscn")  # Altera para a nova cena
