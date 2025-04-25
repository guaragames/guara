extends Node

var array_objetos = ["res://acerte_o_formato/assets/objetos/quadrado_amarelo.png",
	"res://acerte_o_formato/assets/objetos/quadrado_ciano.png", "res://acerte_o_formato/assets/objetos/triangulo_azul.png", 
	"res://acerte_o_formato/assets/objetos/triangulo_laranja.png", "res://acerte_o_formato/assets/objetos/estrela_verde.png",
	"res://acerte_o_formato/assets/objetos/estrela_vermelha.png", "res://acerte_o_formato/assets/objetos/bola_vermelha.png",
	"res://acerte_o_formato/assets/objetos/bola_azul.png"]

var objeto_escolhido

var score = 0

func nivel_2():
	array_objetos.append("res://acerte_o_formato/assets/objetos/quadrado_roxo.png")
	array_objetos.append("res://acerte_o_formato/assets/objetos/triangulo_rosa.png")
	array_objetos.append("res://acerte_o_formato/assets/objetos/estrela_amarela.png")
	array_objetos.append("res://acerte_o_formato/assets/objetos/bola_verde.png")


func nivel_3():
	array_objetos.append("res://acerte_o_formato/assets/objetos/quadrado_vermelho.png")
	array_objetos.append("res://acerte_o_formato/assets/objetos/triangulo_verde.png")
	array_objetos.append("res://acerte_o_formato/assets/objetos/estrela_ciana.png")
	array_objetos.append("res://acerte_o_formato/assets/objetos/bola_amarela.png")
