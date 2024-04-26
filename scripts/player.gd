extends CharacterBody2D

@onready var texture : = $Animacao as AnimatedSprite2D
@onready var ray := $RayCast2D as RayCast2D
@export var walk_speed = 4.0
@onready var trans := $Cam/Transition/AnimTransition as AnimationPlayer
@onready var trans2 = $Cam/Transition2/AnimTransition
@onready var mask := $Cam/Transition/ColorRect as ColorRect
const TILE_SIZE = 16

var posicao_inicial = Vector2(0,0)
var input_direction = Vector2(0,0)
var se_movendo = false
var percentual_movido_to_next_tile: float = 0.00
var esta_em_transition : bool = true
var pode_dar_tp = 0
var pos_tp : Vector2

func _ready():
	#quando começa ele define a pos inicial do player
	posicao_inicial = position
	add_to_group("player")

func _physics_process(delta):
	# a cada frame ele executa uma verificacao para ver se
	# o jogador esta parado
	if se_movendo == false:
		process_player_input()
	elif input_direction != Vector2.ZERO:
		move(delta)
	else:
		se_movendo = false

func process_player_input():
	#basicamnete pega as direcoes de movimento
	if esta_em_transition:
		if input_direction.y == 0:
			input_direction.x = int(Input.get_action_strength("move_right") - Input.get_action_raw_strength("move_left"))
		if input_direction.x == 0:
			input_direction.y = int(Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
		if input_direction != Vector2.ZERO:
			posicao_inicial = position
			se_movendo = true
		
		if input_direction.x == 0 and input_direction.y == 0:
				texture.stop()
		if input_direction.x == 1:
			texture.play("dir")
				
		elif input_direction.x == -1:
			texture.play("esq")
				
		if input_direction.y == 1:
			texture.play("frente")
				
		elif input_direction.y == -1:
			texture.play("tras")
	else:
		return

func move(delta):
	var desired_step: Vector2 = input_direction * TILE_SIZE/2
	ray.target_position = desired_step
	ray.force_raycast_update()
	if !ray.is_colliding():
		percentual_movido_to_next_tile += walk_speed * delta
		if percentual_movido_to_next_tile >= 0.96:
			position = posicao_inicial + (TILE_SIZE * input_direction)
			percentual_movido_to_next_tile = 0.0
			se_movendo = false
		else:
			position = posicao_inicial + (TILE_SIZE * input_direction * percentual_movido_to_next_tile)
	else:
		percentual_movido_to_next_tile = 0.0
		se_movendo = false		



func _on_anim_transition_animation_finished(anim_name):
	esta_em_transition = true
	trans.stop()
	mask.color = Color(1,1,1,0)
	position = pos_tp
	
