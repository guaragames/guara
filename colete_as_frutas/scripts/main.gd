extends Node2D

@export var fruta_scene: PackedScene  # Cena dos morangos
@export var inimigo_scene: PackedScene  # Cena dos inimigos
@onready var timer_fruta = $Timer  # Timer para morangos
@onready var timer_inimigo = $Timer_inimigo  # Timer para inimigos
var frutas_coletadas = 0
var frutas_perdidas = 0
var limite = 1000
var bombas = 0
var teste = 0
var distancia_minima = 200  # Distância mínima entre fruta e inimigo
@onready var label = $contador
@onready var vidas = $vidas
@onready var ad_morango = $adicionar_numero
@onready var menos_bomba = $remover_numero
@onready var coleta = $coleta
@onready var negativo = $negativo
@onready var perdida = $perdida
@onready var click = $click
var cestaP = Area2D
var topo = Sprite2D
var cesta_c = Sprite2D
var v3 = Sprite2D
var v2 = Sprite2D
var v1 = Sprite2D
var v0 = Sprite2D
@onready var pause_layer = Control

var ultima_posicao_fruta = Vector2.ZERO  # Guarda a última posição da fruta

func _ready():
	reseta_global()
	pause_layer = $pause
	teste = ColeteGlobal.perdidas
	cestaP = $Cesta
	topo = $topo
	cesta_c = $cesta_cheia
	v3 = $"3_vidas"
	v2 = $"2_vidas"
	v1 = $"1_vidas"
	v0 = $"0_vidas"
	topo.z_index = 2  # Atribui um valor intermediário, maior que o do fundo
	label.z_index = 2
	cesta_c.z_index = 2
	v3.z_index = 2
	v2.z_index = 3
	v1.z_index = 4
	v0.z_index = 5
	label.anchor_right = 1.0  # Define a ancoragem da direita para a borda direita
	
	

		# Configuração do timer para os morangos
	timer_fruta.one_shot = false
	timer_fruta.wait_time = 3  # Tempo de espera entre morangos
	timer_fruta.start()
	timer_fruta.timeout.connect(self._on_TimerFruta_timeout)
	
	# Configuração do timer para os inimigos
	timer_inimigo.one_shot = false
	timer_inimigo.wait_time = 8  # Tempo de espera entre inimigos
	timer_inimigo.start()
	timer_inimigo.timeout.connect(self._on_Timer_inimigo_timeout)
	
	randomize()


func _process(delta: float) -> void:
	audio_fruta()
	verifica_fruta()
	
func audio_fruta():
	if ColeteGlobal.perdidas > 0:
		if teste != ColeteGlobal.perdidas:
			$negativo.play()
			teste = ColeteGlobal.perdidas
# Função chamada toda vez que o timer de frutas dá timeout
func _on_TimerFruta_timeout():
	gerar_fruta()

# Função chamada toda vez que o timer de inimigos dá timeout
func _on_Timer_inimigo_timeout():
	gerar_inimigo()
	

# Função para instanciar uma fruta em posição aleatória
func gerar_fruta():
	if fruta_scene == null:
		print("Erro: A variável 'fruta_scene' não foi atribuída.")
		return
	
	var nova_fruta = fruta_scene.instantiate()
	var posicao_x = randf_range(100, 1390)
	nova_fruta.position = Vector2(posicao_x, -80)
	
	add_child(nova_fruta)
	nova_fruta.z_index = 1  # Atribui um valor intermediário, maior que o do fundo
	# Salva a posição da fruta para evitar inimigos próximos
	ultima_posicao_fruta = nova_fruta.position

# Função para instanciar um inimigo em posição aleatória
func gerar_inimigo():
	if inimigo_scene == null:
		print("Erro: A variável 'inimigo_scene' não foi atribuída.")
		return
	
	var posicao_x = randf_range(100, 1390)

	# Garante que o inimigo não apareça muito perto da última fruta
	while abs(posicao_x - ultima_posicao_fruta.x) < distancia_minima:
		posicao_x = randf_range(100, 1390)  # Recalcula até que a distância seja segura

	var novo_inimigo = inimigo_scene.instantiate()
	novo_inimigo.position = Vector2(posicao_x, -80)
	
	add_child(novo_inimigo)

# Função para verificar se algo colidiu com a cesta
func _on_cesta_area_entered(area: Area2D) -> void:
	if area.is_in_group("frutas"):
		frutas_coletadas += 1
		$Cesta/Sprite2D/AnimationPlayer.stop()
		$Cesta/Sprite2D/AnimationPlayer.play("CESTA")
		adiciona_morango(frutas_coletadas)
		label.text = str(frutas_coletadas)
		posi_label(frutas_coletadas)
		area.queue_free()
	elif area.is_in_group("inimigos"):
		ColeteGlobal.perdidas += 1
		print(bombas)
		bombas += 1
		$Cesta/Sprite2D/AnimationPlayer.stop()
		$Cesta/Sprite2D/AnimationPlayer.play("CESTA")
		remove_bomba(bombas)
		area.queue_free()

# Função para verificar se frutas caíram fora da tela
func verifica_fruta():
	var vidas = 0 
	vidas = ColeteGlobal.perdidas
	if vidas == 1:
		v2.visible = true
	elif vidas == 2:
		v1.visible = true
	elif vidas == 3:
		v0.visible = true
		await get_tree().create_timer(0.3).timeout 
		game_over()

func adiciona_morango(numero):
	var quantidade = numero
	var posiC_atual = cestaP.global_position# Use get_node() para capturar a posição da cesta atual
	ad_morango.global_position = posiC_atual
	ad_morango.visible = true
	coleta.play()
	$adicionar_numero/AnimationPlayer.play("coleta")
	
func remove_bomba(q_bomba):
	var posiB_atual = cestaP.global_position
	var n_bomba = q_bomba
	menos_bomba.global_position = posiB_atual
	menos_bomba.visible = true
	negativo.play()
	$remover_numero/AnimationPlayer.play("coleta_-")
	
func posi_label(frutas):
	var dois_digitos = Vector2(1520, 23)
	var tres_digitos = Vector2(1500, 23)
	var c_frutas = frutas
	
	if c_frutas > 10:
		label.position = dois_digitos
	elif c_frutas > 100:
		label.position = tres_digitos
# Função chamada quando as vidas acabam

func reseta_global():
	ColeteGlobal.perdidas = -1

func game_over():
	ColeteGlobal.total = frutas_coletadas
	get_tree().change_scene_to_file("res://colete_as_frutas/scenes/game_over.tscn")


func _on_pause_but_pressed() -> void:
	click.play()
	await get_tree().create_timer(0.1).timeout 
	pause_layer.visible = true
	get_tree().paused = true


func _on_play_pause_pressed() -> void:
	click.play()
	pause_layer.visible = false
	get_tree().paused = false


func _on_restart_pause_pressed() -> void:
	click.play()
	pause_layer.visible = false
	get_tree().paused = false
	await get_tree().create_timer(0.2).timeout 
	get_tree().change_scene_to_file("res://colete_as_frutas/scenes/main.tscn")


func _on_quit_pause_pressed() -> void:
	click.play()
	pause_layer.visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://colete_as_frutas/scenes/start_game.tscn") 
