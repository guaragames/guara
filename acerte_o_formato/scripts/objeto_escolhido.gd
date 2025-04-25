extends Node



func _ready() -> void:
	AcerteGlobal.array_objetos.shuffle()
	$objeto.texture = load(AcerteGlobal.array_objetos[0])
	AcerteGlobal.objeto_escolhido = AcerteGlobal.array_objetos[0]


func _on_ok_pressed() -> void:
	$click.play()
	await get_tree().create_timer(0.15).timeout
	get_tree().change_scene_to_file("res://acerte_o_formato/scenes/main.tscn")
