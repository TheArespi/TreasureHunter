extends Node

var entities = {}
var treasure_acquired: bool = false
var game_finished: bool = false

signal interaction(interactor: String, interacted: String)

signal start_turn(name: String)
signal end_turn(name: String)

signal update_player_position(current_position: Vector2)

signal death(name: String)

signal equip(equiper: String, weapon: Weapon)

signal treasure_has_been_acquired()

signal game_over(success: bool)

func add_entity(entity_name: String, entity: Node):
	entities[entity_name] = entity
	print("Adding ", entity_name, " to entities")

func delete_entity(entity_name: String):
	entities.erase(entity_name)
	print("Removing ", entity_name, " from entities")

func toggle_treasure_acquired():
	treasure_acquired = true
	treasure_has_been_acquired.emit()

func toggle_game_over(success: bool):
	game_over.emit(success)
	game_finished = true

	if success:
		print("Game over! you managed to escape the dungeon with the treasure!")
	else:
		print("Game over! you died!")