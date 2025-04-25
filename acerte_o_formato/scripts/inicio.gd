extends Node2D



func _on_botao_iniciar_pressed() -> void:
	$click.play()
	await get_tree().create_timer(0.30).timeout
	get_tree().change_scene_to_file("res://acerte_o_formato/scenes/objeto_escolhido.tscn")


func _on_botao_sair_pressed() -> void:
	$click.play()
	await get_tree().create_timer(0.30).timeout
	get_tree().change_scene_to_file("res://scenes/inicio.tscn")
