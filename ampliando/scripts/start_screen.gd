extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_jogar_pressed() -> void:
	$user_action.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://ampliando/scenes/main.tscn")


func _on_button_sair_pressed() -> void:
	$user_action.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/inicio.tscn")
