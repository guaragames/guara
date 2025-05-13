extends Control
var estrelas_3 = TextureRect
var estrelas_1 = TextureRect
var estrelas_0 = TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	estrelas_3 = $"3_estrelas"
	estrelas_1 = $"1_estrelas"
	estrelas_0 = $"0_estrelas"
	
	verifica_estrelas(ConectandoGlobal.luz_verde)
	$aplausos.play(0.50)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func verifica_estrelas(cont:int):
	if cont == 3:
		estrelas_3.visible = true
	elif cont == 1:
		estrelas_1.visible = true
	else:
		estrelas_0.visible = true
