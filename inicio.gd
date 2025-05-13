extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_botao_colete_as_frutas_pressed() -> void:
	$acao_usuario.play()
	await get_tree().create_timer(0.15).timeout
	get_tree().change_scene_to_file("res://colete_as_frutas/scenes/start_game.tscn")

func _on_botao_ampliando_pressed() -> void:
	$acao_usuario.play()
	await get_tree().create_timer(0.15).timeout
	get_tree().change_scene_to_file("res://ampliando/scenes/Start_screen.tscn")

func _on_botao_acerte_o_formato_pressed() -> void:
	$acao_usuario.play()
	await get_tree().create_timer(0.15).timeout
	get_tree().change_scene_to_file("res://acerte_o_formato/scenes/inicio.tscn")


func _on_botao_conectando_silabas_pressed() -> void:
	$acao_usuario.play()
	await get_tree().create_timer(0.15).timeout
	get_tree().change_scene_to_file("res://conectando/scenes/start_game.tscn")
