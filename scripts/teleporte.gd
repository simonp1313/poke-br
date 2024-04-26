extends Area2D

@onready var jogador = get_parent().get_node("Player")
@onready var trans  = get_parent().get_node("Player/Cam/Transition/AnimTransition")

func _on_body_entered(body): 
	if body.is_in_group("player") and jogador.pode_dar_tp == 0:
		trans.play("transicao")
		jogador.esta_em_transition = false
		jogador.texture.stop()
		jogador.pode_dar_tp = 1
		jogador.pos_tp = Vector2(624,32)


func _on_body_exited(body):
	jogador.pode_dar_tp = 0
