extends Control

var pokemon = preload("res://pokemons/6urubu_do_pix.tscn")
var instancia = pokemon.instantiate() 
var cenas = []

func _ready():
	add_child(instancia)
	
	
