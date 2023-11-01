extends Node2D

var turn_queue = Array()

var current_turn: String = ""
var current_turn_done = false
var entity_information_class = preload("res://Scene/Components/EntityInformation/entity_information.gd")

func _ready():
	turn_queue.insert(0, $Player.get_node("EntityInformation").entity_name)
	GlobalStuff.end_turn.connect(current_turn_stop)
	GlobalStuff.death.connect(death)
	next_turn()
	
func _process(_delta):
	if current_turn_done and not GlobalStuff.game_finished:
		next_turn()
	
func next_turn():
	if current_turn != "":
		turn_queue.append(current_turn)
	current_turn = turn_queue.pop_front()
	current_turn_done = false
	GlobalStuff.start_turn.emit(current_turn)
	print("Current Turn: ", current_turn)
	
func current_turn_stop(_name: String):
	current_turn_done = true

func _on_mob_spawner_mob_spawning_done():
	for mob in $MobSpawner.get_children():
		turn_queue.append(mob.get_node("EntityInformation").entity_name)
		
func death(entity_name: String):
	turn_queue.erase(entity_name)
	
	if current_turn == entity_name:
		next_turn()

func game_over(_success: bool):
	pass