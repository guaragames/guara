extends Node2D

var vidas = 3

var pause_scene

var objeto = preload("res://acerte_o_formato/scenes/objeto.tscn")
var objeto_certo = false
var tempo = 0

func _ready() -> void:
	AcerteGlobal.score = 0
	$objeto.texture = load(AcerteGlobal.objeto_escolhido)

#spawn dos objetos
func _on_spawn_certo_timeout() -> void:
	objeto_certo = true


func _on_timer_spawn_timeout():
	var instanciar_objeto = objeto.instantiate()
	
	if objeto_certo:
		instanciar_objeto.objeto = AcerteGlobal.objeto_escolhido
		instanciar_objeto.get_node("objeto").texture = load(AcerteGlobal.objeto_escolhido)
		objeto_certo = false #reset
	else:
		AcerteGlobal.array_objetos.shuffle()
		instanciar_objeto.objeto = AcerteGlobal.array_objetos[0]
		instanciar_objeto.get_node("objeto").texture = load(AcerteGlobal.array_objetos[0])
	
	instanciar_objeto.connect("acertou", Callable(self, "acertou"))
	instanciar_objeto.connect("errou", Callable(self, "errou"))
	instanciar_objeto.connect("fora_da_tela", Callable(self, "fora_da_tela"))
	
	var x_min = 260  # Limite esquerdo
	var x_max = get_viewport_rect().size.x - 260  # Limite direito
	instanciar_objeto.position = Vector2(randf_range(x_min, x_max), randf_range(5, -30))
	
	#conta tempo para ir aumentando a dificuldade
	tempo += 3.0
	
	if tempo > 60:
		instanciar_objeto.speed = randi_range(140,170)
	
	if tempo == 60:
		$timer_spawn.wait_time = 2.5
		AcerteGlobal.nivel_2()
	
	if tempo == 120:
		$timer_spawn.wait_time = 2.2
		AcerteGlobal.nivel_3()
	
	add_child(instanciar_objeto)




func acertou() -> void:
	AcerteGlobal.score += 1
	$score.text = str(AcerteGlobal.score)


func errou() -> void:
	vidas -= 1
	match vidas:
		2:
			$vidas.texture = load("res://acerte_o_formato/assets/vidas/2_vidas.png")
		1:
			$vidas.texture = load("res://acerte_o_formato/assets/vidas/1_vida.png")
		0:
			$vidas.texture = load("res://acerte_o_formato/assets/vidas/0_vidas.png")
			await get_tree().create_timer(0.2).timeout
			get_tree().change_scene_to_file("res://acerte_o_formato/scenes/fim.tscn")

func fora_da_tela() -> void:
	$negativo.play()
	errou()


func _on_pause_botao_pressed() -> void:
	$click.play()
	await get_tree().create_timer(0.15).timeout
	pause_scene = load("res://acerte_o_formato/scenes/pause.tscn").instantiate()
	add_child(pause_scene)
	get_tree().paused = true
