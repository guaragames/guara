extends Area2D

var selected3 = false
var mouse_offset3 = Vector2()
var caixa3 = Vector2(1241, 856)
var parada = false
var vibrating = false
var colidiu = false
@onready var clicou_som = $clicou
@onready var soltou_som = $soltou
@onready var cabo = $cabo


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if selected3 and !parada:
		if event is InputEventMouseMotion:
			# Atualize a posição com base no movimento do mouse
			position = event.position + mouse_offset3
			var movement_intensity = clamp(position.distance_to(mouse_offset3) / 100, 0, 1)
			Input.vibrate_handheld(movement_intensity)  # Ajustar intensidade da vibração conforme o movimento
			
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			mouse_offset3 = position - get_global_mouse_position()
			selected3 = true
			click_tomada()
		else:
			selected3 = false
			solta_tomada()
			

func _on_node_2d_encaixou() -> void:
	parada = true
	await get_tree().create_timer(0.5).timeout
	parada = false
	
func click_tomada():
	if colidiu == false:
		$click_tomada.stop()
		$click_tomada.play("click_tomada")
		cabo.stop()
		cabo.play()
		clicou_som.stop()
		clicou_som.play()

func solta_tomada():
	Input.vibrate_handheld(0)
	if colidiu == false:
		$click_tomada.stop()
		$click_tomada.play("solta_tomada")
		cabo.stop()
		soltou_som.stop()
		soltou_som.play()


func _on_body_entered(body: Node2D) -> void:
	colidiu = true
	if selected3 == true:
		$click_tomada.stop()
		$click_tomada.play("solta_tomada")
		cabo.stop()
		soltou_som.stop()
		soltou_som.play()
	
