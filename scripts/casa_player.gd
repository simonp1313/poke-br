extends Node2D

@onready var player = $Quarto/Player

func _on_teleporte_para_fora_body_entered(body):
	player.trans2.play("transicao")
	print("entrou")
