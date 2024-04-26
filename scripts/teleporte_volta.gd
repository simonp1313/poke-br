extends Area2D

@onready var jogador := get_parent().get_parent().get_node("Quarto/Player")

func _on_body_entered(body):
	if body.is_in_group("player") and jogador.pode_dar_tp == 0:
		jogador.esta_em_transition = false
		jogador.texture.stop()
		jogador.trans.play("transicao")
		jogador.pode_dar_tp = 1
		jogador.pos_tp = Vector2(128,32)
	

func _on_body_exited(body):
	jogador.pode_dar_tp = 0

